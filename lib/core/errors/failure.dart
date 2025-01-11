// lib/core/errors/failure.dart

// Base Failure class which can be extended for specific failure types.
abstract class Failure {
  final String message;
  Failure(this.message);
}

// A generic Failure for handling all errors.
class GenericFailure extends Failure {
  GenericFailure(super.message);
}

// A specific failure to handle API-related errors.
class ApiFailure extends Failure {
  ApiFailure(super.message);
}

class ServerFailure extends Failure {
  ServerFailure(super.message);
}

class CacheFailure extends Failure {
  CacheFailure(super.message);
}

// A failure for handling invalid input errors, like validation failures.
class InvalidInputFailure extends Failure {
  InvalidInputFailure(super.message);
}

// A failure for handling authentication-related errors.
class AuthFailure extends Failure {
  AuthFailure(super.message);
}

// A failure for handling database-related errors.
class DatabaseFailure extends Failure {
  DatabaseFailure(super.message);
}

// A failure for network connectivity issues.
class NetworkFailure extends Failure {
  NetworkFailure(super.message);
}
