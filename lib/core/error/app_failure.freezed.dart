// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_failure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AppFailure {
  String get message => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, int? statusCode, String? code)
        server,
    required TResult Function(String message) network,
    required TResult Function(String message) cache,
    required TResult Function(String message, String? code) authentication,
    required TResult Function(
            String message, Map<String, List<String>>? fieldErrors)
        validation,
    required TResult Function(String message) permission,
    required TResult Function(String message) timeout,
    required TResult Function(
            String message, Object? error, StackTrace? stackTrace)
        unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, int? statusCode, String? code)? server,
    TResult? Function(String message)? network,
    TResult? Function(String message)? cache,
    TResult? Function(String message, String? code)? authentication,
    TResult? Function(String message, Map<String, List<String>>? fieldErrors)?
        validation,
    TResult? Function(String message)? permission,
    TResult? Function(String message)? timeout,
    TResult? Function(String message, Object? error, StackTrace? stackTrace)?
        unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, int? statusCode, String? code)? server,
    TResult Function(String message)? network,
    TResult Function(String message)? cache,
    TResult Function(String message, String? code)? authentication,
    TResult Function(String message, Map<String, List<String>>? fieldErrors)?
        validation,
    TResult Function(String message)? permission,
    TResult Function(String message)? timeout,
    TResult Function(String message, Object? error, StackTrace? stackTrace)?
        unknown,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ServerFailure value) server,
    required TResult Function(NetworkFailure value) network,
    required TResult Function(CacheFailure value) cache,
    required TResult Function(AuthenticationFailure value) authentication,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(PermissionFailure value) permission,
    required TResult Function(TimeoutFailure value) timeout,
    required TResult Function(UnknownFailure value) unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ServerFailure value)? server,
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(CacheFailure value)? cache,
    TResult? Function(AuthenticationFailure value)? authentication,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(PermissionFailure value)? permission,
    TResult? Function(TimeoutFailure value)? timeout,
    TResult? Function(UnknownFailure value)? unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ServerFailure value)? server,
    TResult Function(NetworkFailure value)? network,
    TResult Function(CacheFailure value)? cache,
    TResult Function(AuthenticationFailure value)? authentication,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(PermissionFailure value)? permission,
    TResult Function(TimeoutFailure value)? timeout,
    TResult Function(UnknownFailure value)? unknown,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AppFailureCopyWith<AppFailure> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppFailureCopyWith<$Res> {
  factory $AppFailureCopyWith(
          AppFailure value, $Res Function(AppFailure) then) =
      _$AppFailureCopyWithImpl<$Res, AppFailure>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class _$AppFailureCopyWithImpl<$Res, $Val extends AppFailure>
    implements $AppFailureCopyWith<$Res> {
  _$AppFailureCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_value.copyWith(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ServerFailureImplCopyWith<$Res>
    implements $AppFailureCopyWith<$Res> {
  factory _$$ServerFailureImplCopyWith(
          _$ServerFailureImpl value, $Res Function(_$ServerFailureImpl) then) =
      __$$ServerFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, int? statusCode, String? code});
}

/// @nodoc
class __$$ServerFailureImplCopyWithImpl<$Res>
    extends _$AppFailureCopyWithImpl<$Res, _$ServerFailureImpl>
    implements _$$ServerFailureImplCopyWith<$Res> {
  __$$ServerFailureImplCopyWithImpl(
      _$ServerFailureImpl _value, $Res Function(_$ServerFailureImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? statusCode = freezed,
    Object? code = freezed,
  }) {
    return _then(_$ServerFailureImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      statusCode: freezed == statusCode
          ? _value.statusCode
          : statusCode // ignore: cast_nullable_to_non_nullable
              as int?,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$ServerFailureImpl implements ServerFailure {
  const _$ServerFailureImpl(
      {required this.message, this.statusCode, this.code});

  @override
  final String message;
  @override
  final int? statusCode;
  @override
  final String? code;

  @override
  String toString() {
    return 'AppFailure.server(message: $message, statusCode: $statusCode, code: $code)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServerFailureImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.statusCode, statusCode) ||
                other.statusCode == statusCode) &&
            (identical(other.code, code) || other.code == code));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, statusCode, code);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ServerFailureImplCopyWith<_$ServerFailureImpl> get copyWith =>
      __$$ServerFailureImplCopyWithImpl<_$ServerFailureImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, int? statusCode, String? code)
        server,
    required TResult Function(String message) network,
    required TResult Function(String message) cache,
    required TResult Function(String message, String? code) authentication,
    required TResult Function(
            String message, Map<String, List<String>>? fieldErrors)
        validation,
    required TResult Function(String message) permission,
    required TResult Function(String message) timeout,
    required TResult Function(
            String message, Object? error, StackTrace? stackTrace)
        unknown,
  }) {
    return server(message, statusCode, code);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, int? statusCode, String? code)? server,
    TResult? Function(String message)? network,
    TResult? Function(String message)? cache,
    TResult? Function(String message, String? code)? authentication,
    TResult? Function(String message, Map<String, List<String>>? fieldErrors)?
        validation,
    TResult? Function(String message)? permission,
    TResult? Function(String message)? timeout,
    TResult? Function(String message, Object? error, StackTrace? stackTrace)?
        unknown,
  }) {
    return server?.call(message, statusCode, code);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, int? statusCode, String? code)? server,
    TResult Function(String message)? network,
    TResult Function(String message)? cache,
    TResult Function(String message, String? code)? authentication,
    TResult Function(String message, Map<String, List<String>>? fieldErrors)?
        validation,
    TResult Function(String message)? permission,
    TResult Function(String message)? timeout,
    TResult Function(String message, Object? error, StackTrace? stackTrace)?
        unknown,
    required TResult orElse(),
  }) {
    if (server != null) {
      return server(message, statusCode, code);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ServerFailure value) server,
    required TResult Function(NetworkFailure value) network,
    required TResult Function(CacheFailure value) cache,
    required TResult Function(AuthenticationFailure value) authentication,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(PermissionFailure value) permission,
    required TResult Function(TimeoutFailure value) timeout,
    required TResult Function(UnknownFailure value) unknown,
  }) {
    return server(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ServerFailure value)? server,
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(CacheFailure value)? cache,
    TResult? Function(AuthenticationFailure value)? authentication,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(PermissionFailure value)? permission,
    TResult? Function(TimeoutFailure value)? timeout,
    TResult? Function(UnknownFailure value)? unknown,
  }) {
    return server?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ServerFailure value)? server,
    TResult Function(NetworkFailure value)? network,
    TResult Function(CacheFailure value)? cache,
    TResult Function(AuthenticationFailure value)? authentication,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(PermissionFailure value)? permission,
    TResult Function(TimeoutFailure value)? timeout,
    TResult Function(UnknownFailure value)? unknown,
    required TResult orElse(),
  }) {
    if (server != null) {
      return server(this);
    }
    return orElse();
  }
}

