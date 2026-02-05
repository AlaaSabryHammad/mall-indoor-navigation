import 'package:dartz/dartz.dart';
import '../errors/failures.dart';

/// Base class for all use cases
/// Type: return type of the use case
/// Params: parameters required by the use case
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

/// Use case that doesn't require parameters
abstract class UseCaseNoParams<Type> {
  Future<Either<Failure, Type>> call();
}

/// Use case that returns a stream
abstract class StreamUseCase<Type, Params> {
  Stream<Either<Failure, Type>> call(Params params);
}

/// No parameters marker
class NoParams {
  const NoParams();
}
