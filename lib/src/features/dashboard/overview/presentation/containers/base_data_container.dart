import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/ui/base/base_container_expanded.dart';
import 'package:tradelog_flutter/src/ui/text/tooltip_title.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';

class BaseDataContainer extends StatelessWidget {
  final String title;
  final String toolTip;
  final Widget child;
  final bool? isSuffixIcon;
  final bool? isPrefixIcon;
  final String? titleImage; // Add this parameter
  final VoidCallback? onViewAllTrades;
  final VoidCallback? onRefresh;
  final String? buttonText; // Add this parameter
  final Widget? customButtonContent; // Add this
  final Widget? additionalHeaderWidget; // Add this

  const BaseDataContainer({
    super.key,
    required this.title,
    required this.toolTip,
    required this.child,
    this.isSuffixIcon = false,
    this.isPrefixIcon = true,
    this.titleImage, // Add this parameter
    this.onViewAllTrades,
    this.onRefresh,
    this.buttonText, // Add this parameter
    this.customButtonContent, // Add this
    this.additionalHeaderWidget, // Add this
  });

  @override
  Widget build(BuildContext context) {
    return BaseContainerExpanded(
      padding: const EdgeInsets.all(PaddingSizes.large),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (titleImage != null)
                Container(
                  width: 16,
                  height: 16,
                  margin: const EdgeInsets.only(right: 8),
                  child: Image.asset(
                    titleImage!,
                    width: 15,
                    height: 15,
                    fit: BoxFit.contain,
                  ),
                ),
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontSize: 14, // Increased from 13 to 14
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF666D80),
                      ),
                ),
              ),
              if (onViewAllTrades != null)
                TextButton(
                  onPressed: onViewAllTrades,
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: const BorderSide(color: Color(0xFF272835)),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                  child: customButtonContent ??
                      Text(
                        buttonText ??
                            'View More', // Use buttonText if provided, otherwise default to 'View More'
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontSize: 14, // Increased from 13 to 14
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF666D80),
                                ),
                      ),
                ),
              if (additionalHeaderWidget != null) additionalHeaderWidget!,
            ],
          ),
          Expanded(child: child),
        ],
      ),
    );
  }
}