abstract class ServerFailure implements AppFailure {
  const factory ServerFailure(
      {required final String message,
      final int? statusCode,
      final String? code}) = _$ServerFailureImpl;

  @override
  String get message;
  int? get statusCode;
  String? get code;
  @override
  @JsonKey(ignore: true)
  _$$ServerFailureImplCopyWith<_$ServerFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$NetworkFailureImplCopyWith<$Res>
    implements $AppFailureCopyWith<$Res> {
  factory _$$NetworkFailureImplCopyWith(_$NetworkFailureImpl value,
          $Res Function(_$NetworkFailureImpl) then) =
      __$$NetworkFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$NetworkFailureImplCopyWithImpl<$Res>
    extends _$AppFailureCopyWithImpl<$Res, _$NetworkFailureImpl>
    implements _$$NetworkFailureImplCopyWith<$Res> {
  __$$NetworkFailureImplCopyWithImpl(
      _$NetworkFailureImpl _value, $Res Function(_$NetworkFailureImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$NetworkFailureImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$NetworkFailureImpl implements NetworkFailure {
  const _$NetworkFailureImpl({this.message = 'No internet connection'});

  @override
  @JsonKey()
  final String message;

  @override
  String toString() {
    return 'AppFailure.network(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NetworkFailureImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NetworkFailureImplCopyWith<_$NetworkFailureImpl> get copyWith =>
      __$$NetworkFailureImplCopyWithImpl<_$NetworkFailureImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, int? statusCode, String? code)
        server,
    required TResult Function(String message) network,
    required TResult Function(String message) cache,
    required TResult Function(String message, String? code) authentication,
    required TResult Function(
            String message, Map<String, List<String>>? fieldErrors)
        validation,
    required TResult Function(String message) permission,
    required TResult Function(String message) timeout,
    required TResult Function(
            String message, Object? error, StackTrace? stackTrace)
        unknown,
  }) {
    return network(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, int? statusCode, String? code)? server,
    TResult? Function(String message)? network,
    TResult? Function(String message)? cache,
    TResult? Function(String message, String? code)? authentication,
    TResult? Function(String message, Map<String, List<String>>? fieldErrors)?
        validation,
    TResult? Function(String message)? permission,
    TResult? Function(String message)? timeout,
    TResult? Function(String message, Object? error, StackTrace? stackTrace)?
        unknown,
  }) {
    return network?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, int? statusCode, String? code)? server,
    TResult Function(String message)? network,
    TResult Function(String message)? cache,
    TResult Function(String message, String? code)? authentication,
    TResult Function(String message, Map<String, List<String>>? fieldErrors)?
        validation,
    TResult Function(String message)? permission,
    TResult Function(String message)? timeout,
    TResult Function(String message, Object? error, StackTrace? stackTrace)?
        unknown,
    required TResult orElse(),
  }) {
    if (network != null) {
      return network(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ServerFailure value) server,
    required TResult Function(NetworkFailure value) network,
    required TResult Function(CacheFailure value) cache,
    required TResult Function(AuthenticationFailure value) authentication,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(PermissionFailure value) permission,
    required TResult Function(TimeoutFailure value) timeout,
    required TResult Function(UnknownFailure value) unknown,
  }) {
    return network(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ServerFailure value)? server,
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(CacheFailure value)? cache,
    TResult? Function(AuthenticationFailure value)? authentication,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(PermissionFailure value)? permission,
    TResult? Function(TimeoutFailure value)? timeout,
    TResult? Function(UnknownFailure value)? unknown,
  }) {
    return network?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ServerFailure value)? server,
    TResult Function(NetworkFailure value)? network,
    TResult Function(CacheFailure value)? cache,
    TResult Function(AuthenticationFailure value)? authentication,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(PermissionFailure value)? permission,
    TResult Function(TimeoutFailure value)? timeout,
    TResult Function(UnknownFailure value)? unknown,
    required TResult orElse(),
  }) {
    if (network != null) {
      return network(this);
    }
    return orElse();
  }
}

