import 'package:serverpod_auth_email_flutter/serverpod_auth_email_flutter.dart';
import 'package:tradelog_client/tradelog_client.dart';
import 'package:tradelog_flutter/main.dart';

/// Class for bundled authentication functionality
class AuthenticationManager {
  static Future<AuthenticationResult> signIn({
    required String email,
    required String password,
  }) async {
    final authController = EmailAuthController(client.modules.auth);

    UserInfo? user = await authController.signIn(email, password);

    if (user == null) {
      return AuthenticationResult.failure;
    }

    return AuthenticationResult.authenticated;
  }

  /// Creates an account with given email and password
  static Future<AuthenticationResult> createAccount({
    required String email,
    required String password,
  }) async {
    // A user's password must be at least 5 characters in length
    if (password.length <= 5) {
      return AuthenticationResult.passwordTooShort;
    }

    // Fetches the auth controller used for email authentication
    final authController = EmailAuthController(client.modules.auth);

    try {
      // Sends a request to create the user account
      // Sets the username equal to the email
      bool created = await authController.createAccountRequest(
        email,
        email,
        password,
      );

      // If the account does not get created, there must have happened some unexpected error
      // The server always returns true on recreation
      if (!created) {
        return AuthenticationResult.error;
      }

      // If all goes well, the verification code gets sent
      return AuthenticationResult.verificationCodeSent;
    } catch (e) {
      if (e is ServerpodClientException) {
        // This is marked as a failed attempt,
        // since the server should in no case return an error for this call
        // It either gets created with [true] or it doesn't with [false]
        return AuthenticationResult.failure;
      }

      // If the thrown exception is NOT a serverpod exception, something very wrong has happened.
      return AuthenticationResult.error;
    }
  }
}

enum AuthenticationResult {
  newUser,
  authenticated,
  failure,
  accountAlreadyExists,
  verificationCodeSent,
  passwordTooShort,
  error,
}
