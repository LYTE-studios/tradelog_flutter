import 'dart:convert';
import 'package:image/image.dart' as img;

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'package:lyte_studios_flutter_ui/lyte_studios_flutter_ui.dart';
import 'package:tradelog_flutter/src/core/data/models/dto/users/overview_statistics_dto.dart';
import 'package:tradelog_flutter/src/core/data/models/dto/users/trade_list_dto.dart';
import 'package:tradelog_flutter/src/core/data/models/dto/users/trade_note_dto.dart';
import 'package:tradelog_flutter/src/core/data/services/users_service.dart';
import 'package:tradelog_flutter/src/features/dashboard/diary/presentation/widgets/date_selector_container.dart';
import 'package:tradelog_flutter/src/features/dashboard/overview/presentation/widgets/equity_line_chart.dart';
import 'package:tradelog_flutter/src/ui/base/base_container.dart';
import 'package:tradelog_flutter/src/ui/base/base_tradely_page.dart';
import 'package:tradelog_flutter/src/ui/base/base_tradely_page_header.dart';
import 'package:tradelog_flutter/src/ui/buttons/primary_button.dart';
import 'package:tradelog_flutter/src/ui/data/small_data_list.dart';
import 'package:tradelog_flutter/src/ui/icons/tradely_icons.dart';
import 'package:tradelog_flutter/src/ui/list/trade_list.dart';
import 'package:tradelog_flutter/src/ui/loading/tradely_loading_switcher.dart';
import 'package:tradelog_flutter/src/ui/text/tooltip_title.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';

class DiaryScreen extends StatefulWidget {
  const DiaryScreen({super.key});

  static const String route = '/$location';
  static const String location = 'diary';

  @override
  _DiaryScreenState createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> with ScreenStateMixin {
  TradeNoteDto? note;

  TradeListDto? trades;

  OverviewStatisticsDto? statistics;

  OverviewStatisticsDto? overallStatistics;

  Map<DateTime, double> chartData = {};

  double totalRoi = 0;

  bool isAnnotationFieldVisible = false;
  late final QuillController _controller = QuillController.basic()
    ..addListener(() {
      toBeUpdatedValue = jsonEncode(_controller.document.toDelta().toJson());
    });

  String toBeUpdatedValue = '';
  String lastUpdatedValue = '';

  DateTime selectedDate = DateTime.now();

  Future<String?> _saveImage(FilePickerResult result) async {
    try {
      final imageFile = result.files.single;
      final imageBytes = imageFile.bytes!;
      final imageName = imageFile.name;
      img.Image decodedImage = img.decodeImage(imageBytes)!;

      img.Image resizedImage = img.copyResize(
        decodedImage,
        width: 2048,
        height: 2048,
        maintainAspect: true,
      );

      return await UsersService().uploadFile(
        file: img.encodePng(resizedImage),
        name: imageName,
      );
    } catch (e) {
      return null;
    }
  }

  // Custom function to pick an image from the file system
  Future<void> _pickImageFromFile() async {
    setLoading(true);

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      String? url = await _saveImage(result);

      if (url == null) {
        return;
      }

      _controller.insertImageBlock(imageSource: url);
    }
    setLoading(false);
  }

  Future<void> update() async {
    lastUpdatedValue = toBeUpdatedValue;

    await UsersService().updateTradeNote(
      note: TradeNoteDto(
        note: lastUpdatedValue,
        date: note?.date ?? DateTime.now(),
      ),
    );
  }

  Future<void> startTicker() async {
    while (mounted) {
      await _checkUpdates();

      await Future.delayed(
        const Duration(
          seconds: 3,
        ),
      );
    }
  }

  Future<void> refresh() async {
    setLoading(true);
    await loadData();
    setLoading(false);
  }

  @override
  Future<void> loadData() async {
    DateTime date =
        DateTime(selectedDate.year, selectedDate.month, selectedDate.day);

    trades = await UsersService().fetchTrades(
      from: date,
      to: date.add(const Duration(days: 1)),
    );

    statistics = await UsersService().getAccountStatistics(
      from: date,
      to: date.add(const Duration(days: 1)),
    );

    overallStatistics = await UsersService().getAccountStatistics();

    note = await UsersService().getTradeNote(selectedDate);

    lastUpdatedValue = note!.note;

    setState(() {
      note = note;
      trades = trades;

      totalRoi = statistics?.overallStatistics.totalProfit ?? 0;

      if (note!.note.isNotEmpty) {
        _controller.document = Document.fromJson(jsonDecode(note!.note));
      } else {
        _controller.document = Document();
      }
    });
  }

  @override
  void initState() {
    startTicker();
    super.initState();
  }

  Future<void> _checkUpdates() async {
    if (toBeUpdatedValue != lastUpdatedValue) {
      if (note != null) {
        try {
          await update();
        } catch (e) {}
      }
    }
  }

