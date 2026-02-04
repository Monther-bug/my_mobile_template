import 'package:dartz/dartz.dart';
import '../errors/failures.dart';

/// Base use case interface with parameters
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

/// Use case without parameters
abstract class UseCaseNoParams<Type> {
  Future<Either<Failure, Type>> call();
}

/// Use case for streaming data
abstract class StreamUseCase<Type, Params> {
  Stream<Either<Failure, Type>> call(Params params);
}

/// Use case for streaming data without parameters
abstract class StreamUseCaseNoParams<Type> {
  Stream<Either<Failure, Type>> call();
}

/// No parameters class for use cases that don't need parameters
class NoParams {
  const NoParams();
}
