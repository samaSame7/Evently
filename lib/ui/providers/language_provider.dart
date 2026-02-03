import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier{
  String currentLocale = "en";

  void updateLocale(String newLocale){
    currentLocale = newLocale;
    notifyListeners();
  }
}