abstract class NetworkFailure implements AppFailure {
  const factory NetworkFailure({final String message}) = _$NetworkFailureImpl;

  @override
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$NetworkFailureImplCopyWith<_$NetworkFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CacheFailureImplCopyWith<$Res>
    implements $AppFailureCopyWith<$Res> {
  factory _$$CacheFailureImplCopyWith(
          _$CacheFailureImpl value, $Res Function(_$CacheFailureImpl) then) =
      __$$CacheFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$CacheFailureImplCopyWithImpl<$Res>
    extends _$AppFailureCopyWithImpl<$Res, _$CacheFailureImpl>
    implements _$$CacheFailureImplCopyWith<$Res> {
  __$$CacheFailureImplCopyWithImpl(
      _$CacheFailureImpl _value, $Res Function(_$CacheFailureImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$CacheFailureImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$CacheFailureImpl implements CacheFailure {
  const _$CacheFailureImpl({this.message = 'Cache operation failed'});

  @override
  @JsonKey()
  final String message;

  @override
  String toString() {
    return 'AppFailure.cache(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CacheFailureImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CacheFailureImplCopyWith<_$CacheFailureImpl> get copyWith =>
      __$$CacheFailureImplCopyWithImpl<_$CacheFailureImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, int? statusCode, String? code)
        server,
    required TResult Function(String message) network,
    required TResult Function(String message) cache,
    required TResult Function(String message, String? code) authentication,
    required TResult Function(
            String message, Map<String, List<String>>? fieldErrors)
        validation,
    required TResult Function(String message) permission,
    required TResult Function(String message) timeout,
    required TResult Function(
            String message, Object? error, StackTrace? stackTrace)
        unknown,
  }) {
    return cache(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, int? statusCode, String? code)? server,
    TResult? Function(String message)? network,
    TResult? Function(String message)? cache,
    TResult? Function(String message, String? code)? authentication,
    TResult? Function(String message, Map<String, List<String>>? fieldErrors)?
        validation,
    TResult? Function(String message)? permission,
    TResult? Function(String message)? timeout,
    TResult? Function(String message, Object? error, StackTrace? stackTrace)?
        unknown,
  }) {
    return cache?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, int? statusCode, String? code)? server,
    TResult Function(String message)? network,
    TResult Function(String message)? cache,
    TResult Function(String message, String? code)? authentication,
    TResult Function(String message, Map<String, List<String>>? fieldErrors)?
        validation,
    TResult Function(String message)? permission,
    TResult Function(String message)? timeout,
    TResult Function(String message, Object? error, StackTrace? stackTrace)?
        unknown,
    required TResult orElse(),
  }) {
    if (cache != null) {
      return cache(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ServerFailure value) server,
    required TResult Function(NetworkFailure value) network,
    required TResult Function(CacheFailure value) cache,
    required TResult Function(AuthenticationFailure value) authentication,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(PermissionFailure value) permission,
    required TResult Function(TimeoutFailure value) timeout,
    required TResult Function(UnknownFailure value) unknown,
  }) {
    return cache(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ServerFailure value)? server,
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(CacheFailure value)? cache,
    TResult? Function(AuthenticationFailure value)? authentication,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(PermissionFailure value)? permission,
    TResult? Function(TimeoutFailure value)? timeout,
    TResult? Function(UnknownFailure value)? unknown,
  }) {
    return cache?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ServerFailure value)? server,
    TResult Function(NetworkFailure value)? network,
    TResult Function(CacheFailure value)? cache,
    TResult Function(AuthenticationFailure value)? authentication,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(PermissionFailure value)? permission,
    TResult Function(TimeoutFailure value)? timeout,
    TResult Function(UnknownFailure value)? unknown,
    required TResult orElse(),
  }) {
    if (cache != null) {
      return cache(this);
    }
    return orElse();
  }
}

