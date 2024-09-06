import 'package:flutter/cupertino.dart';

class LongShortButtons extends StatelessWidget {
  const LongShortButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("All"),
        Text("Long"),
        Text("Short"),
      ],
    );
  }
}
