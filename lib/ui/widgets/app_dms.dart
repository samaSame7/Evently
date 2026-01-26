import 'package:flutter/material.dart';

class EventDm {
  String title;
  String description;
  DateTime dateTime;
  CategoryDm category;
  bool isFavorite;
  EventDm({
    required this.title,
    required this.description,
    required this.category,
    required this.dateTime,
    required this.isFavorite,
  });
}

class CategoryDm {
  String name;
  String imgPath;
  IconData icon;
  CategoryDm({required this.name, required this.imgPath, required this.icon});
}
