import 'package:evently_6/ui/data_models/event_dm.dart';
import 'package:evently_6/ui/utils/app_assets.dart';
import 'package:evently_6/ui/utils/app_colors.dart';
import 'package:evently_6/ui/utils/app_routes.dart';
import 'package:evently_6/ui/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailsScreen extends StatelessWidget {
  final EventDm event;
  const DetailsScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              buildHeader(context),
              SizedBox(height: 16),
              SizedBox(
                height: MediaQuery.of(context).size.height * .27,
                child: ClipRRect(
                  clipBehavior: Clip.hardEdge,
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(event.category.imgPath, fit: BoxFit.fill),
                ),
              ),
              SizedBox(height: 16),
              Text(
                event.title,
                style: AppTextStyles.black16Medium.copyWith(fontSize: 20),
              ),
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: BoxBorder.all(color: AppColors.grey2),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: AppColors.offWhite,
                        borderRadius: BorderRadius.circular(8),
                        border: BoxBorder.all(color: AppColors.grey2),
                      ),
                      child: Image.asset(AppAssets.calenderIcon, width: 32),
                    ),

                    SizedBox(width: 16),
                    Column(
                      children: [
                        Text(
                          "${event.dateTime.day} ${DateFormat('MMM').format(event.dateTime)}",
                          style: AppTextStyles.black16Medium,
                        ),
                        //Text("${event.dateTime.day} ${event.dateTime.month}",style: AppTextStyles.black16Medium,),
                        SizedBox(height: 8),
                        Text(
                          "${event.dateTime.hour} ${event.dateTime.minute} AM",
                          style: AppTextStyles.grey14Regular.copyWith(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Text("Description", style: AppTextStyles.black16Medium),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: BoxBorder.all(color: AppColors.grey2),
                ),
                child: Text(
                  event.description,
                  style: AppTextStyles.black14Medium,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row buildHeader(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            height: 32,
            width: 32,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColors.blue,
            ),
          ),
        ),
        Spacer(),
        Text("Event Details", style: AppTextStyles.black20SemiBold),
        Spacer(),
        InkWell(
          onTap: () {
            Navigator.pushReplacement(
              context,
              AppRoutes.getEditEventScreen(event),
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Image.asset(AppAssets.editIcon),
          ),
        ),
        SizedBox(width: 8),
        InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Image.asset(AppAssets.deleteIcon),
          ),
        ),
      ],
    );
  }
}
