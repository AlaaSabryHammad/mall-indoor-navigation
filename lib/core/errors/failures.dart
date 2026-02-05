import 'package:equatable/equatable.dart';

/// Base class for all failures in the application
/// Using sealed class pattern for exhaustive handling
abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

// ============================================
// DATABASE FAILURES
// ============================================

class DatabaseFailure extends Failure {
  const DatabaseFailure(super.message);
}

class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

// ============================================
// VALIDATION FAILURES
// ============================================

class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}

class InvalidCoordinatesFailure extends Failure {
  const InvalidCoordinatesFailure(super.message);
}

// ============================================
// PATHFINDING FAILURES
// ============================================

class PathNotFoundFailure extends Failure {
  const PathNotFoundFailure(super.message);
}

class InvalidPathNodeFailure extends Failure {
  const InvalidPathNodeFailure(super.message);
}

// ============================================
// PRODUCT FAILURES
// ============================================

class ProductNotFoundFailure extends Failure {
  const ProductNotFoundFailure(super.message);
}

class DuplicateBarcodeFailure extends Failure {
  const DuplicateBarcodeFailure(super.message);
}

// ============================================
// AUTHENTICATION FAILURES
// ============================================

class AuthenticationFailure extends Failure {
  const AuthenticationFailure(super.message);
}

// ============================================
// PERMISSION FAILURES
// ============================================

class PermissionDeniedFailure extends Failure {
  const PermissionDeniedFailure(super.message);
}

// ============================================
// IMAGE FAILURES
// ============================================

class ImageLoadFailure extends Failure {
  const ImageLoadFailure(super.message);
}

class ImageUploadFailure extends Failure {
  const ImageUploadFailure(super.message);
}
