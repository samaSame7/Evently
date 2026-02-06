import 'package:evently_6/firebase_utils/auth_services.dart';
import 'package:evently_6/ui/utils/app_assets.dart';
import 'package:evently_6/ui/utils/app_colors.dart';
import 'package:evently_6/ui/utils/app_styles.dart';
import 'package:evently_6/ui/widgets/app_button.dart';
import 'package:evently_6/ui/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Form(
              key: key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(AppAssets.appLogo),
                  SizedBox(height: 32),
                  Text(
                    "Create your account",
                    style: AppTextStyles.blue24SemiBold,
                  ),
                  SizedBox(height: 24),
                  AppTextField(
                    hintText: "Enter your name",
                    preIcon: SvgPicture.asset(AppAssets.icPersonSvg),
                    controller: nameController,
                    validator: (text) {
                      if (text!.isEmpty) return "Please enter your name";
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  AppTextField(
                    hintText: "Enter your phone number",
                    preIcon: SvgPicture.asset(AppAssets.icPersonSvg),
                    controller: phoneController,
                    validator: (text) {
                      if (text!.isEmpty) {
                        return "Please enter your phone number";
                      }
                      if (text.length < 11) {
                        return "Please enter a valid phone number";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  AppTextField(
                    hintText: "Enter your Email",
                    preIcon: SvgPicture.asset(AppAssets.icEmailSvg),
                    controller: emailController,
                    validator: (text) {
                      if (text!.isEmpty) return "Please enter your email";
                      var isValid = RegExp(
                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
                      ).hasMatch(text);
                      if (!isValid) return "Please write a valid email";
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  AppTextField(
                    hintText: "Enter your password",
                    isPassword: true,
                    preIcon: SvgPicture.asset(AppAssets.icLockSvg),
                    suffixIcon: SvgPicture.asset(AppAssets.icEyeClosedSvg),
                    controller: passwordController,
                    validator: (text) {
                      if (text!.isEmpty) return "Please enter a password";
                      if (text.length < 6) {
                        return "Password can not be less than 6 digits";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  AppTextField(
                    hintText: "Confirm your password",
                    isPassword: true,
                    preIcon: SvgPicture.asset(AppAssets.icLockSvg),
                    suffixIcon: SvgPicture.asset(AppAssets.icEyeClosedSvg),
                    validator: (text) {
                      if (text!.isEmpty) return "Please enter a password";
                      if (text != passwordController.text) {
                        return "Password does not match";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 48),
                  buildSignupButton(),
                  SizedBox(height: 32),
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?",
                          style: AppTextStyles.grey14Regular,
                        ),
                        Text(
                          "Login",
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
                  SizedBox(height: 32),
                  buildGoogleSignupButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  AppButton buildGoogleSignupButton() {
    return AppButton(
      title: "Sign up with Google",
      backColor: AppColors.white,
      textStyle: AppTextStyles.blue18Medium,
      icon: const Icon(Icons.g_mobiledata_outlined),
      onPress: () async {
        await signUpWithGoogle(
          context,
          emailController: emailController,
          nameController: nameController,
          phoneController: phoneController,
        );
      },
    );
  }

  AppButton buildSignupButton() => AppButton(
    title: "Sign up",
    onPress: () async {
      if (!key.currentState!.validate()) return;
      await signUpWithEmailPassword(
        context,
        phoneController: phoneController,
        nameController: nameController,
        emailController: emailController,
        passwordController: passwordController,
      );
    },
  );
}