abstract class CacheFailure implements AppFailure {
  const factory CacheFailure({final String message}) = _$CacheFailureImpl;

  @override
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$CacheFailureImplCopyWith<_$CacheFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AuthenticationFailureImplCopyWith<$Res>
    implements $AppFailureCopyWith<$Res> {
  factory _$$AuthenticationFailureImplCopyWith(
          _$AuthenticationFailureImpl value,
          $Res Function(_$AuthenticationFailureImpl) then) =
      __$$AuthenticationFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, String? code});
}

/// @nodoc
class __$$AuthenticationFailureImplCopyWithImpl<$Res>
    extends _$AppFailureCopyWithImpl<$Res, _$AuthenticationFailureImpl>
    implements _$$AuthenticationFailureImplCopyWith<$Res> {
  __$$AuthenticationFailureImplCopyWithImpl(_$AuthenticationFailureImpl _value,
      $Res Function(_$AuthenticationFailureImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? code = freezed,
  }) {
    return _then(_$AuthenticationFailureImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$AuthenticationFailureImpl implements AuthenticationFailure {
  const _$AuthenticationFailureImpl(
      {this.message = 'Authentication failed', this.code});

  @override
  @JsonKey()
  final String message;
  @override
  final String? code;

  @override
  String toString() {
    return 'AppFailure.authentication(message: $message, code: $code)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthenticationFailureImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.code, code) || other.code == code));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, code);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthenticationFailureImplCopyWith<_$AuthenticationFailureImpl>
      get copyWith => __$$AuthenticationFailureImplCopyWithImpl<
          _$AuthenticationFailureImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, int? statusCode, String? code)
        server,
    required TResult Function(String message) network,
    required TResult Function(String message) cache,
    required TResult Function(String message, String? code) authentication,
    required TResult Function(
            String message, Map<String, List<String>>? fieldErrors)
        validation,
    required TResult Function(String message) permission,
    required TResult Function(String message) timeout,
    required TResult Function(
            String message, Object? error, StackTrace? stackTrace)
        unknown,
  }) {
    return authentication(message, code);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, int? statusCode, String? code)? server,
    TResult? Function(String message)? network,
    TResult? Function(String message)? cache,
    TResult? Function(String message, String? code)? authentication,
    TResult? Function(String message, Map<String, List<String>>? fieldErrors)?
        validation,
    TResult? Function(String message)? permission,
    TResult? Function(String message)? timeout,
    TResult? Function(String message, Object? error, StackTrace? stackTrace)?
        unknown,
  }) {
    return authentication?.call(message, code);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, int? statusCode, String? code)? server,
    TResult Function(String message)? network,
    TResult Function(String message)? cache,
    TResult Function(String message, String? code)? authentication,
    TResult Function(String message, Map<String, List<String>>? fieldErrors)?
        validation,
    TResult Function(String message)? permission,
    TResult Function(String message)? timeout,
    TResult Function(String message, Object? error, StackTrace? stackTrace)?
        unknown,
    required TResult orElse(),
  }) {
    if (authentication != null) {
      return authentication(message, code);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ServerFailure value) server,
    required TResult Function(NetworkFailure value) network,
    required TResult Function(CacheFailure value) cache,
    required TResult Function(AuthenticationFailure value) authentication,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(PermissionFailure value) permission,
    required TResult Function(TimeoutFailure value) timeout,
    required TResult Function(UnknownFailure value) unknown,
  }) {
    return authentication(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ServerFailure value)? server,
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(CacheFailure value)? cache,
    TResult? Function(AuthenticationFailure value)? authentication,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(PermissionFailure value)? permission,
    TResult? Function(TimeoutFailure value)? timeout,
    TResult? Function(UnknownFailure value)? unknown,
  }) {
    return authentication?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ServerFailure value)? server,
    TResult Function(NetworkFailure value)? network,
    TResult Function(CacheFailure value)? cache,
    TResult Function(AuthenticationFailure value)? authentication,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(PermissionFailure value)? permission,
    TResult Function(TimeoutFailure value)? timeout,
    TResult Function(UnknownFailure value)? unknown,
    required TResult orElse(),
  }) {
    if (authentication != null) {
      return authentication(this);
    }
    return orElse();
  }
}

