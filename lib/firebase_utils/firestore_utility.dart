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
