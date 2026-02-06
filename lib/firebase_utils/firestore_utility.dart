import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_6/ui/data_models/event_dm.dart';
import 'package:evently_6/ui/data_models/user_dm.dart';

Future<UserDm> getUserFromFirestore(String uid) async {
  var usersCollection = FirebaseFirestore.instance.collection("Users");
  DocumentSnapshot snapshot = await usersCollection.doc(uid).get();
  Map<String, dynamic> json = snapshot.data() as Map<String, dynamic>;
  return UserDm.fromJson(json);
}

Future<void> createUserInFirestore(UserDm user) async {
  var usersCollection = FirebaseFirestore.instance.collection("Users");
  var emptyDocument = usersCollection.doc(user.id);
  emptyDocument.set(user.toJson());
}

Future<void> createEventInFirestore(EventDm event) async {
  CollectionReference collection = FirebaseFirestore.instance.collection(
    "events",
  );
  var documentRef = collection.doc();
  event.id = documentRef.id;
  await documentRef.set(event.toJson());
}

Stream<List<EventDm>> getEventsFromFirestore() {
  CollectionReference collection = FirebaseFirestore.instance.collection(
    "events",
  );
  Stream<QuerySnapshot> stream = collection.snapshots();
  return stream.map((querySnapshot) {
    return querySnapshot.docs.map((doc) {
      var json = doc.data() as Map<String, dynamic>;
      return EventDm.fromJson(json);
    }).toList();
  });
}

void addEventToFavorite(String eventId, UserDm user) {
  CollectionReference userCollection = FirebaseFirestore.instance.collection(
    UserDm.collectionName,
  );
  DocumentReference documentReference = userCollection.doc(user.id);
  List<String> favouriteEvents = List.of(user.favouriteEvents);
  favouriteEvents.add(eventId);
  user.favouriteEvents = favouriteEvents;
  documentReference.update({"favouriteEvents": favouriteEvents});
}

void removeEventFromFavorite(String eventId, UserDm user) {
  CollectionReference userCollection = FirebaseFirestore.instance.collection(
    UserDm.collectionName,
  );
  DocumentReference documentReference = userCollection.doc(user.id);
  user.favouriteEvents.remove(eventId);
  documentReference.update({"favouriteEvents": user.favouriteEvents});
}

Future<List<EventDm>> getFavoriteEventsForUSer(UserDm user) async {
  if (UserDm.currentUser!.favouriteEvents.isEmpty) return [];
  CollectionReference eventsCollection = FirebaseFirestore.instance.collection(
    "events",
  );
  QuerySnapshot querySnapshot = await eventsCollection
      .where("id", whereIn: UserDm.currentUser!.favouriteEvents)
      .get();
  return querySnapshot.docs.map((doc) {
    var json = doc.data() as Map<String, dynamic>;
    return EventDm.fromJson(json);
  }).toList();
}

Future<void> updateEventInFirestore(EventDm event) async{
  CollectionReference eventCollection = FirebaseFirestore.instance.collection(
    "events",
  );
  DocumentReference documentReference = eventCollection.doc(event.id);
  await documentReference.update(event.toJson());
}

// CollectionReference userCollection = FirebaseFirestore.instance.collection(
//   UserDm.collectionName,
// );
// DocumentReference documentReference = userCollection.doc(user.id);
// documentReference.update({"": "UserDm.currentUser!.name"});
