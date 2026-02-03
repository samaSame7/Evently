import 'package:evently_6/ui/utils/app_assets.dart';
import 'package:evently_6/ui/utils/app_colors.dart';
import 'package:evently_6/ui/utils/app_constants.dart';
import 'package:evently_6/ui/utils/app_routes.dart';
import 'package:evently_6/ui/utils/app_styles.dart';
import 'package:evently_6/ui/widgets/app_button.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  static const String routeName = "onboarding";
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController pageController = PageController();
  int activePage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    buildHeader(),
                    const SizedBox(height: 24),
                    Expanded(child: buildImgPages()),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        AppConstants.onboardingContent.length,
                        (index) => buildAnimatedDot(index),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      AppConstants.onboardingContent[activePage].title,
                      style: AppTextStyles.black20SemiBold,
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      AppConstants.onboardingContent[activePage].description,
                      style: AppTextStyles.grey14Regular.copyWith(fontSize: 18),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
              AppButton(
                title: activePage == AppConstants.onboardingContent.length - 1
                    ? "Get Started"
                    : "Next",
                onPress: onButtonPress,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (activePage > 0)
          InkWell(
            onTap: () {
              pageController.previousPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
            child: Container(
              height: 32,
              width: 32,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: AppColors.blue,
              ),
            ),
          )
        else
          const SizedBox(width: 32),
        Image.asset(AppAssets.appLogo, height: 30),
        if (activePage != AppConstants.onboardingContent.length - 1)
          InkWell(
            onTap: () {
              Navigator.pushReplacement(context, AppRoutes.loginScreen);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text("Skip", style: AppTextStyles.blue14SemiBold),
            ),
          )
        else
          const SizedBox(width: 60),
      ],
    );
  }

  PageView buildImgPages() {
    return PageView.builder(
      controller: pageController,
      itemCount: AppConstants.onboardingContent.length,
      onPageChanged: (index) {
        setState(() {
          activePage = index;
        });
      },
      itemBuilder: (context, index) {
        return Image.asset(AppConstants.onboardingContent[index].imagePath);
      },
    );
  }

  Widget buildAnimatedDot(int index) {
    bool isActive = activePage == index;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 8,
      width: isActive ? 20 : 8,
      decoration: BoxDecoration(
        color: isActive ? AppColors.blue : AppColors.grey2,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  void onButtonPress() {
    if (activePage < AppConstants.onboardingContent.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushReplacement(context, AppRoutes.loginScreen);
    }
  }
}
