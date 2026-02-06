import 'package:evently_6/ui/data_models/category_dm.dart';
import 'package:evently_6/ui/data_models/event_dm.dart';
import 'package:evently_6/ui/utils/app_colors.dart';
import 'package:evently_6/ui/utils/app_styles.dart';
import 'package:flutter/material.dart';

class CategoriesTabBar extends StatefulWidget {
  final List<CategoryDm> categories;
  final Function(CategoryDm) onClick;
  final EventDm? event;

  const CategoriesTabBar({
    super.key,
    required this.categories,
    required this.onClick,
    this.event,
  });

  @override
  State<CategoriesTabBar> createState() => _CategoriesTabBarState();
}

class _CategoriesTabBarState extends State<CategoriesTabBar> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    final eventCategory = widget.event?.category;
    if (eventCategory != null) {
      final foundIndex = widget.categories.indexWhere(
        (cat) => cat.name == eventCategory.name,
      );
      if (foundIndex != -1) {
        selectedIndex = foundIndex;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.categories.length,
      initialIndex: selectedIndex,
      child: TabBar(
        tabs: widget.categories.map(mapCategoryToWidget).toList(),
        isScrollable: true,
        indicatorColor: Colors.transparent,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
          widget.onClick(widget.categories[index]);
        },
        dividerColor: Colors.transparent,
        tabAlignment: TabAlignment.start,
      ),
    );
  }

  Widget mapCategoryToWidget(CategoryDm category) {
    final isSelected = selectedIndex == widget.categories.indexOf(category);

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
