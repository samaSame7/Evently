import 'package:evently_6/ui/data_models/category_dm.dart';
import 'package:evently_6/ui/data_models/onboarding_content_dm.dart';
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

  static final List<OnboardingContentDm> onboardingContent = [
    OnboardingContentDm(
      imagePath: AppAssets.onboarding1,
      title: "Find Events That Inspire You",
      description:
      "Dive into a world of events crafted to fit your unique interests. Whether you're into live music, art workshops, professional networking, or simply discovering new experiences, we have something for everyone.",
    ),
    OnboardingContentDm(
      imagePath: AppAssets.onboarding2,
      title: "Effortless Event Planning",
      description:
      "Take the hassle out of organizing events with our all-in-one planning tools. From setting up invites and managing RSVPs to scheduling reminders and coordinating details, we've got you covered.",
    ),
    OnboardingContentDm(
      imagePath: AppAssets.onboarding3,
      title: "Connect with Friends & Share Moments",
      description:
      "Make every event memorable by sharing the experience with others. Our platform lets you invite friends, keep everyone in the loop, and celebrate moments together.",
    ),
  ];

}
