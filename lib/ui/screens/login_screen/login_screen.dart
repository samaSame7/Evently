import 'package:evently_6/ui/utils/app_assets.dart';
import 'package:evently_6/ui/utils/app_colors.dart';
import 'package:evently_6/ui/utils/app_dialogs.dart';
import 'package:evently_6/ui/utils/app_routes.dart';
import 'package:evently_6/ui/utils/app_styles.dart';
import 'package:evently_6/ui/widgets/app_button.dart';
import 'package:evently_6/ui/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.offWhite,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(AppAssets.appLogo),
              SizedBox(height: 32),
              Text(
                "Login to your account",
                style: AppTextStyles.blue24SemiBold,
              ),
              SizedBox(height: 24),
              AppTextField(
                hintText: "Enter your Email",
                preIcon: SvgPicture.asset(AppAssets.icEmailSvg),
              ),
              SizedBox(height: 16),
              AppTextField(
                hintText: "Enter your password",
                //isPassword: false,
                preIcon: SvgPicture.asset(AppAssets.icLockSvg),
                suffixIcon: SvgPicture.asset(AppAssets.icEyeClosedSvg),
              ),
              SizedBox(height: 8),
              Text(
                "Forget Password?",
                style: AppTextStyles.blue14SemiBold.copyWith(
                  decoration: TextDecoration.underline,
                ),
                textAlign: TextAlign.end,
              ),
              SizedBox(height: 48),
              buildLoginButton(),
              SizedBox(height: 48),
              InkWell(
                onTap: () => Navigator.push(context, AppRoutes.signupScreen),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: AppTextStyles.grey14Regular,
                    ),
                    Text(
                      "Signup",
                      style: AppTextStyles.blue14SemiBold.copyWith(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32),
              Text(
                "or",
                style: AppTextStyles.blue24SemiBold,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 48),
              AppButton(
                title: "Login with Google",
                onPress: () {},
                backColor: AppColors.white,
                textStyle: AppTextStyles.blue18Medium,
                icon: Icon(Icons.g_mobiledata_outlined),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppButton buildLoginButton() => AppButton(
    title: "Login",
    onPress: () async {
      ShowLoading(context);
      await Future.delayed(Duration(seconds: 1));
      Navigator.pop(context);
      ShowMessage(
        context,
        "Please try again later...",
        posText: "Ok",
        onPosClick: () {
          Navigator.pop(context);
        },
      );
    },
  );
}
