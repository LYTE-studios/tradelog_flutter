import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/ui/theme/input_decorations.dart';

class PrimaryTextInput extends StatelessWidget {
  final double? height;

  final double? width;

  final TextEditingController tec;

  final String? label;

  final String? hint;

  const PrimaryTextInput({
    super.key,
    this.height,
    this.width,
    required this.tec,
    this.label,
    this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Text(
            label!,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        SizedBox(
          height: height,
          width: width ?? 200,
          child: TextField(
            controller: tec,
            decoration: InputDecorations.defaultInputDecoration.copyWith(
              hintText: hint,
              //  floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
          ),
        ),
      ],
    );
  }
}