abstract class AuthenticationFailure implements AppFailure {
  const factory AuthenticationFailure(
      {final String message, final String? code}) = _$AuthenticationFailureImpl;

  @override
  String get message;
  String? get code;
  @override
  @JsonKey(ignore: true)
  _$$AuthenticationFailureImplCopyWith<_$AuthenticationFailureImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ValidationFailureImplCopyWith<$Res>
    implements $AppFailureCopyWith<$Res> {
  factory _$$ValidationFailureImplCopyWith(_$ValidationFailureImpl value,
          $Res Function(_$ValidationFailureImpl) then) =
      __$$ValidationFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, Map<String, List<String>>? fieldErrors});
}

/// @nodoc
class __$$ValidationFailureImplCopyWithImpl<$Res>
    extends _$AppFailureCopyWithImpl<$Res, _$ValidationFailureImpl>
    implements _$$ValidationFailureImplCopyWith<$Res> {
  __$$ValidationFailureImplCopyWithImpl(_$ValidationFailureImpl _value,
      $Res Function(_$ValidationFailureImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? fieldErrors = freezed,
  }) {
    return _then(_$ValidationFailureImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      fieldErrors: freezed == fieldErrors
          ? _value._fieldErrors
          : fieldErrors // ignore: cast_nullable_to_non_nullable
              as Map<String, List<String>>?,
    ));
  }
}

/// @nodoc

class _$ValidationFailureImpl implements ValidationFailure {
  const _$ValidationFailureImpl(
      {required this.message, final Map<String, List<String>>? fieldErrors})
      : _fieldErrors = fieldErrors;

  @override
  final String message;
  final Map<String, List<String>>? _fieldErrors;
  @override
  Map<String, List<String>>? get fieldErrors {
    final value = _fieldErrors;
    if (value == null) return null;
    if (_fieldErrors is EqualUnmodifiableMapView) return _fieldErrors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'AppFailure.validation(message: $message, fieldErrors: $fieldErrors)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ValidationFailureImpl &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality()
                .equals(other._fieldErrors, _fieldErrors));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, message, const DeepCollectionEquality().hash(_fieldErrors));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ValidationFailureImplCopyWith<_$ValidationFailureImpl> get copyWith =>
      __$$ValidationFailureImplCopyWithImpl<_$ValidationFailureImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, int? statusCode, String? code)
        server,
    required TResult Function(String message) network,
    required TResult Function(String message) cache,
    required TResult Function(String message, String? code) authentication,
    required TResult Function(
            String message, Map<String, List<String>>? fieldErrors)
        validation,
    required TResult Function(String message) permission,
    required TResult Function(String message) timeout,
    required TResult Function(
            String message, Object? error, StackTrace? stackTrace)
        unknown,
  }) {
    return validation(message, fieldErrors);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, int? statusCode, String? code)? server,
    TResult? Function(String message)? network,
    TResult? Function(String message)? cache,
    TResult? Function(String message, String? code)? authentication,
    TResult? Function(String message, Map<String, List<String>>? fieldErrors)?
        validation,
    TResult? Function(String message)? permission,
    TResult? Function(String message)? timeout,
    TResult? Function(String message, Object? error, StackTrace? stackTrace)?
        unknown,
  }) {
    return validation?.call(message, fieldErrors);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, int? statusCode, String? code)? server,
    TResult Function(String message)? network,
    TResult Function(String message)? cache,
    TResult Function(String message, String? code)? authentication,
    TResult Function(String message, Map<String, List<String>>? fieldErrors)?
        validation,
    TResult Function(String message)? permission,
    TResult Function(String message)? timeout,
    TResult Function(String message, Object? error, StackTrace? stackTrace)?
        unknown,
    required TResult orElse(),
  }) {
    if (validation != null) {
      return validation(message, fieldErrors);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ServerFailure value) server,
    required TResult Function(NetworkFailure value) network,
    required TResult Function(CacheFailure value) cache,
    required TResult Function(AuthenticationFailure value) authentication,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(PermissionFailure value) permission,
    required TResult Function(TimeoutFailure value) timeout,
    required TResult Function(UnknownFailure value) unknown,
  }) {
    return validation(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ServerFailure value)? server,
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(CacheFailure value)? cache,
    TResult? Function(AuthenticationFailure value)? authentication,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(PermissionFailure value)? permission,
    TResult? Function(TimeoutFailure value)? timeout,
    TResult? Function(UnknownFailure value)? unknown,
  }) {
    return validation?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ServerFailure value)? server,
    TResult Function(NetworkFailure value)? network,
    TResult Function(CacheFailure value)? cache,
    TResult Function(AuthenticationFailure value)? authentication,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(PermissionFailure value)? permission,
    TResult Function(TimeoutFailure value)? timeout,
    TResult Function(UnknownFailure value)? unknown,
    required TResult orElse(),
  }) {
    if (validation != null) {
      return validation(this);
    }
    return orElse();
  }
}

