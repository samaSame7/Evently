import 'package:evently_6/ui/utils/app_colors.dart';
import 'package:evently_6/ui/utils/app_styles.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.onPress,
    required this.title,
    this.backColor = AppColors.blue,
    this.textStyle = AppTextStyles.white18Medium,
    this.icon,
  });
  final VoidCallback onPress;
  final String title;
  final Color? backColor;
  final TextStyle textStyle;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      style: ElevatedButton.styleFrom(
        backgroundColor: backColor,
        padding: EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[icon!, SizedBox(width: 16)],
          Text(title, style: textStyle),
        ],
      ),
    );
  }
}
