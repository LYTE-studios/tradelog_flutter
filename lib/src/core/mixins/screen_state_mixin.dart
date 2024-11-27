import 'package:flutter/cupertino.dart';
import 'package:tradelog_flutter/src/features/dashboard/dashboard_screen.dart';
import 'package:tradelog_flutter/src/ui/notifications/base_in_app_notification.dart';

mixin ScreenStateMixin<T extends StatefulWidget> on State<T> {
  bool loading = false;

  void setLoading(bool value) {
    setState(() {
      loading = value;
    });
  }

  @override
  void setState(VoidCallback fn) {
    if (!mounted) {
      return;
    }

    super.setState(fn);
  }

  Future<void> loadData() async {}

  Future<void> showError() async {
    DashboardScreen.showError(
      const BaseInAppNotification(
        message: "Something went wrong!",
        isSuccessful: false,
      ),
    );
  }

  @override
  void initState() {
    Future(
      () async {
        try {
          setLoading(true);
          await loadData();
          setLoading(false);
        } catch (e) {
          await showError();
        }
      },
    );

    super.initState();
  }
}
