import 'package:evently_6/firebase_utils/firestore_utility.dart';
import 'package:evently_6/ui/data_models/event_dm.dart';
import 'package:evently_6/ui/data_models/user_dm.dart';
import 'package:evently_6/ui/widgets/event_widget.dart';
import 'package:flutter/material.dart';

class FavoriteTab extends StatelessWidget {
  const FavoriteTab({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getFavoriteEventsForUSer(UserDm.currentUser!),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        } else if (snapshot.hasData) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(children: [buildEventsList(snapshot.data!)]),
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget buildEventsList(List<EventDm> events) {
    return Expanded(
      child: ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) => EventWidget(event: events[index]),
      ),
    );
  }
}