abstract class ValidationFailure implements AppFailure {
  const factory ValidationFailure(
      {required final String message,
      final Map<String, List<String>>? fieldErrors}) = _$ValidationFailureImpl;

  @override
  String get message;
  Map<String, List<String>>? get fieldErrors;
  @override
  @JsonKey(ignore: true)
  _$$ValidationFailureImplCopyWith<_$ValidationFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PermissionFailureImplCopyWith<$Res>
    implements $AppFailureCopyWith<$Res> {
  factory _$$PermissionFailureImplCopyWith(_$PermissionFailureImpl value,
          $Res Function(_$PermissionFailureImpl) then) =
      __$$PermissionFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$PermissionFailureImplCopyWithImpl<$Res>
    extends _$AppFailureCopyWithImpl<$Res, _$PermissionFailureImpl>
    implements _$$PermissionFailureImplCopyWith<$Res> {
  __$$PermissionFailureImplCopyWithImpl(_$PermissionFailureImpl _value,
      $Res Function(_$PermissionFailureImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$PermissionFailureImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$PermissionFailureImpl implements PermissionFailure {
  const _$PermissionFailureImpl({this.message = 'Permission denied'});

  @override
  @JsonKey()
  final String message;

  @override
  String toString() {
    return 'AppFailure.permission(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PermissionFailureImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PermissionFailureImplCopyWith<_$PermissionFailureImpl> get copyWith =>
      __$$PermissionFailureImplCopyWithImpl<_$PermissionFailureImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, int? statusCode, String? code)
        server,
    required TResult Function(String message) network,
    required TResult Function(String message) cache,
    required TResult Function(String message, String? code) authentication,
    required TResult Function(
            String message, Map<String, List<String>>? fieldErrors)
        validation,
    required TResult Function(String message) permission,
    required TResult Function(String message) timeout,
    required TResult Function(
            String message, Object? error, StackTrace? stackTrace)
        unknown,
  }) {
    return permission(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, int? statusCode, String? code)? server,
    TResult? Function(String message)? network,
    TResult? Function(String message)? cache,
    TResult? Function(String message, String? code)? authentication,
    TResult? Function(String message, Map<String, List<String>>? fieldErrors)?
        validation,
    TResult? Function(String message)? permission,
    TResult? Function(String message)? timeout,
    TResult? Function(String message, Object? error, StackTrace? stackTrace)?
        unknown,
  }) {
    return permission?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, int? statusCode, String? code)? server,
    TResult Function(String message)? network,
    TResult Function(String message)? cache,
    TResult Function(String message, String? code)? authentication,
    TResult Function(String message, Map<String, List<String>>? fieldErrors)?
        validation,
    TResult Function(String message)? permission,
    TResult Function(String message)? timeout,
    TResult Function(String message, Object? error, StackTrace? stackTrace)?
        unknown,
    required TResult orElse(),
  }) {
    if (permission != null) {
      return permission(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ServerFailure value) server,
    required TResult Function(NetworkFailure value) network,
    required TResult Function(CacheFailure value) cache,
    required TResult Function(AuthenticationFailure value) authentication,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(PermissionFailure value) permission,
    required TResult Function(TimeoutFailure value) timeout,
    required TResult Function(UnknownFailure value) unknown,
  }) {
    return permission(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ServerFailure value)? server,
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(CacheFailure value)? cache,
    TResult? Function(AuthenticationFailure value)? authentication,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(PermissionFailure value)? permission,
    TResult? Function(TimeoutFailure value)? timeout,
    TResult? Function(UnknownFailure value)? unknown,
  }) {
    return permission?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ServerFailure value)? server,
    TResult Function(NetworkFailure value)? network,
    TResult Function(CacheFailure value)? cache,
    TResult Function(AuthenticationFailure value)? authentication,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(PermissionFailure value)? permission,
    TResult Function(TimeoutFailure value)? timeout,
    TResult Function(UnknownFailure value)? unknown,
    required TResult orElse(),
  }) {
    if (permission != null) {
      return permission(this);
    }
    return orElse();
  }
}

