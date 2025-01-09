import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:sparring/core/errors/failure.dart';
import 'package:sparring/features/auth/data/datasources/auth_remote_data_source_impl.dart';
import 'package:sparring/features/auth/data/models/user_model.dart';

void main() {
  late AuthRemoteDataSourceImpl dataSource;

  setUp(() {
    dataSource = AuthRemoteDataSourceImpl(GetIt.instance(), GetIt.instance());
  });

  group('AuthRemoteDataSourceImpl - login', () {
    test('should return UserModel on successful login', () async {
      // Arrange
      const email = "test@example.com";
      const password = "password123";

      // Act
      final result = await dataSource.login(email, password);

      // Assert
      expect(result.isRight(), true);
      result.fold(
        (failure) => fail('Expected success, but got failure: $failure'),
        (user) {
          expect(user.id, "1");
          expect(user.name, "Test User");
          expect(user.email, email);
        },
      );
    });

    test('should throw AuthFailure for invalid credentials', () async {
      // Arrange
      const email = "wrong@example.com";
      const password = "wrongpassword";

      // Act
      try {
        await dataSource.login(email, password);
        fail('Expected AuthFailure but got success');
      } catch (e) {
        // Assert
        expect(e, isA<AuthFailure>());
        expect((e as AuthFailure).message, "Invalid credentials");
      }
    });

    test('should throw NetworkFailure for network error', () async {
      // Simulate network failure by overriding the implementation.
      final dataSourceWithError = AuthRemoteDataSourceImplWithError(GetIt.instance(), GetIt.instance());

      // Act
      try {
        await dataSourceWithError.login("test@example.com", "password123");
        fail('Expected NetworkFailure but got success');
      } catch (e) {
        // Assert
        expect(e, isA<NetworkFailure>());
        expect((e as NetworkFailure).message, "Network error occurred");
      }
    });
  });

  group('AuthRemoteDataSourceImpl - register', () {
    test('Should return UserModel on successful register', () async {
      const name = "Test";
      const email = "test@example.com";
      const password = "password123";

      final result = await dataSource.register(
        name: name,
        email: email,
        password: password,
      );

      expect(result.isRight(), true);
      result.fold(
        (failure) => fail('Expected success, but got failure: $failure'),
        (user) {
          expect(user.id, "1");
          expect(user.name, name);
          expect(user.email, email);
        },
      );
    });
  });
}

// Simulated class to mimic network failure for testing
class AuthRemoteDataSourceImplWithError extends AuthRemoteDataSourceImpl {
  AuthRemoteDataSourceImplWithError(super.firebaseAuth, super.firestore);

  @override
  Future<Either<Failure, UserModel>> login(
      String email, String password) async {
    throw NetworkFailure("Network error occurred");
  }
}
