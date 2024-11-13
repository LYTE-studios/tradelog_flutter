import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/core/mixins/screen_state_mixin.dart';

class FormOverviewScreen extends StatefulWidget {
  static const String route = '/$location';
  static const String location = 'forms';

  const FormOverviewScreen({super.key});

  @override
  State<FormOverviewScreen> createState() => _FormOverviewScreenState();
}

class _FormOverviewScreenState extends State<FormOverviewScreen>
    with ScreenStateMixin {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
    );
  }
}
