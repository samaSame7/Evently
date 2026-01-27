import 'package:evently_6/ui/data_models/category_dm.dart';
import 'package:evently_6/ui/utils/app_colors.dart';
import 'package:evently_6/ui/utils/app_constants.dart';
import 'package:evently_6/ui/utils/app_styles.dart';
import 'package:evently_6/ui/widgets/app_button.dart';
import 'package:evently_6/ui/widgets/app_text_field.dart';
import 'package:evently_6/ui/widgets/categories_tab_bar.dart';
import 'package:flutter/material.dart';

class AddEventScreen extends StatefulWidget {
  const AddEventScreen({super.key});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  CategoryDm selectedCategory = AppConstants.customCategories[0];
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.offWhite,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text("Add event", style: AppTextStyles.blue24SemiBold),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .27,
                        child: Image.asset(selectedCategory.imgPath),
                      ),
                      SizedBox(height: 16),
                      CategoriesTabBar(
                        categories: AppConstants.customCategories,
                        onClick: (category) {
                          selectedCategory = category;
                          setState(() {});
                        },
                      ),
                      SizedBox(height: 16),
                      Text("Title", style: AppTextStyles.black16Medium),
                      SizedBox(height: 8),
                      AppTextField(hintText: "Event Title", controller: title),
                      SizedBox(height: 16),
                      Text("Description", style: AppTextStyles.black16Medium),
                      SizedBox(height: 8),
                      AppTextField(
                        hintText: "Event Description....",
                        minLine: 4,
                        controller: description,
                      ),
                      SizedBox(height: 16),
                      buildChooseDateRow(),
                      SizedBox(height: 16),
                      buildChooseTimeRow(),
                    ],
                  ),
                ),
              ),
              buildAddEventButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildChooseDateRow() => Row(
    children: [
      Icon(Icons.calendar_month, size: 24, color: AppColors.blue),
      SizedBox(width: 8),
      Text("Event Date", style: AppTextStyles.black16Medium),
      SizedBox(width: 8),
      Text('${selectedDate.day}/${selectedDate.month}/${selectedDate.year}'),
      Spacer(),
      InkWell(
        onTap: () async {
          selectedDate =
              await showDatePicker(
                initialDate: selectedDate,
                context: context,
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(Duration(days: 365)),
              ) ??
              selectedDate;
          setState(() {});
        },
        child: Text(
          "Choose Date",
          style: AppTextStyles.blue14SemiBold.copyWith(
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    ],
  );

  Widget buildChooseTimeRow() => Row(
    children: [
      Icon(Icons.access_time, size: 24, color: AppColors.blue),
      SizedBox(width: 8),
      Text("Event Time", style: AppTextStyles.black16Medium),
      SizedBox(width: 8),
      Text("${selectedTime.hour}:${selectedTime.minute}"),
      Spacer(),
      InkWell(
        onTap: () async {
          selectedTime =
              await showTimePicker(
                context: context,
                initialTime: selectedTime,
              ) ??
              selectedTime;
          setState(() {});
        },
        child: Text(
          "Choose Time",
          style: AppTextStyles.blue14SemiBold.copyWith(
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    ],
  );

  Widget buildAddEventButton() {
    return AppButton(onPress: () {}, title: "Add Event");
  }
}
