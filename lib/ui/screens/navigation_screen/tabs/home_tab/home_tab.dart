import 'package:evently_6/firebase_utils/firestore_utility.dart';
import 'package:evently_6/ui/data_models/category_dm.dart';
import 'package:evently_6/ui/data_models/user_dm.dart';
import 'package:evently_6/ui/utils/app_colors.dart';
import 'package:evently_6/ui/utils/app_constants.dart';
import 'package:evently_6/ui/utils/app_styles.dart';
import 'package:evently_6/ui/data_models/event_dm.dart';
import 'package:evently_6/ui/widgets/categories_tab_bar.dart';
import 'package:evently_6/ui/widgets/event_widget.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  List<EventDm> events = [];
  List<EventDm> filteredEvents = [];
  CategoryDm selectedCategory = AppConstants.allCategories[0];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          buildScreenHeader(),
          Text(UserDm.currentUser!.name, style: AppTextStyles.black20SemiBold),
          SizedBox(height: 15),
          FutureBuilder(
            future: getEventsFromFirestore(),
            builder: (context, snapshot) {
              events = snapshot.data!;
              filterEvents();
              if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              } else if (snapshot.hasData) {
                return Expanded(
                  child: Column(
                    children: [buildCategoriesTabBar(), buildEventsList()],
                  ),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
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
      onClick: (category) {
        selectedCategory = category;
        setState(() {});
      },
    );
  }

  void filterEvents() {
    if (selectedCategory != AppConstants.all) {
      filteredEvents = events.where((event) {
        return event.category.name == selectedCategory.name;
      }).toList();
    } else {
      filteredEvents = events;
    }
  }

  Widget buildEventsList() {
    return Expanded(
      child: ListView.builder(
        itemCount: filteredEvents.length,
        itemBuilder: (context, index) =>
            EventWidget(event: filteredEvents[index]),
      ),
    );
  }
}