abstract class PermissionFailure implements AppFailure {
  const factory PermissionFailure({final String message}) =
      _$PermissionFailureImpl;

  @override
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$PermissionFailureImplCopyWith<_$PermissionFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TimeoutFailureImplCopyWith<$Res>
    implements $AppFailureCopyWith<$Res> {
  factory _$$TimeoutFailureImplCopyWith(_$TimeoutFailureImpl value,
          $Res Function(_$TimeoutFailureImpl) then) =
      __$$TimeoutFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$TimeoutFailureImplCopyWithImpl<$Res>
    extends _$AppFailureCopyWithImpl<$Res, _$TimeoutFailureImpl>
    implements _$$TimeoutFailureImplCopyWith<$Res> {
  __$$TimeoutFailureImplCopyWithImpl(
      _$TimeoutFailureImpl _value, $Res Function(_$TimeoutFailureImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$TimeoutFailureImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$TimeoutFailureImpl implements TimeoutFailure {
  const _$TimeoutFailureImpl({this.message = 'Request timed out'});

  @override
  @JsonKey()
  final String message;

  @override
  String toString() {
    return 'AppFailure.timeout(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TimeoutFailureImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TimeoutFailureImplCopyWith<_$TimeoutFailureImpl> get copyWith =>
      __$$TimeoutFailureImplCopyWithImpl<_$TimeoutFailureImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, int? statusCode, String? code)
        server,
    required TResult Function(String message) network,
    required TResult Function(String message) cache,
    required TResult Function(String message, String? code) authentication,
    required TResult Function(
            String message, Map<String, List<String>>? fieldErrors)
        validation,
    required TResult Function(String message) permission,
    required TResult Function(String message) timeout,
    required TResult Function(
            String message, Object? error, StackTrace? stackTrace)
        unknown,
  }) {
    return timeout(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, int? statusCode, String? code)? server,
    TResult? Function(String message)? network,
    TResult? Function(String message)? cache,
    TResult? Function(String message, String? code)? authentication,
    TResult? Function(String message, Map<String, List<String>>? fieldErrors)?
        validation,
    TResult? Function(String message)? permission,
    TResult? Function(String message)? timeout,
    TResult? Function(String message, Object? error, StackTrace? stackTrace)?
        unknown,
  }) {
    return timeout?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, int? statusCode, String? code)? server,
    TResult Function(String message)? network,
    TResult Function(String message)? cache,
    TResult Function(String message, String? code)? authentication,
    TResult Function(String message, Map<String, List<String>>? fieldErrors)?
        validation,
    TResult Function(String message)? permission,
    TResult Function(String message)? timeout,
    TResult Function(String message, Object? error, StackTrace? stackTrace)?
        unknown,
    required TResult orElse(),
  }) {
    if (timeout != null) {
      return timeout(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ServerFailure value) server,
    required TResult Function(NetworkFailure value) network,
    required TResult Function(CacheFailure value) cache,
    required TResult Function(AuthenticationFailure value) authentication,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(PermissionFailure value) permission,
    required TResult Function(TimeoutFailure value) timeout,
    required TResult Function(UnknownFailure value) unknown,
  }) {
    return timeout(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ServerFailure value)? server,
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(CacheFailure value)? cache,
    TResult? Function(AuthenticationFailure value)? authentication,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(PermissionFailure value)? permission,
    TResult? Function(TimeoutFailure value)? timeout,
    TResult? Function(UnknownFailure value)? unknown,
  }) {
    return timeout?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ServerFailure value)? server,
    TResult Function(NetworkFailure value)? network,
    TResult Function(CacheFailure value)? cache,
    TResult Function(AuthenticationFailure value)? authentication,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(PermissionFailure value)? permission,
    TResult Function(TimeoutFailure value)? timeout,
    TResult Function(UnknownFailure value)? unknown,
    required TResult orElse(),
  }) {
    if (timeout != null) {
      return timeout(this);
    }
    return orElse();
  }
}

abstract class TimeoutFailure implements AppFailure {
  const factory TimeoutFailure({final String message}) = _$TimeoutFailureImpl;

  @override
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$TimeoutFailureImplCopyWith<_$TimeoutFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UnknownFailureImplCopyWith<$Res>
    implements $AppFailureCopyWith<$Res> {
  factory _$$UnknownFailureImplCopyWith(_$UnknownFailureImpl value,
          $Res Function(_$UnknownFailureImpl) then) =
      __$$UnknownFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, Object? error, StackTrace? stackTrace});
}

