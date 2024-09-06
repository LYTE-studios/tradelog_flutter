import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class LongShortGauge extends StatelessWidget {
  const LongShortGauge({super.key});

  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(
      axes: <RadialAxis>[
        RadialAxis(
          annotations: [
            GaugeAnnotation(
              positionFactor: 0.1,
              widget: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "543",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    "trades",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ],
          pointers: [
            RangePointer(
              pointerOffset: 0.05,
              value: 240,
              width: 0.15,
              sizeUnit: GaugeSizeUnit.factor,
              cornerStyle: CornerStyle.bothCurve,
              color: Theme.of(context).colorScheme.secondary,
            ),
            RangePointer(
              pointerOffset: 0.05,
              value: 50,
              width: 0.15,
              sizeUnit: GaugeSizeUnit.factor,
              cornerStyle: CornerStyle.bothCurve,
              color: Theme.of(context).colorScheme.primary,
            ),
          ],
          startAngle: 150,
          endAngle: 150,
          minimum: 0,
          maximum: 360,
          showLabels: false,
          showTicks: false,
          axisLineStyle: AxisLineStyle(
            thickness: 0.25,
            cornerStyle: CornerStyle.bothFlat,
            color: Theme.of(context).colorScheme.tertiaryContainer,
            thicknessUnit: GaugeSizeUnit.factor,
          ),
        )
      ],
    );
  }
}
