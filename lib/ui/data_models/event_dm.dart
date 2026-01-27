import 'category_dm.dart';

class EventDm {
  String title;
  String description;
  DateTime dateTime;
  CategoryDm category;
  EventDm({
    required this.title,
    required this.description,
    required this.category,
    required this.dateTime,
  });
}