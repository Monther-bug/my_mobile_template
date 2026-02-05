import 'package:dartz/dartz.dart';

import '../errors/failures.dart';

/// Cache policy for data fetching
enum CachePolicy {
  /// Always fetch from network, ignore cache
  networkOnly,

  /// Try cache first, if miss then network
  cacheFirst,

  /// Try network first, if fails use cache
  networkFirst,

  /// Only use cache, never fetch from network
  cacheOnly,

  /// Fetch from network but return cache immediately while loading
  staleWhileRevalidate,
}

/// Base repository with caching support
abstract class CachingRepository<T> {
  /// Get data with caching policy
  Future<Either<Failure, T>> getData({
    required Future<T> Function() networkCall,
    required Future<T?> Function() cacheCall,
    required Future<void> Function(T data) saveToCache,
    CachePolicy policy = CachePolicy.networkFirst,
    Duration? cacheMaxAge,
  }) async {
    switch (policy) {
      case CachePolicy.networkOnly:
        return _fetchFromNetwork(networkCall, saveToCache);

      case CachePolicy.cacheFirst:
        return _cacheFirst(networkCall, cacheCall, saveToCache, cacheMaxAge);

      case CachePolicy.networkFirst:
        return _networkFirst(networkCall, cacheCall, saveToCache);

      case CachePolicy.cacheOnly:
        return _cacheOnly(cacheCall);

      case CachePolicy.staleWhileRevalidate:
        return _staleWhileRevalidate(networkCall, cacheCall, saveToCache);
    }
  }

  Future<Either<Failure, T>> _fetchFromNetwork(
    Future<T> Function() networkCall,
    Future<void> Function(T data) saveToCache,
  ) async {
    try {
      final data = await networkCall();
      await saveToCache(data);
      return Right(data);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, T>> _cacheFirst(
    Future<T> Function() networkCall,
    Future<T?> Function() cacheCall,
    Future<void> Function(T data) saveToCache,
    Duration? cacheMaxAge,
  ) async {
    try {
      final cached = await cacheCall();
      if (cached != null) {
        // Optionally check cache age here
        return Right(cached);
      }
      return _fetchFromNetwork(networkCall, saveToCache);
    } catch (e) {
      return _fetchFromNetwork(networkCall, saveToCache);
    }
  }

  Future<Either<Failure, T>> _networkFirst(
    Future<T> Function() networkCall,
    Future<T?> Function() cacheCall,
    Future<void> Function(T data) saveToCache,
  ) async {
    try {
      final data = await networkCall();
      await saveToCache(data);
      return Right(data);
    } catch (e) {
      // Network failed, try cache
      try {
        final cached = await cacheCall();
        if (cached != null) {
          return Right(cached);
        }
        return Left(CacheFailure(message: 'No cached data available'));
      } catch (_) {
        return Left(ServerFailure(message: e.toString()));
      }
    }
  }

  Future<Either<Failure, T>> _cacheOnly(
    Future<T?> Function() cacheCall,
  ) async {
    try {
      final cached = await cacheCall();
      if (cached != null) {
        return Right(cached);
      }
      return Left(CacheFailure(message: 'No cached data available'));
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, T>> _staleWhileRevalidate(
    Future<T> Function() networkCall,
    Future<T?> Function() cacheCall,
    Future<void> Function(T data) saveToCache,
  ) async {
    // Return cache immediately if available
    try {
      final cached = await cacheCall();
      if (cached != null) {
        // Fire and forget network call to refresh cache
        networkCall().then((data) => saveToCache(data)).catchError((_) {});
        return Right(cached);
      }
    } catch (_) {}

    // No cache, fetch from network
    return _fetchFromNetwork(networkCall, saveToCache);
  }
}

/// Cache entry with metadata
class CacheEntry<T> {
  final T data;
  final DateTime cachedAt;
  final Duration? maxAge;

  CacheEntry({
    required this.data,
    required this.cachedAt,
    this.maxAge,
  });

  bool get isExpired {
    if (maxAge == null) return false;
    return DateTime.now().difference(cachedAt) > maxAge!;
  }

  bool get isValid => !isExpired;
}
