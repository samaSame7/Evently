import 'package:flutter/material.dart';

class CategoryDm {
  String name;
  String imgPath;
  IconData icon;
  CategoryDm({required this.name, required this.imgPath, required this.icon});

  static CategoryDm fromJson(Map<String,dynamic> json){
    int codePoint = json['icon'];
    CategoryDm category = CategoryDm(
      name: json['name'],
      imgPath: json['imgPath'],
      icon: IconData(codePoint),
    );
    return category;
  }

  Map<String,dynamic> toJson(){
    return {
      'name': name,
      'imgPath': imgPath,
      'icon': icon.codePoint,
    };
  }
}
