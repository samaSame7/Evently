import 'package:evently_6/firebase_utils/firestore_utility.dart';
import 'package:evently_6/ui/data_models/user_dm.dart';
import 'package:evently_6/ui/utils/app_assets.dart';
import 'package:evently_6/ui/utils/app_colors.dart';
import 'package:evently_6/ui/utils/app_dialogs.dart';
import 'package:evently_6/ui/utils/app_routes.dart';
import 'package:evently_6/ui/utils/app_styles.dart';
import 'package:evently_6/ui/widgets/app_button.dart';
import 'package:evently_6/ui/widgets/app_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
      try {
        showLoading(context);
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
              email: emailController.text,
              password: passwordController.text,
            );
        UserDm.currentUser = await getUserFromFirestore(credential.user!.uid);
        Navigator.pop(context);
        Navigator.push(context, AppRoutes.navigationScreen);
      } on FirebaseAuthException catch (e) {
        Navigator.pop(context);
        var message = "";
        if (e.code == 'user-not-found') {
          message = 'No user found for that email.';
        } else if (e.code == 'wrong-password') {
          message = 'Wrong password provided for that user.';
        } else {
          message =
              e.message ?? "Something went wrong, please, try again later";
        }
        showMessage(
          context,
          message,
          title: "Error",
          posText: "Ok",
          onPosClick: () {
            Navigator.pop(context);
          },
        );
      }
    },
  );
}
