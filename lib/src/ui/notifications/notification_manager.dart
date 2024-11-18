import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/ui/notifications/base_in_app_notification.dart';

class NotificationManager {
  static final NotificationManager _instance = NotificationManager._internal();
  factory NotificationManager() => _instance;

  OverlayEntry? _currentOverlay;

  NotificationManager._internal();

  // Show the notification
  void showNotification(BuildContext context, String message, bool isSuccess) {
    _removeCurrentNotification();

    final overlay = Overlay.of(context);

    _currentOverlay = OverlayEntry(
      builder: (context) => Positioned(
        top: 20,
        right: 20,
        child: BaseInAppNotification(
          message: message,
          isSuccessful: isSuccess,
          onDismiss: _removeCurrentNotification,
        ),
      ),
    );

    // Insert the overlay entry into the Overlay
    overlay.insert(_currentOverlay!);

    // Automatically remove the notification after 3 seconds
    Future.delayed(const Duration(seconds: 3), _removeCurrentNotification);
  }

  // Remove the current notification if any
  void _removeCurrentNotification() {
    _currentOverlay?.remove();
    _currentOverlay = null;
  }
}
