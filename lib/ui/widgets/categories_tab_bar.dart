import 'package:evently_6/ui/data_models/category_dm.dart';
import 'package:evently_6/ui/utils/app_colors.dart';
import 'package:evently_6/ui/utils/app_constants.dart';
import 'package:evently_6/ui/utils/app_styles.dart';
import 'package:evently_6/ui/data_models/event_dm.dart';
import 'package:flutter/material.dart';

class CategoriesTabBar extends StatefulWidget {
  final List<CategoryDm> categories;
  final Function(CategoryDm) onClick;

  const CategoriesTabBar({
    super.key,
    required this.categories,
    required this.onClick,
  });

  @override
  State<CategoriesTabBar> createState() => _CategoriesTabBarState();
}

class _CategoriesTabBarState extends State<CategoriesTabBar> {
  int selectedCategory = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.categories.length,
      child: TabBar(
        tabs: widget.categories.map(mapCategoryToWidget).toList(),
        isScrollable: true,
        indicatorColor: Colors.transparent,
        padding: EdgeInsets.all(0),
        onTap: (index) {
          selectedCategory = index;
          widget.onClick(widget.categories[index]);
          setState(() {});
        },
        dividerColor: Colors.transparent,
        tabAlignment: TabAlignment.start,
      ),
    );
  }

  Widget mapCategoryToWidget(CategoryDm category) {
    bool isSelected = selectedCategory == widget.categories.indexOf(category);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: isSelected ? AppColors.blue : AppColors.white,
      ),
      child: Row(
        children: [
          Icon(
            category.icon,
            color: isSelected ? AppColors.white : AppColors.blue,
          ),
          SizedBox(width: 8),
          Text(
            category.name,
            style: isSelected
                ? AppTextStyles.white14Medium
                : AppTextStyles.blue14SemiBold,
          ),
        ],
      ),
    );
  }
}
