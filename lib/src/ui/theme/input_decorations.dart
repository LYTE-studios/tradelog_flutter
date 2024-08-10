import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/ui/theme/border_radii.dart';

class InputDecorations {
  static InputDecoration defaultInputDecoration = InputDecoration(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(
        BorderRadii.small,
      ),
    ),
  );
}
