import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/core/data/models/enums/trade_enums.dart';
import 'package:tradelog_flutter/src/features/dashboard/overview/presentation/widgets/long_short_color_identifier.dart';
import 'package:tradelog_flutter/src/features/dashboard/overview/presentation/widgets/long_short_gauge.dart';
import 'package:tradelog_flutter/src/ui/base/base_container.dart';
import 'package:tradelog_flutter/src/ui/data/small_data_list.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';

class LongShortContainer extends StatefulWidget {
  final int long;
  final int short;

  final double? averageWin;
  final double? averageLoss;

  final double? bestWin;
  final double? bestLoss;

  final bool loading;

  const LongShortContainer({
    super.key,
    required this.long,
    required this.short,
    this.averageWin,
    this.averageLoss,
    this.bestWin,
    this.bestLoss,
    this.loading = false,
  });

  @override
  State<LongShortContainer> createState() => _LongShortContainerState();
}

class _LongShortContainerState extends State<LongShortContainer> {
  TradeOption selected = TradeOption.long;

  void setSelected(TradeOption value) {
    setState(() {
      selected = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseContainer(
      padding: const EdgeInsets.all(
        PaddingSizes.large,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Long/short trades",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontSize: 14,
                ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: PaddingSizes.medium,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: PaddingSizes.large,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxHeight: 200,
                          maxWidth: 256,
                        ),
                        child: LongShortGauge(
                          long: widget.long,
                          short: widget.short,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: LongShortColorIdentifier(),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 64,
            child: SmallDataList(
              totalTrades: widget.long + widget.short,
              long: widget.long,
              short: widget.short,
              averageWin: widget.averageWin,
              averageLoss: widget.averageLoss,
              bestWin: widget.bestWin,
              bestLoss: widget.bestLoss,
            ),
          ),
        ],
      ),
    );
  }
}
