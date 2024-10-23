import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:lyte_studios_flutter_ui/lyte_studios_flutter_ui.dart';
import 'package:tradelog_flutter/src/features/dashboard/diary/presentation/widgets/date_selector_container.dart';
import 'package:tradelog_flutter/src/features/dashboard/overview/presentation/widgets/equity_line_chart.dart';
import 'package:tradelog_flutter/src/ui/base/base_container.dart';
import 'package:tradelog_flutter/src/ui/base/base_tradely_page.dart';
import 'package:tradelog_flutter/src/ui/base/base_tradely_page_header.dart';
import 'package:tradelog_flutter/src/ui/base/custom_row_trades.dart';
import 'package:tradelog_flutter/src/ui/base/generic_list_view_trades.dart';
import 'package:tradelog_flutter/src/ui/buttons/primary_button.dart';
import 'package:tradelog_flutter/src/ui/data/small_data_list.dart';
import 'package:tradelog_flutter/src/ui/icons/tradely_icons.dart';
import 'package:tradelog_flutter/src/ui/list/header_row_item.dart';
import 'package:tradelog_flutter/src/ui/list/text_profit_loss.dart';
import 'package:tradelog_flutter/src/ui/list/text_row_item.dart';
import 'package:tradelog_flutter/src/ui/list/trend_row_item.dart';
import 'package:tradelog_flutter/src/ui/text/tooltip_title.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';

import '../../../../ui/base/custom_header.dart';

class DiaryScreen extends StatefulWidget {
  final allRows = [
    const CustomRow(
      horizontalPadding: 20,
      rowItems: [
        TextRowItem(
          text: '14:23:05',
          flex: 1,
        ),
        TextRowItem(
          text: 'EURJPY',
          flex: 1,
        ),
        TrendRowItem(
          short: true,
          flex: 1,
        ),
        TextRowItem(
          text: 'Closed',
          flex: 1,
        ),
        TextProfitLoss(
          text: '\$8,37',
          short: true,
          flex: 1,
        ),
        TextRowItem(
          text: '2.25%',
          flex: 1,
        ),
      ],
    ),
    const CustomRow(
      horizontalPadding: 20,
      rowItems: [
        TextRowItem(
          text: '16:46:12',
          flex: 1,
        ),
        TextRowItem(
          text: 'EURJPY',
          flex: 1,
        ),
        TrendRowItem(
          short: false,
          flex: 1,
        ),
        TextRowItem(
          text: 'Closed',
          flex: 1,
        ),
        TextProfitLoss(
          text: '\$234,23',
          short: false,
          flex: 1,
        ),
        TextRowItem(
          text: '24.02%',
          flex: 1,
        ),
      ],
    ),
    const CustomRow(
      horizontalPadding: 20,
      rowItems: [
        TextRowItem(
          text: '16:58:02',
          flex: 1,
        ),
        TextRowItem(
          text: 'EURJPY',
          flex: 1,
        ),
        TrendRowItem(
          short: false,
          flex: 1,
        ),
        TextRowItem(
          text: 'Closed',
          flex: 1,
        ),
        TextProfitLoss(
          text: '\$19,11',
          short: false,
          flex: 1,
        ),
        TextRowItem(
          text: '3.28%',
          flex: 1,
        ),
      ],
    ),
    const CustomRow(
      horizontalPadding: 20,
      rowItems: [
        TextRowItem(
          text: '17:17:58',
          flex: 1,
        ),
        TextRowItem(
          text: 'EURJPY',
          flex: 1,
        ),
        TrendRowItem(
          short: true,
          flex: 1,
        ),
        TextRowItem(
          text: 'Closed',
          flex: 1,
        ),
        TextProfitLoss(
          text: '\$8,37',
          short: true,
          flex: 1,
        ),
        TextRowItem(
          text: '25%',
          flex: 1,
        ),
      ],
    ),
    const CustomRow(
      horizontalPadding: 20,
      rowItems: [
        TextRowItem(
          text: '17:17:58',
          flex: 1,
        ),
        TextRowItem(
          text: 'EURJPY',
          flex: 1,
        ),
        TrendRowItem(
          short: true,
          flex: 1,
        ),
        TextRowItem(
          text: 'Closed',
          flex: 1,
        ),
        TextProfitLoss(
          text: '\$8,37',
          short: true,
          flex: 1,
        ),
        TextRowItem(
          text: '25%',
          flex: 1,
        ),
      ],
    ),
    const CustomRow(
      horizontalPadding: 20,
      rowItems: [
        TextRowItem(
          text: '17:17:58',
          flex: 1,
        ),
        TextRowItem(
          text: 'EURJPY',
          flex: 1,
        ),
        TrendRowItem(
          short: true,
          flex: 1,
        ),
        TextRowItem(
          text: 'Closed',
          flex: 1,
        ),
        TextProfitLoss(
          text: '\$8,37',
          short: true,
          flex: 1,
        ),
        TextRowItem(
          text: '25%',
          flex: 1,
        ),
      ],
    ),
  ];

