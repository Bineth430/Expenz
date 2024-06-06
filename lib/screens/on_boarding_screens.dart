import 'package:expenz/constants/colors.dart';
import 'package:expenz/screens/user_data.dart';
import 'package:expenz/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:expenz/data/on_boarding_data.dart';
import 'package:expenz/screens/onboarding/front_page.dart';
import 'package:expenz/screens/onboarding/shared_onboarding.dart';

class OnBoardingScreens extends StatefulWidget {
  const OnBoardingScreens({super.key});

  @override
  State<OnBoardingScreens> createState() => _OnBoardingScreensState();
}

class _OnBoardingScreensState extends State<OnBoardingScreens> {
  //page controller
  final PageController _controller = PageController();
  bool showDetailsPage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                //OnBoardingScreens
                PageView(
                  controller: _controller,
                  onPageChanged: (index) {
                    setState(() {
                      showDetailsPage = index == 3;
                    });
                  },
                  children: [
                    const FrontPage(),
                    SharedOnboardingScreen(
                      title: OnBoardingData.OnboardingDataList[0].title,
                      imagePath: OnBoardingData.OnboardingDataList[0].imagePath,
                      description:
                          OnBoardingData.OnboardingDataList[0].description,
                    ),
                    SharedOnboardingScreen(
                      title: OnBoardingData.OnboardingDataList[1].title,
                      imagePath: OnBoardingData.OnboardingDataList[1].imagePath,
                      description:
                          OnBoardingData.OnboardingDataList[1].description,
                    ),
                    SharedOnboardingScreen(
                      title: OnBoardingData.OnboardingDataList[2].title,
                      imagePath: OnBoardingData.OnboardingDataList[0].imagePath,
                      description:
                          OnBoardingData.OnboardingDataList[0].description,
                    ),
                  ],
                ),

                //page dot indicators
                Container(
                  alignment: const Alignment(0, 0.75),
                  child: SmoothPageIndicator(
                    controller: _controller,
                    count: 4,
                    effect: const ExpandingDotsEffect(
                      activeDotColor: kMainColor,
                      dotColor: kLightGrey,
                    ),
                  ),
                ),

                //navigation button
                Positioned(
                  bottom: 20,
                  left: 0,
                  right: 0,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                      ),
                      child: !showDetailsPage
                          ? GestureDetector(
                              onTap: () {
                                _controller.animateToPage(
                                  _controller.page!.toInt() + 1,
                                  duration: const Duration(microseconds: 400),
                                  curve: Curves.easeInOut,
                                );
                              },
                              child: CustomButton(
                                buttonName:
                                    showDetailsPage ? "Get Started" : "Next",
                                buttonColor: kMainColor,
                              ),
                            )
                          : GestureDetector(
                              onTap: () {
                                //navigate to the user data screen
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const UserDataScreen(),
                                  ),
                                );
                              },
                              child: CustomButton(
                                buttonName:
                                    showDetailsPage ? "Get Started" : "Next",
                                buttonColor: kMainColor,
                              ),
                            )),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
