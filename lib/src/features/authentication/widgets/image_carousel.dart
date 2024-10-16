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
      children: [
        const Padding(
          padding: EdgeInsets.only(
            top: PaddingSizes.xxl * 2,
          ),
          child: SvgIcon(
            TradelyIcons.tradelyLogoInverted,
            leaveUnaltered: true,
            size: 37,
          ),
        ),
        Flexible(
          fit: FlexFit.tight,
          child: PageView(
            clipBehavior: Clip.none,
            controller: controller,
            physics: const NeverScrollableScrollPhysics(),
            children: const [
              _BaseImageCarouselItem(
                imageAsset: 'assets/images/auth_pic_1.png',
                title: 'Transform your trading \n routine, journal every trade',
                description:
                    "Record all your trades and monitor \n performance metrics to maximize your trading \n success.",
                shadowOffset: Offset(
                  -160,
                  -160,
                ),
              ),
              _BaseImageCarouselItem(
                imageAsset: 'assets/images/auth_pic_2.png',
                title: 'Transform your trading \n routine, journal every trade',
                description:
                    "Record all your trades and monitor \n performance metrics to maximize your trading \n success.",
                shadowOffset: Offset(
                  -80,
                  -120,
                ),
              ),
              _BaseImageCarouselItem(
                imageAsset: 'assets/images/auth_pic_3.png',
                title: 'Transform your trading \n routine, journal every trade',
                description:
                    "Record all your trades and monitor \n performance metrics to maximize your trading \n success.",
                shadowOffset: Offset(
                  -160,
                  -160,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: PaddingSizes.xxxxl,
        ),
        SmoothPageIndicator(
          controller: controller,
          count: 3,
          effect: WormEffect(
            spacing: 12,
            dotHeight: 6,
            dotWidth: 32,
            type: WormType.normal,
            activeDotColor: Theme.of(context).colorScheme.onPrimary,
            dotColor: Theme.of(context).colorScheme.onPrimary.withOpacity(0.3),
          ),
        ),
        const SizedBox(
          height: PaddingSizes.xxxxl * 2,
        ),
      ],
    );
  }
}

class _BaseImageCarouselItem extends StatelessWidget {
  final String imageAsset;

  final String title;

  final String description;

  final Offset shadowOffset;

  const _BaseImageCarouselItem({
    super.key,
    required this.imageAsset,
    required this.title,
    required this.description,
    required this.shadowOffset,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          bottom: 0,
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              height: 300,
              width: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(.4),
                    spreadRadius: 10,
                    blurRadius: 500,
                    blurStyle: BlurStyle.inner,
                    offset: shadowOffset,
                  ),
                  BoxShadow(
                    color: Colors.white.withOpacity(.4),
                    spreadRadius: 10,
                    blurRadius: 500,
                    blurStyle: BlurStyle.outer,
                    offset: shadowOffset,
                  ),
                ],
                color: Colors.transparent,
              ),
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: PaddingSizes.xxxl,
            ),
            Center(
              child: Image(
                height: MediaQuery.of(context).size.height * 0.4,
                width: 560,
                fit: BoxFit.contain,
                image: AssetImage(imageAsset),
              ),
            ),
            if (MediaQuery.of(context).size.height > 810)
              Column(
                children: [
                  const SizedBox(
                    height: PaddingSizes.extraLarge,
                  ),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 42,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: PaddingSizes.extraLarge,
                  ),
                  Text(
                    description,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Theme.of(context)
                              .colorScheme
                              .onPrimary
                              .withOpacity(0.5),
                        ),
                  ),
                ],
              ),
          ],
        ),
      ],
    );
  }
}
