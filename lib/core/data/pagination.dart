import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Paginated data wrapper
class PaginatedData<T> {
  final List<T> items;
  final int currentPage;
  final int totalPages;
  final int totalItems;
  final bool hasMore;

  const PaginatedData({
    required this.items,
    required this.currentPage,
    required this.totalPages,
    required this.totalItems,
    required this.hasMore,
  });

  factory PaginatedData.empty() => const PaginatedData(
    items: [],
    currentPage: 0,
    totalPages: 0,
    totalItems: 0,
    hasMore: false,
  );

  factory PaginatedData.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    final items = (json['data'] as List)
        .map((e) => fromJson(e as Map<String, dynamic>))
        .toList();

    return PaginatedData(
      items: items,
      currentPage: json['current_page'] as int? ?? 1,
      totalPages: json['last_page'] as int? ?? 1,
      totalItems: json['total'] as int? ?? items.length,
      hasMore:
          (json['current_page'] as int? ?? 1) <
          (json['last_page'] as int? ?? 1),
    );
  }

  PaginatedData<T> copyWith({
    List<T>? items,
    int? currentPage,
    int? totalPages,
    int? totalItems,
    bool? hasMore,
  }) {
    return PaginatedData(
      items: items ?? this.items,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      totalItems: totalItems ?? this.totalItems,
      hasMore: hasMore ?? this.hasMore,
    );
  }

  /// Append new page to existing data
  PaginatedData<T> append(PaginatedData<T> newPage) {
    return PaginatedData(
      items: [...items, ...newPage.items],
      currentPage: newPage.currentPage,
      totalPages: newPage.totalPages,
      totalItems: newPage.totalItems,
      hasMore: newPage.hasMore,
    );
  }
}

/// Pagination state
class PaginationState<T> {
  final PaginatedData<T> data;
  final bool isLoading;
  final bool isLoadingMore;
  final String? error;

  const PaginationState({
    required this.data,
    this.isLoading = false,
    this.isLoadingMore = false,
    this.error,
  });

  factory PaginationState.initial() =>
      PaginationState(data: PaginatedData.empty());

  bool get isEmpty => data.items.isEmpty && !isLoading;
  bool get hasData => data.items.isNotEmpty;
  bool get hasError => error != null;
  bool get canLoadMore => data.hasMore && !isLoadingMore;

  PaginationState<T> copyWith({
    PaginatedData<T>? data,
    bool? isLoading,
    bool? isLoadingMore,
    String? error,
    bool clearError = false,
  }) {
    return PaginationState(
      data: data ?? this.data,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      error: clearError ? null : (error ?? this.error),
    );
  }
}

/// Base pagination notifier
abstract class PaginationNotifier<T> extends StateNotifier<PaginationState<T>> {
  PaginationNotifier() : super(PaginationState.initial());

  int _currentPage = 1;
  final int _perPage = 20;

  /// Fetch page from API
  Future<PaginatedData<T>> fetchPage(int page, int perPage);

  /// Initial load
  Future<void> load() async {
    state = state.copyWith(isLoading: true, clearError: true);
    _currentPage = 1;

    try {
      final data = await fetchPage(_currentPage, _perPage);
      state = state.copyWith(data: data, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  /// Load more items
  Future<void> loadMore() async {
    if (!state.canLoadMore) return;

    state = state.copyWith(isLoadingMore: true);
    _currentPage++;

    try {
      final newData = await fetchPage(_currentPage, _perPage);
      state = state.copyWith(
        data: state.data.append(newData),
        isLoadingMore: false,
      );
    } catch (e) {
      _currentPage--; // Revert page on error
      state = state.copyWith(isLoadingMore: false, error: e.toString());
    }
  }

  /// Refresh data
  Future<void> refresh() async {
    _currentPage = 1;
    state = state.copyWith(clearError: true);

    try {
      final data = await fetchPage(_currentPage, _perPage);
      state = state.copyWith(data: data);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }
}

/// Paginated list view widget
class PaginatedListView<T> extends StatelessWidget {
  final PaginationState<T> state;
  final Widget Function(BuildContext, T, int) itemBuilder;
  final VoidCallback onLoadMore;
  final VoidCallback onRefresh;
  final Widget? emptyWidget;
  final Widget? errorWidget;
  final Widget? loadingWidget;
  final Widget? loadingMoreWidget;
  final EdgeInsets? padding;
  final bool shrinkWrap;
  final ScrollPhysics? physics;

  const PaginatedListView({
    super.key,
    required this.state,
    required this.itemBuilder,
    required this.onLoadMore,
    required this.onRefresh,
    this.emptyWidget,
    this.errorWidget,
    this.loadingWidget,
    this.loadingMoreWidget,
    this.padding,
    this.shrinkWrap = false,
    this.physics,
  });

  @override
  Widget build(BuildContext context) {
    if (state.isLoading && state.data.items.isEmpty) {
      return loadingWidget ?? const Center(child: CircularProgressIndicator());
    }

    if (state.hasError && state.data.items.isEmpty) {
      return errorWidget ??
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(state.error ?? 'An error occurred'),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: onRefresh,
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
    }

    if (state.isEmpty) {
      return emptyWidget ?? const Center(child: Text('No items'));
    }

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollEndNotification) {
          if (notification.metrics.pixels >=
              notification.metrics.maxScrollExtent - 200) {
            onLoadMore();
          }
        }
        return false;
      },
      child: RefreshIndicator(
        onRefresh: () async => onRefresh(),
        child: ListView.builder(
          padding: padding,
          shrinkWrap: shrinkWrap,
          physics: physics,
          itemCount: state.data.items.length + (state.isLoadingMore ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == state.data.items.length) {
              return loadingMoreWidget ??
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(child: CircularProgressIndicator()),
                  );
            }
            return itemBuilder(context, state.data.items[index], index);
          },
        ),
      ),
    );
  }
}