  DiaryScreen({super.key});

  static const String route = '/$location';
  static const String location = 'diary';

  @override
  _DiaryScreenState createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {
  bool isAnnotationFieldVisible = true;
  final QuillController _controller = QuillController.basic();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BaseTradelyPage(
      header: BaseTradelyPageHeader(
        subTitle: "Lorem ipsum dolor sit amet consectetur lorem.",
        icon: TradelyIcons.diary,
        currentRoute: DiaryScreen.location,
        title: "Your diary",
        titleIconPath: 'assets/images/emojis/pencil_emoji.png',
        buttons: PrimaryButton(
          onTap: () {},
          height: 42,
          text: "Add new trade",
          prefixIcon: TradelyIcons.plusCircle,
          prefixIconSize: 22,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Stack(
              children: [
                // Main content: Quill editor or Container
                BaseContainer(
                  child: isAnnotationFieldVisible
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 150),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: PaddingSizes.extraSmall,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF161616),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: QuillToolbar.simple(
                                  controller: _controller,
                                  configurations:
                                      const QuillSimpleToolbarConfigurations(
                                    sectionDividerColor: Color(0xFF5C5C5C),
                                    toolbarIconAlignment: WrapAlignment.start,
                                    showFontFamily: false,
                                    showCodeBlock: false,
                                    showInlineCode: false,
                                    showSubscript: false,
                                    showSuperscript: false,
                                    showColorButton: false,
                                    showBackgroundColorButton: false,
                                    showQuote: false,
                                    showIndent: false,
                                    showLink: false,
                                    showSearchButton: false,
                                    showClipboardCut: false,
                                    showClipboardCopy: false,
                                    showClipboardPaste: false,
                                    showClearFormat: false,
                                    showListCheck: false,
                                    showFontSize: false,
                                    showAlignmentButtons: true,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: PaddingSizes.extraLarge),
                            Expanded(
                              child: QuillEditor.basic(
                                controller: _controller,
                                configurations: const QuillEditorConfigurations(
                                  placeholder: 'Add a note',
                                  customStyles: DefaultStyles(
                                    lists: DefaultListBlockStyle(
                                        TextStyle(
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.normal,
                                          color: Colors.white,
                                          letterSpacing: 0,
                                          fontSize: 15,
                                        ),
                                        HorizontalSpacing(2, 2),
                                        VerticalSpacing(2, 2),
                                        VerticalSpacing.zero,
                                        null,
                                        null),
                                    h1: DefaultTextBlockStyle(
                                      TextStyle(
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                        letterSpacing: 0,
                                        fontSize: 30,
                                      ),
                                      HorizontalSpacing(2, 2),
                                      VerticalSpacing(2, 2),
                                      VerticalSpacing(2, 2),
                                      null,
                                    ),
                                    h2: DefaultTextBlockStyle(
                                      TextStyle(
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                        letterSpacing: 0,
                                        fontSize: 25,
                                      ),
                                      HorizontalSpacing(2, 2),
                                      VerticalSpacing(2, 2),
                                      VerticalSpacing(2, 2),
                                      null,
                                    ),
                                    h3: DefaultTextBlockStyle(
                                      TextStyle(
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                        letterSpacing: 0,
                                        fontSize: 20,
                                      ),
                                      HorizontalSpacing(2, 2),
                                      VerticalSpacing(2, 2),
                                      VerticalSpacing(2, 2),
                                      null,
                                    ),
                                    paragraph: DefaultTextBlockStyle(
                                      TextStyle(
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.normal,
                                        color: Colors.white,
                                        letterSpacing: 0,
                                        fontSize: 15,
                                      ),
                                      HorizontalSpacing(2, 2),
                                      VerticalSpacing(2, 2),
                                      VerticalSpacing(2, 2),
                                      null,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const ToolTipTitle(
                              titleText: 'Running Profit/Loss',
                              toolTipText:
                                  'This graph shows your Running Profit/Loss',
                            ),
                            const SizedBox(
                              height: PaddingSizes.small,
                            ),
                            Row(
                              children: [
                                const SvgIcon(
                                  TradelyIcons.trendUp,
                                  color: Color(0xFF14D39F),
                                ),
                                const SizedBox(width: PaddingSizes.medium),
                                RichText(
                                  text: TextSpan(
                                    text: "\$543,09",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                          fontSize: 35,
                                          fontWeight: FontWeight.w600,
                                        ),
                                    children: [
                                      TextSpan(
                                        text: " .24",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: PaddingSizes.large),
                            // Use fixed height for chart and list
                            const SizedBox(
                              height: 250, // Set a fixed height
                              child: EquityLineChart(
                                data: [],
                              ),
                            ),
                            const SizedBox(height: PaddingSizes.extraSmall),
                            const Divider(
                              color: Color(0xFF1F1F1F),
                            ),

                            Expanded(
                              child: GenericListView(
                                header: const CustomHeader(
                                  horizontalPadding: 20,
                                  children: [
                                    HeaderRowItem(
                                      flex: 1,
                                      text: 'Open Time',
                                    ),
                                    HeaderRowItem(
                                      flex: 1,
                                      text: 'Symbol',
                                    ),
                                    HeaderRowItem(
                                      flex: 1,
                                      text: 'Direction',
                                    ),
                                    HeaderRowItem(
                                      flex: 1,
                                      text: 'Status',
                                    ),
                                    HeaderRowItem(
                                      flex: 1,
                                      text: 'Net P/L',
                                    ),
                                    HeaderRowItem(
                                      flex: 1,
                                      text: 'Net ROI %',
                                    ),
                                  ],
                                ),
                                rows: widget.allRows,
                              ),
                            ),
                          ],
                        ),
                ),
                // Positioned button in the top right
                Positioned(
                  top: 37,
                  right: 30,
                  child: PrimaryButton(
                    onTap: () {
                      setState(() {
                        isAnnotationFieldVisible = !isAnnotationFieldVisible;
                      });
                    },
                    height: 38,
                    text: isAnnotationFieldVisible
                        ? 'Trading Stats'
                        : 'Annotations',
                    textStyle: theme.textTheme.titleMedium?.copyWith(
                      fontSize: 16,
                      color: const Color(0xFF2D62FE),
                    ),
                    color: const Color(0xFF111111),
                    outlined: true,
                    prefixIcon: isAnnotationFieldVisible
                        ? TradelyIcons.trendUp
                        : TradelyIcons.diary,
                    prefixIconSize: isAnnotationFieldVisible ? 13 : 17,
                    prefixIconColor: const Color(0xFF2D62FE),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                  ),
                ),
              ],
            ),
          ),
          const Expanded(
            flex: 1,
            child: Column(
              children: [
                Expanded(
                  child: DateSelectorContainer(),
                ),
                BaseContainer(
                  child: SmallDataList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
