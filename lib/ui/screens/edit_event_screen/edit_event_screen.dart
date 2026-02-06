import 'package:evently_6/firebase_utils/firestore_utility.dart';
import 'package:evently_6/ui/data_models/category_dm.dart';
import 'package:evently_6/ui/data_models/event_dm.dart';
import 'package:evently_6/ui/utils/app_colors.dart';
import 'package:evently_6/ui/utils/app_constants.dart';
import 'package:evently_6/ui/utils/app_dialogs.dart';
import 'package:evently_6/ui/utils/app_styles.dart';
import 'package:evently_6/ui/widgets/app_button.dart';
import 'package:evently_6/ui/widgets/app_text_field.dart';
import 'package:evently_6/ui/widgets/categories_tab_bar.dart';
import 'package:flutter/material.dart';

class EditEventScreen extends StatefulWidget {
  final EventDm event;

  const EditEventScreen({super.key, required this.event});

  @override
  State<EditEventScreen> createState() => _EditEventScreenState();
}

class _EditEventScreenState extends State<EditEventScreen> {
  late CategoryDm selectedCategory = widget.event.category;
  late DateTime selectedDate = widget.event.dateTime;
  late TimeOfDay selectedTime = TimeOfDay.fromDateTime(widget.event.dateTime);
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: buildAppBar(context),
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
                          setState(() {
                            selectedCategory = category;
                          });
                        },
                        event: widget.event,
                      ),
                      SizedBox(height: 16),
                      Text("Title", style: AppTextStyles.black16Medium),
                      SizedBox(height: 8),
                      AppTextField(
                        hintText: "Event Title",
                        controller: titleController,
                      ),
                      SizedBox(height: 16),
                      Text("Description", style: AppTextStyles.black16Medium),
                      SizedBox(height: 8),
                      AppTextField(
                        hintText: "Event Description....",
                        minLine: 4,
                        controller: descriptionController,
                      ),
                      SizedBox(height: 16),
                      buildChooseDateRow(),
                      SizedBox(height: 16),
                      buildChooseTimeRow(),
                    ],
                  ),
                ),
              ),
              buildUpdateEventButton(),
            ],
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      title: Text("Edit event", style: AppTextStyles.black20SemiBold),
      centerTitle: true,
      leading: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
          child: Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.blue),
        ),
      ),
      automaticallyImplyLeading: false,
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

  Widget buildUpdateEventButton() {
    return AppButton(
      title: "Update Event",
      onPress: () async {
        showLoading(context);
        selectedDate = DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          selectedTime.hour,
          selectedTime.minute,
        );
        EventDm updatedEvent = widget.event.copyWith(
          title: titleController.text.trim(),
          description: descriptionController.text.trim(),
          category: selectedCategory,
          dateTime: selectedDate,
        );
        await updateEventInFirestore(updatedEvent);
        Navigator.pop(context);
        Navigator.pop(context);
      },
    );
  }
}
