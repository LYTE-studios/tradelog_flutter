import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/core/enums/tradely_enums.dart';
import 'package:tradelog_flutter/src/core/mixins/screen_state_mixin.dart';
import 'package:tradelog_flutter/src/features/dashboard/account/presentation/widgets/add_trade_toggle_tab.dart';
import 'package:tradelog_flutter/src/features/dashboard/account/presentation/widgets/buy_sell_toggle_tab.dart';
import 'package:tradelog_flutter/src/ui/buttons/primary_button.dart';
import 'package:tradelog_flutter/src/ui/dialogs/base_dialog.dart';
import 'package:tradelog_flutter/src/ui/icons/tradely_icons.dart';
import 'package:tradelog_flutter/src/ui/input/dropdown_input.dart';
import 'package:tradelog_flutter/src/ui/input/primary_text_input.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';
import 'package:tradelog_flutter/src/ui/theme/text_styles.dart';

class AddTradeDialog extends StatefulWidget {
  const AddTradeDialog({super.key});

  static Future<void> show(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) => const AddTradeDialog(),
    );
  }

  @override
  State<AddTradeDialog> createState() => _BrokerConnectionDialogState();
}

class _BrokerConnectionDialogState extends State<AddTradeDialog>
    with ScreenStateMixin {
  final TextEditingController _textController = TextEditingController();
  final PageController _pageController = PageController();

  AddTradeType selectedType = AddTradeType.manual;
  BuySellType selectedBuySellType = BuySellType.buy;

  bool isProfit = true;

  @override
  void dispose() {
    _textController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  String? fileName;

  // Method to open file picker
  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        fileName = result.files.single.name; // Get file name
      });
    } else {
      // User canceled the picker
      setState(() {
        fileName = null;
      });
    }
  }

  void _onToggle(AddTradeType type) {
    setState(() {
      selectedType = type;

      final pageIndex = type == AddTradeType.manual ? 0 : 1;
      _pageController.animateToPage(
        pageIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.fastEaseInToSlowEaseOut,
      );
    });
  }

  void _onBuySellToggle(BuySellType type) {
    setState(() {
      selectedBuySellType = type;
    });
  }

  void _toggleProfitLoss() {
    setState(() {
      isProfit = !isProfit;
    });
  }

  void _resetFile() {
    setState(() {
      fileName = null; // Clear the file name
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 100,
      ),
      child: BaseDialog(
        padding: const EdgeInsets.all(
          PaddingSizes.xxl,
        ),
        constraints: const BoxConstraints(
          maxWidth: 620,
          maxHeight: 940,
        ),
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxHeight: 850,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AddTradeToggleTab(
                  onToggle: _onToggle,
                  height: 45,
                  width: 300,
                  initialIndex: selectedType == AddTradeType.manual ? 0 : 1,
                ),
                const SizedBox(
                  height: PaddingSizes.small,
                ),
                Expanded(
                  child: SizedBox(
                    height: 400,
                    child: PageView(
                      controller: _pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: PaddingSizes.large),
                            Text(
                              'Add trade',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 25,
                                  ),
                            ),
                            const SizedBox(height: PaddingSizes.xxs),
                            Text(
                              'Use your account time zone (GMT +02:00)',
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall
                                  ?.copyWith(
                                    color: const Color(0xFF888888),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                  ),
                            ),
                            const SizedBox(height: PaddingSizes.large),
                            BuySellToggleTab(
                              onToggle: _onBuySellToggle,
                              height: 45,
                              width: 225,
                              initialIndex:
                                  selectedBuySellType == BuySellType.buy
                                      ? 0
                                      : 1,
                            ),
                            const SizedBox(height: PaddingSizes.xxl),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Account (optional)',
                                  style: TextStyles.titleMedium.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: PaddingSizes.medium),
                                SizedBox(
                                  height: 150,
                                  child: Scrollbar(
                                    thumbVisibility: false,
                                    radius: const Radius.circular(10),
                                    thickness: 5,
                                    child: GestureDetector(
                                      //consume the gesture to prevent browser navigation
                                      //intercept horizontal drag gestures
                                      onHorizontalDragUpdate: (details) {
                                        //prevent browser from navigating back/forward
                                        if (details.delta.dx < 0 ||
                                            details.delta.dx > 0) {
                                          //dragging left
                                          return;
                                        }
                                      },
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 5),
                                        child: ListView(
                                          shrinkWrap: true,
                                          physics:
                                              const BouncingScrollPhysics(),
                                          scrollDirection: Axis.horizontal,
                                          children: const [
                                            // LinkedAccount(),
                                            // SizedBox(width: PaddingSizes.small),
                                            // LinkedAccount(),
                                            // SizedBox(width: PaddingSizes.small),
                                            // LinkedAccount(),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: PaddingSizes.medium),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Fee info',
                                      style: TextStyles.titleMedium.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: PaddingSizes.small),
                                    Row(
                                      children: [
                                        Material(
                                          child: PrimaryTextInput(
                                            width: 123,
                                            height: 50,
                                            hint: 'Currency',
                                            tec: _textController,
                                          ),
                                        ),
                                        const SizedBox(
                                            width: PaddingSizes.small),
                                        Material(
                                          child: PrimaryTextInput(
                                            //width should expand
                                            width: 375,
                                            height: 50,
                                            hint: 'Fee amount',
                                            tec: _textController,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: PaddingSizes.xxl),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Trade info',
                                      style: TextStyles.titleMedium.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: PaddingSizes.small),
                                    Row(
                                      children: [
                                        PrimaryButton(
                                          align: MainAxisAlignment.start,
                                          prefixIcon: TradelyIcons.diary,
                                          prefixIconColor:
                                              const Color(0xFF8B8B8B),
                                          onTap: () {},
                                          width: 250,
                                          height: 50,
                                          text: 'Date & time',
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .labelLarge
                                              ?.copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onTertiaryContainer,
                                              ),
                                          color: const Color(0xFF171717),
                                          borderColor: const Color(0xFF313334),
                                          outlined: true,
                                        ),
                                        const SizedBox(
                                            width: PaddingSizes.small),
                                        Material(
                                          child: PrimaryTextInput(
                                            width: 250,
                                            height: 50,
                                            hint: 'Lot size',
                                            tec: _textController,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: PaddingSizes.small),
                                    Row(
                                      children: [
                                        Material(
                                          child: PrimaryTextInput(
                                            width: 250,
                                            height: 50,
                                            hint: 'Take profit',
                                            tec: _textController,
                                          ),
                                        ),
                                        const SizedBox(
                                            width: PaddingSizes.small),
                                        Material(
                                          child: PrimaryTextInput(
                                            width: 250,
                                            height: 50,
                                            hint: 'Stoploss',
                                            tec: _textController,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: PaddingSizes.xxl),
                            const Divider(
                              height: 0.5,
                              color: Color(0xFF323232),
                            ),
                            const SizedBox(height: PaddingSizes.extraLarge),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                PrimaryButton(
                                  align: MainAxisAlignment.center,
                                  prefixIcon: isProfit
                                      ? TradelyIcons.trendDown
                                      : TradelyIcons.trendUp,
                                  prefixIconColor: const Color(0xFF8B8B8B),
                                  prefixIconSize: 10,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  onTap: _toggleProfitLoss,
                                  height: 41,
                                  color: const Color(0xFF1C1C1C),
                                ),
                                const SizedBox(width: PaddingSizes.extraSmall),
                                PrimaryButton(
                                  align: MainAxisAlignment.center,
                                  prefixIcon: isProfit
                                      ? TradelyIcons.trendUp
                                      : TradelyIcons.trendDown,
                                  prefixIconColor: isProfit
                                      ? const Color(0xFF14D39F)
                                      : const Color(0xFFF21111),
                                  prefixIconSize: 10,
                                  onTap: _toggleProfitLoss,
                                  width: 120,
                                  height: 41,
                                  text: isProfit ? 'Profit' : 'Loss',
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .labelLarge
                                      ?.copyWith(
                                        color: isProfit
                                            ? const Color(0xFF14D39F)
                                            : const Color(0xFFF21111),
                                      ),
                                  color: isProfit
                                      ? const Color(0xFF123E32)
                                      : const Color(0xFF3E1111),
                                  borderColor: isProfit
                                      ? const Color(0xFF138869)
                                      : const Color(0xFF92241F),
                                  outlined: true,
                                ),
                                const SizedBox(width: PaddingSizes.small),
                                Material(
                                  child: PrimaryTextInput(
                                    width: 330,
                                    height: 41,
                                    hint: 'Lot size',
                                    tec: _textController,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: PaddingSizes.xxxxl),
                            Row(
                              children: [
                                PrimaryButton(
                                  width: 150,
                                  onTap: () {},
                                  height: 44,
                                  text: 'Add Trade',
                                  prefixIcon: TradelyIcons.plusCircle,
                                ),
                                const SizedBox(width: PaddingSizes.xxs),
                                PrimaryButton(
                                  width: 110,
                                  color: Colors.transparent,
                                  onTap: () {},
                                  height: 44,
                                  text: 'Cancel',
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: PaddingSizes.large),
                            Text(
                              'Upload CSV file',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 25,
                                  ),
                            ),
                            const SizedBox(height: PaddingSizes.xxs),
                            Text(
                              'By uploading a CVS file, you can import multiple trades \nat once in to one of your accounts on Tradely!',
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall
                                  ?.copyWith(
                                    color: const Color(0xFF5B5B5B),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15,
                                  ),
                            ),
                            const SizedBox(height: PaddingSizes.xxl),
                            Text(
                              'Choose an account',
                              style: TextStyles.titleMedium.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: PaddingSizes.medium),
                            SizedBox(
                              height: 150,
                              child: Scrollbar(
                                thumbVisibility: false,
                                radius: const Radius.circular(10),
                                thickness: 5,
                                child: GestureDetector(
                                  //consume the gesture to prevent browser navigation
                                  //intercept horizontal drag gestures
                                  onHorizontalDragUpdate: (details) {
                                    //prevent browser from navigating back/forward
                                    if (details.delta.dx < 0 ||
                                        details.delta.dx > 0) {
                                      //dragging left
                                      return;
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: ListView(
                                      shrinkWrap: true,
                                      physics: const BouncingScrollPhysics(),
                                      scrollDirection: Axis.horizontal,
                                      children: const [
                                        // LinkedAccount(),
                                        // SizedBox(width: PaddingSizes.small),
                                        // LinkedAccount(),
                                        // SizedBox(width: PaddingSizes.small),
                                        // LinkedAccount(),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: PaddingSizes.large),
                            const Divider(
                              height: 0.5,
                              color: Color(0xFF323232),
                            ),
                            const SizedBox(height: PaddingSizes.extraLarge),
                            Text(
                              'Timezone',
                              style: TextStyles.titleMedium.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: PaddingSizes.medium),
                            Material(
                              child: DropdownInput(
                                height: 45,
                                width: 400,
                                hint: 'Select Timezone',
                                items: const [
                                  '(GMT-04:00) US/Eastern',
                                  '(GMT+01:00) Europe/London'
                                ],
                                onChanged: (value) {
                                  print(value);
                                },
                              ),
                            ),
                            const SizedBox(height: PaddingSizes.medium),
                            Container(
                              width: 400,
                              decoration: BoxDecoration(
                                color: const Color(0xFF171717),
                                borderRadius: BorderRadius.circular(8),
                                border: fileName != null
                                    ? Border.all(
                                        color: const Color(0xFF2D62FE),
                                      )
                                    : null,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 25,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      fileName != null
                                          ? 'Click the button to delete the file'
                                          : 'Drag and drop file upload from your computer',
                                      style: TextStyles.titleMedium.copyWith(
                                        color: const Color(0xFF585858),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                      ),
                                    ),
                                    const SizedBox(height: PaddingSizes.large),
                                    PrimaryButton(
                                      width: 160,
                                      prefixIcon: fileName != null
                                          ? TradelyIcons.reset
                                          : TradelyIcons.plusCircle,
                                      prefixIconColor: fileName != null
                                          ? Colors.white
                                          : const Color(0xFFCCCCCC),
                                      prefixIconSize: 20,
                                      prefixIconPadding: const EdgeInsets.only(
                                        right: 4,
                                      ),
                                      text: fileName != null
                                          ? (fileName!.length > 8
                                              ? '${fileName!.substring(0, 10)}...' // Shorten and add ellipsis
                                              : fileName!) // Display full name if <= 8 chars
                                          : 'Upload CSV',
                                      textStyle:
                                          TextStyles.labelMedium.copyWith(
                                        color: fileName != null
                                            ? Colors.white
                                            : const Color(0xFFCCCCCC),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                      ),
                                      color: fileName != null
                                          ? const Color(0xFF2D62FE)
                                          : const Color(0xFF2B2B2B),
                                      onTap: fileName != null
                                          ? _resetFile
                                          : _pickFile,
                                      height: 40,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: PaddingSizes.xxl),
                            Row(
                              children: [
                                PrimaryButton(
                                  width: 180,
                                  onTap: () {},
                                  height: 44,
                                  text: 'Add all trades',
                                  prefixIcon: TradelyIcons.plusCircle,
                                ),
                                const SizedBox(width: PaddingSizes.xxs),
                                PrimaryButton(
                                  width: 110,
                                  color: Colors.transparent,
                                  onTap: () {},
                                  height: 44,
                                  text: 'Cancel',
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
