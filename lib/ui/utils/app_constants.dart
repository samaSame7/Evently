import 'package:evently_6/ui/data_models/category_dm.dart';
import 'package:evently_6/ui/utils/app_assets.dart';
import 'package:flutter/material.dart';

abstract final class AppConstants {
  static final CategoryDm all = CategoryDm(
    name: "All",
    imgPath: "",
    icon: Icons.border_all_rounded,
  );
  static final CategoryDm sports = CategoryDm(
    name: "Sports",
    imgPath: AppAssets.sportLight,
    icon: Icons.bike_scooter,
  );
  static final CategoryDm bookingClub = CategoryDm(
    name: "Booking club",
    imgPath: AppAssets.bookClubLight,
    icon: Icons.menu_book,
  );
  static final CategoryDm birthday = CategoryDm(
    name: "Birthday",
    imgPath: AppAssets.birthdayLight,
    icon: Icons.cake,
  );
  static final CategoryDm meeting = CategoryDm(
    name: "Meeting",
    imgPath: AppAssets.meetingLight,
    icon: Icons.meeting_room,
  );
  static final CategoryDm exhibition = CategoryDm(
    name: "Exhibition",
    imgPath: AppAssets.exhibitionLight,
    icon: Icons.access_time_filled_rounded,
  );

  static List<CategoryDm> allCategories = [all, sports, bookingClub, birthday, meeting, exhibition];
  static List<CategoryDm> customCategories = [sports, bookingClub, birthday, meeting, exhibition];
}
