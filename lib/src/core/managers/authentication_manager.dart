import 'dart:io' as io;

import 'package:flutter/foundation.dart';
import 'package:serverpod_auth_google_flutter/serverpod_auth_google_flutter.dart';
import 'package:tradelog_client/tradelog_client.dart';
import 'package:tradelog_flutter/secrets.dart';
import 'package:tradelog_flutter/src/core/data/client.dart';

/// Class for bundled authentication functionality
class AuthenticationManager {
  static Future<AuthenticationResult> startPasswordReset(
    String email,
  ) async {
    try {
      bool result =
          await client.modules.auth.email.initiatePasswordReset(email);

      if (result == true) {
        return AuthenticationResult.success;
      }

      return AuthenticationResult.failure;
    } catch (e) {
      return AuthenticationResult.error;
    }
  }

  static Future<AuthenticationResult> resetPassword(
    String code,
    String newPassword,
  ) async {
    try {
      bool result =
          await client.modules.auth.email.resetPassword(code, newPassword);

      if (result == true) {
        return AuthenticationResult.success;
      }

      return AuthenticationResult.failure;
    } catch (e) {
      return AuthenticationResult.error;
    }
  }

  static Future<AuthenticationResult> googleSignIn() async {
// local
    UserInfo? userInfo;

    // Get the user info from trying to sign in
    try {
      String clientId = '';
      if (kIsWeb) {
        clientId = googleClientIdWeb;
      } else if (io.Platform.isIOS) {
        throw UnimplementedError();
      } else if (io.Platform.isAndroid) {
        throw UnimplementedError();
      } else {
        throw Exception('Platform undefined');
      }

      userInfo = await signInWithGoogle(
        client.modules.auth,
        // clientId: clientId,
        serverClientId: googleClientIdAPI,
        redirectUri: Uri.parse('${apiUrl}googlesignin'),
      );

      if (userInfo == null) {
        return AuthenticationResult.failure;
      }
    } catch (e) {
      return AuthenticationResult.error;
    }

    return AuthenticationResult.success;
  }

  static Future<AuthenticationResult> signIn({
    required String email,
    required String password,
  }) async {
    var response = await client.modules.auth.email.authenticate(
      email,
      password,
    );

    if (!response.success) {
      return AuthenticationResult.failure;
    }

    return AuthenticationResult.authenticated;
  }

  /// Creates an account with given email and password
  static Future<AuthenticationResult> verifyAccount({
    required String email,
    required String code,
  }) async {
    try {
      // Sends a request to create the user account from a verification code
      UserInfo? user = await client.modules.auth.email.createAccount(
        email,
        code,
      );

      // If the account does not get created, the user simply didn't pass the correct credentials
      if (user == null) {
        return AuthenticationResult.failure;
      }

      // If all goes well, the user account got created
      return AuthenticationResult.success;
    } catch (e) {
      if (e is ServerpodClientException) {
        return AuthenticationResult.error;
      }

      // If the thrown exception is NOT a serverpod exception, something very wrong has happened.
      return AuthenticationResult.error;
    }
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

    try {
      // Sends a request to create the user account
      // Sets the username equal to the email
      bool created = await client.modules.auth.email.createAccountRequest(
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
  success,
  newUser,
  authenticated,
  failure,
  accountAlreadyExists,
  verificationCodeSent,
  passwordTooShort,
  error,
}
