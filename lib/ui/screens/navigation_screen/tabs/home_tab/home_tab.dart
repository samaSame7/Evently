import 'package:evently_6/ui/data_models/category_dm.dart';
import 'package:evently_6/ui/utils/app_assets.dart';
import 'package:evently_6/ui/utils/app_colors.dart';
import 'package:evently_6/ui/utils/app_constants.dart';
import 'package:evently_6/ui/utils/app_styles.dart';
import 'package:evently_6/ui/data_models/event_dm.dart';
import 'package:evently_6/ui/widgets/categories_tab_bar.dart';
import 'package:evently_6/ui/widgets/event_widget.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          buildScreenHeader(),
          Text("Sama Sameh", style: AppTextStyles.black20SemiBold),
          SizedBox(height: 15),
          buildCategoriesTabBar(),
          buildEventsList(),
        ],
      ),
    );
  }

  Widget buildScreenHeader() {
    return Row(
      children: [
        Text("Welcome back", style: AppTextStyles.grey14Regular),
        Spacer(),
        Icon(Icons.brightness_5, color: AppColors.blue),
        SizedBox(width: 8),
        Container(
          padding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          decoration: BoxDecoration(
            color: AppColors.blue,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text("En", style: AppTextStyles.white14Medium),
        ),
      ],
    );
  }

  Widget buildCategoriesTabBar() {
    return CategoriesTabBar(
      categories: AppConstants.allCategories,
      onClick: (CategoryDm category) {},
    );
  }

  Widget buildEventsList() {
    CategoryDm category = CategoryDm(
      name: "Sports",
      imgPath: AppAssets.sportLight,
      icon: Icons.bike_scooter_sharp,
    );
    EventDm event = EventDm(
      title: "Sports",
      description:
          "my sports my sports my sport sports my sports my sports my sports my sports my sports ",
      category: category,
      dateTime: DateTime.now(),
    );
    return Expanded(
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) => EventWidget(event: event),
      ),
    );
  }
}
