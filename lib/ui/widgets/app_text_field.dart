import 'package:evently_6/ui/utils/app_colors.dart';
import 'package:evently_6/ui/utils/app_styles.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.preIcon,
    this.suffixIcon,
    required this.hintText,
    this.isPassword = false,
  });
  final Widget? preIcon;
  final Widget? suffixIcon;
  final String hintText;
  final bool isPassword;

  @override
  Widget build(BuildContext context) {
    var border = OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.grey2, width: 1),
      borderRadius: BorderRadius.circular(16),
    );
    return TextField(
      obscureText: isPassword,
      decoration: InputDecoration(
        prefixIcon: preIcon,
        suffixIcon: suffixIcon,
        hintText: hintText,
        hintStyle: AppTextStyles.grey14Regular,
        border: border,
        errorBorder: border,
        enabledBorder: border,
        disabledBorder: border,
        focusedBorder: border,
        focusedErrorBorder: border,
        fillColor: AppColors.white,
        filled: true,
        prefixIconConstraints: BoxConstraints(maxWidth: 24, maxHeight: 24),
        suffixIconConstraints: BoxConstraints(maxWidth: 24, maxHeight: 24),
      ),
      cursorColor: AppColors.blue,
    );
  }
}
