import 'package:evently_6/ui/utils/app_colors.dart';
import 'package:evently_6/ui/utils/app_styles.dart';
import 'package:evently_6/ui/widgets/app_dms.dart';
import 'package:flutter/material.dart';

class EventWidget extends StatelessWidget {
  const EventWidget({super.key, required this.event});
  final EventDm event;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .24,
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(8),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(event.category.imgPath),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [buildEventDate(), buildEventTitle()],
          ),
        ],
      ),
    );
  }

  buildEventDate() => Align(
    alignment: Alignment.topLeft,
    child: Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.offWhite,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        "${event.dateTime.day} Jan",
        style: AppTextStyles.blue18Medium,
      ),
    ),
  );

  buildEventTitle() {
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.offWhite,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              event.description,
              style: AppTextStyles.blue14SemiBold,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Icon(
            event.isFavorite
                ? Icons.favorite_outlined
                : Icons.favorite_border_outlined,
            color: AppColors.blue,
          ),
        ],
      ),
    );
  }
}