/// @nodoc
class __$$UnknownFailureImplCopyWithImpl<$Res>
    extends _$AppFailureCopyWithImpl<$Res, _$UnknownFailureImpl>
    implements _$$UnknownFailureImplCopyWith<$Res> {
  __$$UnknownFailureImplCopyWithImpl(
      _$UnknownFailureImpl _value, $Res Function(_$UnknownFailureImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? error = freezed,
    Object? stackTrace = freezed,
  }) {
    return _then(_$UnknownFailureImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      error: freezed == error ? _value.error : error,
      stackTrace: freezed == stackTrace
          ? _value.stackTrace
          : stackTrace // ignore: cast_nullable_to_non_nullable
              as StackTrace?,
    ));
  }
}

/// @nodoc

class _$UnknownFailureImpl implements UnknownFailure {
  const _$UnknownFailureImpl(
      {this.message = 'An unexpected error occurred',
      this.error,
      this.stackTrace});

  @override
  @JsonKey()
  final String message;
  @override
  final Object? error;
  @override
  final StackTrace? stackTrace;

  @override
  String toString() {
    return 'AppFailure.unknown(message: $message, error: $error, stackTrace: $stackTrace)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnknownFailureImpl &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other.error, error) &&
            (identical(other.stackTrace, stackTrace) ||
                other.stackTrace == stackTrace));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message,
      const DeepCollectionEquality().hash(error), stackTrace);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UnknownFailureImplCopyWith<_$UnknownFailureImpl> get copyWith =>
      __$$UnknownFailureImplCopyWithImpl<_$UnknownFailureImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, int? statusCode, String? code)
        server,
    required TResult Function(String message) network,
    required TResult Function(String message) cache,
    required TResult Function(String message, String? code) authentication,
    required TResult Function(
            String message, Map<String, List<String>>? fieldErrors)
        validation,
    required TResult Function(String message) permission,
    required TResult Function(String message) timeout,
    required TResult Function(
            String message, Object? error, StackTrace? stackTrace)
        unknown,
  }) {
    return unknown(message, error, stackTrace);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, int? statusCode, String? code)? server,
    TResult? Function(String message)? network,
    TResult? Function(String message)? cache,
    TResult? Function(String message, String? code)? authentication,
    TResult? Function(String message, Map<String, List<String>>? fieldErrors)?
        validation,
    TResult? Function(String message)? permission,
    TResult? Function(String message)? timeout,
    TResult? Function(String message, Object? error, StackTrace? stackTrace)?
        unknown,
  }) {
    return unknown?.call(message, error, stackTrace);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, int? statusCode, String? code)? server,
    TResult Function(String message)? network,
    TResult Function(String message)? cache,
    TResult Function(String message, String? code)? authentication,
    TResult Function(String message, Map<String, List<String>>? fieldErrors)?
        validation,
    TResult Function(String message)? permission,
    TResult Function(String message)? timeout,
    TResult Function(String message, Object? error, StackTrace? stackTrace)?
        unknown,
    required TResult orElse(),
  }) {
    if (unknown != null) {
      return unknown(message, error, stackTrace);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ServerFailure value) server,
    required TResult Function(NetworkFailure value) network,
    required TResult Function(CacheFailure value) cache,
    required TResult Function(AuthenticationFailure value) authentication,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(PermissionFailure value) permission,
    required TResult Function(TimeoutFailure value) timeout,
    required TResult Function(UnknownFailure value) unknown,
  }) {
    return unknown(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ServerFailure value)? server,
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(CacheFailure value)? cache,
    TResult? Function(AuthenticationFailure value)? authentication,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(PermissionFailure value)? permission,
    TResult? Function(TimeoutFailure value)? timeout,
    TResult? Function(UnknownFailure value)? unknown,
  }) {
    return unknown?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ServerFailure value)? server,
    TResult Function(NetworkFailure value)? network,
    TResult Function(CacheFailure value)? cache,
    TResult Function(AuthenticationFailure value)? authentication,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(PermissionFailure value)? permission,
    TResult Function(TimeoutFailure value)? timeout,
    TResult Function(UnknownFailure value)? unknown,
    required TResult orElse(),
  }) {
    if (unknown != null) {
      return unknown(this);
    }
    return orElse();
  }
}

abstract class UnknownFailure implements AppFailure {
  const factory UnknownFailure(
      {final String message,
      final Object? error,
      final StackTrace? stackTrace}) = _$UnknownFailureImpl;

  @override
  String get message;
  Object? get error;
  StackTrace? get stackTrace;
  @override
  @JsonKey(ignore: true)
  _$$UnknownFailureImplCopyWith<_$UnknownFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
