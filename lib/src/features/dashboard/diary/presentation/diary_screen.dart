import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:tradelog_flutter/src/features/dashboard/diary/presentation/widgets/date_selector_container.dart';
import 'package:tradelog_flutter/src/ui/base/base_container_expanded.dart';
import 'package:tradelog_flutter/src/ui/base/base_tradely_page.dart';
import 'package:tradelog_flutter/src/ui/base/base_tradely_page_header.dart';
import 'package:tradelog_flutter/src/ui/buttons/primary_button.dart';
import 'package:tradelog_flutter/src/ui/icons/tradely_icons.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';

class DiaryScreen extends StatefulWidget {
  const DiaryScreen({super.key});

  static const String route = '/$location';
  static const String location = 'diary';

  @override
  _DiaryScreenState createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {
  final QuillController _controller = QuillController.basic();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseTradelyPage(
      header: BaseTradelyPageHeader(
        subTitle: "Lorem ipsum dolor sit amet consectetur lorem.",
        icon: TradelyIcons.diary,
        currentRoute: DiaryScreen.location,
        title: "Your diary",
        titleIconPath: 'assets/images/memo.png',
        buttons: PrimaryButton(
          onTap: () {},
          height: 42,
          text: "Add new trade",
          prefixIcon: TradelyIcons.plusCircle,
          prefixIconSize: 22,
        ),
      ),
      child: BaseContainerExpanded(
        flex: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: PaddingSizes.extraSmall,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFF161616),
                borderRadius: BorderRadius.circular(12),
              ),
              child: QuillToolbar.simple(
                controller: _controller,
                configurations: const QuillSimpleToolbarConfigurations(
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
        ),
      ),
    );
  }
}