  @override
  void dispose() async {
    await _checkUpdates();

    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return BaseTradelyPage(
      header: const BaseTradelyPageHeader(
        subTitle: "Review daily trading analytics, and add annotations.",
        icon: TradelyIcons.diary,
        currentRoute: DiaryScreen.location,
        title: "Your diary",
        titleIconPath: 'assets/images/emojis/pencil_emoji.png',
        // buttons: PrimaryButton(
        //   onTap: () => AddTradeDialog.show(context),
        //   height: 42,
        //   text: "Add new trade",
        //   prefixIcon: TradelyIcons.plusCircle,
        //   prefixIconSize: 22,
        // ),
      ),
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 640),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * .8,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 600,
                  width: 400,
                  child: Column(
                    children: [
                      Expanded(
                        child: DateSelectorContainer(
                          chartData: overallStatistics?.dayPerformances.map(
                            (date, performance) {
                              DateTime dateTime = DateTime.parse(date);

                              return MapEntry(
                                DateTime(
                                  dateTime.year,
                                  dateTime.month,
                                  dateTime.day,
                                ),
                                performance,
                              );
                            },
                          ),
                          onDateChanged: (date) {
                            date =
                                DateTime.utc(date.year, date.month, date.day);

                            setState(() {
                              selectedDate = date;
                            });

                            refresh();
                          },
                        ),
                      ),
                      const SizedBox(
                        width: PaddingSizes.extraSmall,
                      ),
                      BaseContainer(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const SvgIcon(
                                  TradelyIcons.trendUp,
                                  color: Colors.white,
                                  size: 10,
                                ),
                                const SizedBox(width: PaddingSizes.extraSmall),
                                Text(
                                  'Statistics',
                                  style: theme.textTheme.titleLarge?.copyWith(
                                    fontSize: 19,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: PaddingSizes.large),
                            SmallDataList(
                              totalTrades:
                                  statistics?.overallStatistics.totalTrades,
                              long: statistics?.overallStatistics.long ?? 0,
                              short: statistics?.overallStatistics.short ?? 0,
                              averageWin:
                                  statistics?.overallStatistics.averageWin,
                              averageLoss:
                                  statistics?.overallStatistics.averageLoss,
                              bestWin: statistics?.overallStatistics.bestWin,
                              bestLoss: statistics?.overallStatistics.worstLoss,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: PaddingSizes.extraSmall,
                ),
                Expanded(
                  flex: 2,
                  child: Stack(
                    children: [
                      BaseContainer(
                        padding: const EdgeInsets.only(
                          top: PaddingSizes.xxl,
                        ),
                        child: isAnnotationFieldVisible
                            ? Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: PaddingSizes.extraLarge,
                                ),
                                child: TradelyLoadingSwitcher(
                                  loading: loading,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 150),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: PaddingSizes.extraSmall,
                                          ),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF161616),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: QuillToolbar.simple(
                                            controller: _controller,
                                            configurations:
                                                QuillSimpleToolbarConfigurations(
                                              sectionDividerColor:
                                                  const Color(0xFF5C5C5C),
                                              toolbarIconAlignment:
                                                  WrapAlignment.start,
                                              embedButtons: FlutterQuillEmbeds
                                                  .toolbarButtons(
                                                videoButtonOptions: null,
                                                imageButtonOptions:
                                                    QuillToolbarImageButtonOptions(
                                                  imageButtonConfigurations:
                                                      QuillToolbarImageConfigurations(
                                                    onRequestPickImage:
                                                        (_, __) async {
                                                      await _pickImageFromFile();

                                                      return null;
                                                    },
                                                  ),
                                                ),
                                              ),
                                              showListNumbers: false,
                                              showListBullets: false,
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
                                      const SizedBox(
                                        height: PaddingSizes.extraLarge,
                                      ),
                                      Expanded(
                                        child: QuillEditor.basic(
                                          controller: _controller,
                                          configurations:
                                              QuillEditorConfigurations(
                                            embedBuilders: FlutterQuillEmbeds
                                                .editorWebBuilders(
                                              imageEmbedConfigurations:
                                                  QuillEditorImageEmbedConfigurations(
                                                onImageClicked:
                                                    (String image) {},
                                              ),
                                            ),
                                            placeholder: 'Add a note',
                                            customStyles: const DefaultStyles(
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
                                                null,
                                              ),
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
                                  ),
                                ),
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: PaddingSizes.extraLarge,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                            Visibility(
                                              visible: totalRoi != 0,
                                              child: SvgIcon(
                                                (totalRoi < 0)
                                                    ? TradelyIcons.trendDown
                                                    : TradelyIcons.trendUp,
                                                color: (totalRoi < 0)
                                                    ? const Color(0xFFF21111)
                                                    : const Color(0xFF14D39F),
                                              ),
                                            ),
                                            const SizedBox(
                                                width: PaddingSizes.medium),
                                            RichText(
                                              text: TextSpan(
                                                text:
                                                    "\$${totalRoi.abs().toStringAsFixed(0)}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge
                                                    ?.copyWith(
                                                      fontSize: 35,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                children: [
                                                  TextSpan(
                                                    text:
                                                        " .${totalRoi.toStringAsFixed(2).split(".")[1]}",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleMedium,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                            height: PaddingSizes.large),
                                        // Use fixed height for chart and list
                                        SizedBox(
                                          height: 250, // Set a fixed height
                                          child: EquityLineChart(
                                            noDataMessage: 'No Trades',
                                            from: selectedDate,
                                            to: selectedDate
                                                .add(const Duration(days: 1)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                      height: PaddingSizes.extraSmall),
                                  const Divider(
                                    color: Color(0xFF1F1F1F),
                                  ),
                                  Expanded(
                                    child: TradeList(
                                      sidePadding: 16,
                                      loading: loading,
                                      trades: trades?.trades ?? [],
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
                              isAnnotationFieldVisible =
                                  !isAnnotationFieldVisible;
                            });
                          },
                          height: 38,
                          text: isAnnotationFieldVisible
                              ? 'Trading Stats'
                              : 'Notes',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
