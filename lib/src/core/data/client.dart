import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';
import 'package:tradelog_client/tradelog_client.dart';
import 'package:tradelog_flutter/secrets.dart';

late SessionManager sessionManager;
late Client client;

Future<void> initializeServerpodClient() async {
  client = Client(
    apiUrl,
    authenticationKeyManager: FlutterAuthenticationKeyManager(),
  )..connectivityMonitor = FlutterConnectivityMonitor();

  sessionManager = SessionManager(
    caller: client.modules.auth,
  );

  await sessionManager.initialize();
}
