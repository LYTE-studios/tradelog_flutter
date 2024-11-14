import 'package:flutter/material.dart';
import 'package:lyte_studios_flutter_ui/lyte_studios_flutter_ui.dart';
import 'package:tradelog_flutter/src/core/mixins/screen_state_mixin.dart';
import 'package:tradelog_flutter/src/features/forms/presentation/profit_loss_loop_row.dart';
import 'package:tradelog_flutter/src/ui/icons/tradely_icons.dart';

class FormOverviewScreen extends StatefulWidget {
  static const String route = '/$location';
  static const String location = 'forms';

  const FormOverviewScreen({super.key});

  @override
  State<FormOverviewScreen> createState() => _FormOverviewScreenState();
}

class _FormOverviewScreenState extends State<FormOverviewScreen>
    with ScreenStateMixin {
  // Test data
  final List<Map<String, dynamic>> testData = [
    {'isPositive': true, 'weekDay': 'MONDAY', 'amount': '349.78'},
    {'isPositive': false, 'weekDay': 'TUESDAY', 'amount': '1,400.78'},
    {'isPositive': true, 'weekDay': 'WEDNESDAY', 'amount': '289.12'},
    {'isPositive': false, 'weekDay': 'THURSDAY', 'amount': '99.99'},
    // You can add more days or handle an empty state by setting 'amount' to null
    {'isPositive': null, 'weekDay': 'FRIDAY', 'amount': null},
  ];

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(children: [
        Padding(
          padding: const EdgeInsets.only(top: 65),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 395),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 126,
                      height: 30,
                      child: SvgIcon(
                        TradelyIcons.tradelyLogoText,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 30),
                    const CircleAvatar(radius: 31),
                    const SizedBox(height: 18),
                    Text(
                      '\$YASSINE',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      'Made this week',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF858585),
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      '\$1,403.02',
                      style: TextStyle(
                        fontFamily: 'Phonk',
                        color: Colors.white,
                        fontSize: 42,
                      ),
                    ),
                    const SizedBox(height: 31),

                    // Dynamically generate rows based on test data
                    ...testData.map((data) {
                      return Column(
                        children: [
                          ProfitLossLoopRow(
                            isPositive: data['isPositive'],
                            weekDay: data['weekDay'],
                            amount: data['amount'],
                          ),
                          const SizedBox(height: 16),
                          const Divider(
                            height: 1,
                            color: Color(0xFF1A1A1A),
                          ),
                          const SizedBox(height: 16),
                        ],
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
            right: 0,
            left: 0,
            bottom: 0,
            child: Center(
              child: Container(
                height: 260,
                width: 450,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(23),
                      topLeft: Radius.circular(23)),
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xFF191A21), Color(0xFF000000)]),
                ),
                child: Center(
                  child: Container(
                    width: 322,
                    height: 61,
                    decoration: BoxDecoration(
                        color: Color(0xFF2D62FE),
                        borderRadius: BorderRadius.circular(30)),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'SHARE ON',
                            style: TextStyle(
                              fontFamily: 'Phonk',
                              fontSize: 18.5,
                              color: Colors.white,
                            ),
                          ),
                          SvgIcon(TradelyIcons.instagram)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ))
      ]),
    );
  }
}
