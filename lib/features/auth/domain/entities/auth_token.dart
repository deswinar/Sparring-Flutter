// auth_token.dart
import 'package:equatable/equatable.dart';

/// Core business entity representing authentication tokens.
class AuthToken extends Equatable {
  final String accessToken;  // JWT or similar token for resource access
  final String refreshToken; // Token for obtaining a new access token
  final DateTime expiry;     // Expiry time of the access token

  const AuthToken({
    required this.accessToken,
    required this.refreshToken,
    required this.expiry,
  });

  /// Checks if the access token has expired.
  bool get isExpired => DateTime.now().isAfter(expiry);

  @override
  List<Object?> get props => [accessToken, refreshToken, expiry];
}
