import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lyte_studios_flutter_ui/lyte_studios_flutter_ui.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tradelog_flutter/src/ui/icons/tradely_icons.dart';

class ImageCarousel extends StatefulWidget {
  const ImageCarousel({super.key});

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  final PageController controller = PageController();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  @override
  void dispose() {
    _timer?.cancel();
    controller.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (controller.hasClients) {
        int nextPage = controller.page!.round() + 1;
        if (nextPage >= 4) {
          nextPage = 0;
        }
        controller.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 750),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SvgIcon(
          TradelyIcons.tradelyLogoInverted,
          leaveUnaltered: true,
          size: 50,
        ),
        SizedBox(
          height: 500,
          child: PageView(
            controller: controller,
            children: const [
              Image.asset(name),
              Text('data'),
              Text('zaza'),
              Text('daazqsdta'),
            ],
          ),
        ),
        Text(
          'Transform your trading \n routine, journal every trade',
          style: Theme.of(context).textTheme.titleLarge,
          textAlign: TextAlign.center,
        ),
        SmoothPageIndicator(
          controller: controller,
          count: 3,
          effect: WormEffect(
            dotHeight: 8,
            dotWidth: 40,
            type: WormType.normal,
            activeDotColor: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ],
    );
  }
}
