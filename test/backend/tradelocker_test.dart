import 'dart:developer';

import 'package:flutter_test/flutter_test.dart';
import 'package:tradelog_client/tradelog_client.dart';
import 'package:tradelog_flutter/secrets.dart';

import 'data/test_data.dart';

void main() {
  var client = Client(
    apiUrl,
    authenticationKeyManager: TestAuthKeyManager(),
  );

  group('User creation', () {
    test('create account request', () async {
      var response = await client.modules.auth.email
          .createAccountRequest('test', testEmail, testPass);
      expect(response, equals(true));
    });

    test('create account', () async {
      var response =
          await client.modules.auth.email.createAccount(testEmail, 'xxxx');
      expect(response, isNotNull);
    });

    test('isSignedIn', () async {
      var signedIn = await client.modules.auth.status.isSignedIn();
      expect(signedIn, equals(true));
    });
  });

  group('Tradelocker Endpoints tests', () {
    test('Authenticate with correct credentials', () async {
      var response =
          await client.modules.auth.email.authenticate(testEmail, testPass);
      if (response.success) {
        await client.authenticationKeyManager!
            .put('${response.keyId}:${response.key}');
      }

      expect(response.success, equals(true));
      expect(response.userInfo, isNotNull);
    });

    test('isSignedIn', () async {
      var signedIn = await client.modules.auth.status.isSignedIn();

      expect(signedIn, equals(true));
    });

    // test('tradelocker authenticate', () async {
    //   try {
    //     // var response = await client.tradeLocker.authenticate(
    //     //   tradelockerDemoEmail,
    //     //   tradelockerDemoPass,
    //     //   tradelockerDemoServer,
    //     // );
    //
    //     expect(response, isNotNull);
    //   } on Exception catch (e) {
    //     log(e.toString());
    //   }
    // });

    // test('tradelocker refresh', () async {
    //   try {
    //     var response = await client.tradeLocker.refresh();
    //
    //     expect(response, isNotNull);
    //   } on Exception catch (e) {
    //     log(e.toString());
    //   }
    // });

    test('tradelocker getAccounts', () async {
      try {
        // var response = await client.tradeLocker.getAccounts();

        // expect(response, equals(200));
      } on Exception catch (e) {
        log(e.toString());
      }
    });

    test('tradelocker getPositions', () async {
      try {
        // var response = await client.tradeLocker
        //     .getPositions(tradelockerDemoAccountId, tradelockerDemoAccNum);

        // expect(response, equals('200'));
      } on Exception catch (e) {
        log(e.toString());
      }
    });
  });
}

class TestAuthKeyManager extends AuthenticationKeyManager {
  String? _key;

  @override
  Future<String?> get() async => _key;

  @override
  Future<void> put(String key) async {
    _key = key;
  }

  @override
  Future<void> remove() async {
    _key = null;
  }
}
