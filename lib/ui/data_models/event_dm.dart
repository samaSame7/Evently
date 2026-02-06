import 'package:cloud_firestore/cloud_firestore.dart';

import 'category_dm.dart';

class EventDm {
  String id;
  String ownerId;
  String title;
  String description;
  DateTime dateTime;
  CategoryDm category;
  EventDm({
    required this.id,
    required this.ownerId,
    required this.title,
    required this.description,
    required this.category,
    required this.dateTime,
  });

  static EventDm fromJson(Map<String, dynamic> json) {
    Timestamp timestamp = json['dateTime'];
    EventDm event = EventDm(
      id: json['id'],
      ownerId: json['ownerId'],
      title: json['title'],
      description: json['description'],
      category: CategoryDm.fromJson(json['category']),
      dateTime: timestamp.toDate(),
    );
    return event;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ownerId': ownerId,
      'title': title,
      'description': description,
      'category': category.toJson(),
      'dateTime': dateTime,
    };
  }

  EventDm copyWith({
    String? id,
    String? ownerId,
    String? title,
    String? description,
    CategoryDm? category,
    DateTime? dateTime,
  }) {
    return EventDm(
      id: id ?? this.id,
      ownerId: ownerId ?? this.ownerId,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      dateTime: dateTime ?? this.dateTime,
    );
  }
}
