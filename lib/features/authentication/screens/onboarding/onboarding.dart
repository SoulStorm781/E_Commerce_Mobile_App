import 'package:af_store/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:af_store/features/authentication/screens/onboarding/widgets/onboarding_navigation.dart';
import 'package:af_store/features/authentication/screens/onboarding/widgets/onboarding_next.dart';
import 'package:af_store/features/authentication/screens/onboarding/widgets/onboarding_page.dart';
import 'package:af_store/features/authentication/screens/onboarding/widgets/onboarding_skip.dart';

import 'package:af_store/utils/constants/image_strings.dart';
import 'package:af_store/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());
    return Scaffold(
        body: Stack(
      children: [
        PageView(
          controller: controller.pageController,
          onPageChanged: controller.updatePageIndicator,
          children: const [
            onBoardingPage(
                image: FImages.onBoarding1,
                title: FTexts.onBoardingTitle1,
                subtitle: FTexts.onBoardingSubtitle1),
            onBoardingPage(
                image: FImages.onBoarding2,
                title: FTexts.onBoardingTitle2,
                subtitle: FTexts.onBoardingSubtitle2),
            onBoardingPage(
                image: FImages.onBoarding3,
                title: FTexts.onBoardingTitle3,
                subtitle: FTexts.onBoardingSubtitle3),
          ],
        ),
        //Skip Button
        const onBoardingSkip(),

        //Dot Navigation Smmothe Page Indicator
        const onBoardingNavigation(),

        //Circular Button
        const onBoardingNextButton(),
      ],
    ));
  }
}
