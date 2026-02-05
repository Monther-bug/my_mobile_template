import 'package:dartz/dartz.dart';
import '../errors/failures.dart';

/// Base use case interface with parameters
abstract class UseCase<T, Params> {
  Future<Either<Failure, T>> call(Params params);
}

/// Use case without parameters
abstract class UseCaseNoParams<T> {
  Future<Either<Failure, T>> call();
}

/// Use case for streaming data
abstract class StreamUseCase<T, Params> {
  Stream<Either<Failure, T>> call(Params params);
}

/// Use case for streaming data without parameters
abstract class StreamUseCaseNoParams<T> {
  Stream<Either<Failure, T>> call();
}

/// No parameters class for use cases that don't need parameters
class NoParams {
  const NoParams();
}
