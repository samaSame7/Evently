import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_6/firebase_utils/firestore_utility.dart';
import 'package:evently_6/ui/data_models/user_dm.dart';
import 'package:evently_6/ui/utils/app_colors.dart';
import 'package:evently_6/ui/utils/app_styles.dart';
import 'package:evently_6/ui/data_models/event_dm.dart';
import 'package:flutter/material.dart';

class EventWidget extends StatefulWidget {
  const EventWidget({super.key, required this.event});
  final EventDm event;

  @override
  State<EventWidget> createState() => _EventWidgetState();
}

class _EventWidgetState extends State<EventWidget> {
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
            child: Image.asset(widget.event.category.imgPath),
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

  Widget buildEventDate() => Align(
    alignment: Alignment.topLeft,
    child: Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.offWhite,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        "${widget.event.dateTime.day} Jan",
        //"${widget.event.dateTime.day} : ${widget.event.dateTime.month}",
        style: AppTextStyles.blue18Medium,
      ),
    ),
  );

  Widget buildEventTitle() {
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
              widget.event.description,
              style: AppTextStyles.blue14SemiBold,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection(UserDm.collectionName)
                .doc(UserDm.currentUser!.id)
                .snapshots(),
            builder: (context, snapshot) => InkWell(
              onTap: () {
                if (UserDm.currentUser!.favouriteEvents.contains(
                  widget.event.id,
                )) {
                  removeEventFromFavorite(widget.event.id, UserDm.currentUser!);
                } else {
                  addEventToFavorite(widget.event.id, UserDm.currentUser!);
                }
                setState(() {});
              },
              child: Icon(
                UserDm.currentUser!.favouriteEvents.contains(widget.event.id)
                    ? Icons.favorite_outlined
                    : Icons.favorite_border_outlined,
                color: AppColors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
