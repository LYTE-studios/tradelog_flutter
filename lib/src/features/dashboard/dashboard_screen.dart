import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/ui/navigation/sidebar.dart';

class DashboardScreen extends StatefulWidget {
  final Widget child;

  const DashboardScreen({super.key, required this.child});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool extended = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Sidebar(
            extended: extended,
            onTap: () {
              setState(() {
                extended = !extended;
              });
            },
          ),
          Expanded(child: widget.child)
          //widget.child,
        ],
      ),
    );
  }
}
