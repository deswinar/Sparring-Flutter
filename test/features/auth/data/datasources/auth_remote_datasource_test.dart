import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sparring/core/errors/failure.dart';
import 'package:sparring/features/auth/data/datasources/auth_remote_data_source.dart';
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
        const user = UserModel(
          id: 1,
          name: 'Test User',
          email: email,
          phone: '123456789',
          website: 'test.com',
          address: AddressModel(
            street: '123 Main St',
            suite: 'Apt 101',
            city: 'Test City',
            zipcode: '12345',
            geo: GeoModel(
              lat: '37.7749',
              lng: '-122.4194',
            ),
          ),
        );

        print(await mockAuthRemoteDataSource.login(email, password));

        // Act
        final result = await mockAuthRemoteDataSource.login(email, password);
        print(result);
        // Assert
        expect(result, equals(const Right(user)));
        verify(mockAuthRemoteDataSource.login(email, password));
        verifyNoMoreInteractions(mockAuthRemoteDataSource);
      });

      test('should return a failure when login fails', () async {
        // Arrange
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
        const user = UserModel(
          id: 2,
          name: name,
          email: email,
          phone: '987654321',
          website: 'example.com',
          address: null, // Update with AddressModel if necessary
        );

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
