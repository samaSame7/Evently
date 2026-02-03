import 'package:evently_6/ui/data_models/user_dm.dart';
import 'package:evently_6/ui/providers/language_provider.dart';
import 'package:evently_6/ui/providers/theme_provider.dart';
import 'package:evently_6/ui/utils/app_assets.dart';
import 'package:evently_6/ui/utils/app_colors.dart';
import 'package:evently_6/ui/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  bool languageSwitch = false;
  late LanguageProvider languageProvider;
  late ThemeProvider themeProvider;

  @override
  Widget build(BuildContext context) {
    languageProvider = Provider.of(context);
    themeProvider = Provider.of(context);
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          CircleAvatar(
            radius: 80,
            backgroundColor: AppColors.white,
            child: Image.asset(AppAssets.appLogo),
          ),
          SizedBox(height: 16),
          Text(UserDm.currentUser!.name, style: AppTextStyles.black20SemiBold),
          SizedBox(height: 16),
          Text(UserDm.currentUser!.email, style: AppTextStyles.grey14Regular),
          buildThemeRow(),
          SizedBox(height: 16),
          buildLanguageRow(),
          SizedBox(height: 16),
          buildLogoutRow(),
        ],
      ),
    );
  }

  Widget buildLanguageRow() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Text("Language"),
          Spacer(),
          Switch(
            value: languageProvider.currentLocale == "ar",
            onChanged: (value) {
              languageProvider.updateLocale(value ? "ar" : "en");
            },
          ),
        ],
      ),
    );
  }

  Widget buildThemeRow() => Container(
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(16),
    ),
    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
    child: Row(
      children: [
        Text("Dark mode"),
        Spacer(),
        Switch(
          value: themeProvider.themeMode == ThemeMode.dark,
          onChanged: (value) {
            themeProvider.updateTheme(value ? ThemeMode.dark : ThemeMode.light);
          },
        ),
      ],
    ),
  );

  Widget buildLogoutRow() => Container();
}
