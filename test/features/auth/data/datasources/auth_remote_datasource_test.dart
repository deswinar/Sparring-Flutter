import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sparring/core/errors/failure.dart';
import 'package:sparring/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:sparring/features/auth/data/models/user_model.dart';

// Create a Mock class for AuthRemoteDataSource
class MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}

void main() {
  late MockAuthRemoteDataSource mockAuthRemoteDataSource;

  setUp(() {
    mockAuthRemoteDataSource = MockAuthRemoteDataSource();
  });

  group('AuthRemoteDataSource', () {
    group('login', () {
      const email = 'test@example.com';
      const password = 'password123';

      test('should return a UserModel when login is successful', () async {
        // Arrange
        final user = const UserModel(id: "1", name: "Test User", email: email);
        // Ensure the when() call returns the correct Future
        when(mockAuthRemoteDataSource.login(email, password))
            .thenAnswer((_) async => Right(user));

        // Act
        final result = await mockAuthRemoteDataSource.login(email, password);

        // Assert
        expect(result, equals(Right(user)));
        verify(mockAuthRemoteDataSource.login(email, password));
        verifyNoMoreInteractions(mockAuthRemoteDataSource);
      });

      test('should return a failure when login fails', () async {
        // Arrange
        // Ensure the when() call returns the correct Future
        when(mockAuthRemoteDataSource.login(email, password))
            .thenAnswer((_) async => Left(AuthFailure("Invalid credentials")));

        // Act
        final result = await mockAuthRemoteDataSource.login(email, password);

        // Assert
        expect(result, equals(Left(AuthFailure("Invalid credentials"))));
        verify(mockAuthRemoteDataSource.login(email, password));
        verifyNoMoreInteractions(mockAuthRemoteDataSource);
      });
    });

    group('register', () {
      const email = 'newuser@example.com';
      const name = 'New User';
      const password = 'password123';

      test('should return a UserModel when register is successful', () async {
        // Arrange
        final user = const UserModel(id: "1", name: name, email: email);
        // Ensure the when() call returns the correct Future
        when(mockAuthRemoteDataSource.register(
                email: email, name: name, password: password))
            .thenAnswer((_) async => Right(user));

        // Act
        final result = await mockAuthRemoteDataSource.register(
            email: email, name: name, password: password);

        // Assert
        expect(result, equals(Right(user)));
        verify(mockAuthRemoteDataSource.register(
            email: email, name: name, password: password));
        verifyNoMoreInteractions(mockAuthRemoteDataSource);
      });

      test('should return a failure when register fails', () async {
        // Arrange
        // Ensure the when() call returns the correct Future
        when(mockAuthRemoteDataSource.register(
                email: email, name: name, password: password))
            .thenAnswer((_) async => Left(ApiFailure("API error occurred")));

        // Act
        final result = await mockAuthRemoteDataSource.register(
            email: email, name: name, password: password);

        // Assert
        expect(result, equals(Left(ApiFailure("API error occurred"))));
        verify(mockAuthRemoteDataSource.register(
            email: email, name: name, password: password));
        verifyNoMoreInteractions(mockAuthRemoteDataSource);
      });
    });
  });
}
