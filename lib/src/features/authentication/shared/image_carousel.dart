import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lyte_studios_flutter_ui/lyte_studios_flutter_ui.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tradelog_flutter/src/ui/icons/tradely_icons.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';

// todo better name for this?
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
        if (nextPage >= 3) {
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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(
          height: PaddingSizes.xxxxl,
        ),
        const SvgIcon(
          TradelyIcons.tradelyLogoInverted,
          leaveUnaltered: true,
          size: 50,
        ),
        const Spacer(),
        SizedBox(
          height: 500,
          child: PageView(
            controller: controller,
            children: const [
              Center(
                child: Image(
                  width: 530,
                  fit: BoxFit.contain,
                  image: AssetImage('assets/images/auth_pic_1.png'),
                ),
              ),
              Center(
                child: Image(
                  width: 670,
                  fit: BoxFit.contain,
                  image: AssetImage('assets/images/auth_pic_2.png'),
                ),
              ),
              Center(
                child: Image(
                  width: 560,
                  fit: BoxFit.contain,
                  image: AssetImage('assets/images/auth_pic_3.png'),
                ),
              ),
            ],
          ),
        ),
        const Spacer(),
        Text(
          'Transform your trading \n routine, journal every trade',
          style: Theme.of(context).textTheme.titleLarge,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: PaddingSizes.extraLarge,
        ),
        Text(
          "Record all your trades and monitor \n performance metrics to maximize your trading \n success.",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 16,
                color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.5),
              ),
        ),
        const SizedBox(
          height: PaddingSizes.xxxxl,
        ),
        SmoothPageIndicator(
          controller: controller,
          count: 3,
          effect: WormEffect(
            dotHeight: 8,
            dotWidth: 40,
            type: WormType.normal,
            activeDotColor: Theme.of(context).colorScheme.onPrimary,
            dotColor: Theme.of(context).colorScheme.onPrimary.withOpacity(0.5),
          ),
        ),
        const SizedBox(
          height: PaddingSizes.xxxxl,
        ),
      ],
    );
  }
}
