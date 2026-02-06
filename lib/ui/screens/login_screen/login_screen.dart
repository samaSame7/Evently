import 'package:evently_6/firebase_utils/auth_services.dart';
import 'package:evently_6/ui/utils/app_assets.dart';
import 'package:evently_6/ui/utils/app_colors.dart';
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
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
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
                  controller: emailController,
                ),
                SizedBox(height: 16),
                AppTextField(
                  hintText: "Enter your password",
                  isPassword: true,
                  preIcon: SvgPicture.asset(AppAssets.icLockSvg),
                  suffixIcon: SvgPicture.asset(AppAssets.icEyeClosedSvg),
                  controller: passwordController,
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
                buildGoogleButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppButton buildLoginButton() => AppButton(
    title: "Login",
    onPress: () async {
      await signInWithEmailPassword(
        context,
        emailController: emailController,
        passwordController: passwordController,
      );
    },
  );

  AppButton buildGoogleButton() {
    return AppButton(
      title: "Login with Google",
      backColor: AppColors.white,
      textStyle: AppTextStyles.blue18Medium,
      icon: Icon(Icons.g_mobiledata_outlined),
      onPress: () async {
        await signInWithGoogle(context);
      },
    );
  }
}
