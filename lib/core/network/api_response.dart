/// Generic API response wrapper
class ApiResponse<T> {
  final bool success;
  final T? data;
  final String? message;
  final int? statusCode;
  final Map<String, dynamic>? errors;

  const ApiResponse({
    required this.success,
    this.data,
    this.message,
    this.statusCode,
    this.errors,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>)? fromJsonT,
  ) {
    return ApiResponse(
      success: json['success'] ?? true,
      data: json['data'] != null && fromJsonT != null
          ? fromJsonT(json['data'])
          : json['data'],
      message: json['message'],
      statusCode: json['statusCode'],
      errors: json['errors'],
    );
  }

  factory ApiResponse.success(T data, {String? message}) {
    return ApiResponse(success: true, data: data, message: message);
  }

  factory ApiResponse.failure(
    String message, {
    int? statusCode,
    Map<String, dynamic>? errors,
  }) {
    return ApiResponse(
      success: false,
      message: message,
      statusCode: statusCode,
      errors: errors,
    );
  }

  bool get hasData => data != null;
  bool get hasErrors => errors != null && errors!.isNotEmpty;
}

/// Paginated API response
class PaginatedResponse<T> {
  final List<T> items;
  final int currentPage;
  final int totalPages;
  final int totalItems;
  final int perPage;
  final bool hasNextPage;
  final bool hasPreviousPage;

  const PaginatedResponse({
    required this.items,
    required this.currentPage,
    required this.totalPages,
    required this.totalItems,
    required this.perPage,
    required this.hasNextPage,
    required this.hasPreviousPage,
  });

  factory PaginatedResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    final data = json['data'] as Map<String, dynamic>? ?? json;
    final itemsList =
        (data['items'] as List?) ?? (json['items'] as List?) ?? [];

    return PaginatedResponse(
      items: itemsList
          .map((e) => fromJsonT(e as Map<String, dynamic>))
          .toList(),
      currentPage: data['currentPage'] ?? data['page'] ?? 1,
      totalPages: data['totalPages'] ?? data['lastPage'] ?? 1,
      totalItems: data['totalItems'] ?? data['total'] ?? itemsList.length,
      perPage: data['perPage'] ?? data['limit'] ?? 20,
      hasNextPage:
          data['hasNextPage'] ??
          (data['currentPage'] ?? 1) < (data['totalPages'] ?? 1),
      hasPreviousPage:
          data['hasPreviousPage'] ?? (data['currentPage'] ?? 1) > 1,
    );
  }

  factory PaginatedResponse.empty() {
    return const PaginatedResponse(
      items: [],
      currentPage: 1,
      totalPages: 1,
      totalItems: 0,
      perPage: 20,
      hasNextPage: false,
      hasPreviousPage: false,
    );
  }

  bool get isEmpty => items.isEmpty;
  bool get isNotEmpty => items.isNotEmpty;
}
