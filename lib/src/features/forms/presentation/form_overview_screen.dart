import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lyte_studios_flutter_ui/lyte_studios_flutter_ui.dart';
import 'package:tradelog_flutter/src/features/forms/presentation/copy_link_dialog.dart';
import 'package:tradelog_flutter/src/features/forms/presentation/profit_loss_loop_row.dart';
import 'package:tradelog_flutter/src/ui/icons/tradely_icons.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';

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

  bool isScaledUp = false;

  @override
  void initState() {
    super.initState();
    _startPulseEffect();
  }

  void _startPulseEffect() {
    Timer.periodic(const Duration(milliseconds: 320), (Timer timer) {
      setState(() {
        isScaledUp = !isScaledUp;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 395),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 40,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 126,
                      height: 30,
                      child: SvgIcon(
                        TradelyIcons.tradelyLogoText,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 30),
                    const CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/images/profile_picture.png'),
                        radius: 31),
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
                    ...testData.map((data) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Column(
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
                        ),
                      );
                    }),
                    const SizedBox(
                      height: 150,
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: 0,
            left: 0,
            bottom: 0,
            child: Stack(
              children: [
                Center(
                  child: Container(
                    height: 130,
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
                  ),
                ),
                Positioned(
                  top: 20,
                  left: 0,
                  right: 0,
                  child: SizedBox(
                    width: 330,
                    height: 60,
                    child: Center(
                      child: GestureDetector(
                        onTap: () => CopyLinkDialog.show(context),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 350),
                          alignment: Alignment.center,
                          curve: Curves.fastOutSlowIn,
                          height: isScaledUp ? 55 : 53,
                          width: isScaledUp ? 310 : 300,
                          decoration: BoxDecoration(
                              color: const Color(0xFF2D62FE),
                              borderRadius: BorderRadius.circular(50)),
                          child: const Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: PaddingSizes.medium,
                                  ),
                                  child: FittedBox(
                                    fit: BoxFit.fitHeight,
                                    child: AnimatedSize(
                                      duration: Duration(milliseconds: 350),
                                      curve: Curves.fastOutSlowIn,
                                      child: Text(
                                        'SHARE ON',
                                        style: TextStyle(
                                          fontFamily: 'Phonk',
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 7,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: PaddingSizes.large,
                                  ),
                                  child: FittedBox(
                                    fit: BoxFit.fitHeight,
                                    child: AnimatedSize(
                                      duration: Duration(milliseconds: 350),
                                      curve: Curves.fastOutSlowIn,
                                      child: SvgIcon(
                                        TradelyIcons.instagram,
                                        color: Colors.white,
                                        size: 26,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 90,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/emojis/finger_up.png',
                        width: 17,
                      ),
                      Text(
                        'Share your progress with your ig followers',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Image.asset(
                        'assets/images/emojis/finger_up.png',
                        width: 17,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
