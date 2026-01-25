import 'package:evently_6/ui/screens/login_screen/login_screen.dart';
import 'package:evently_6/ui/screens/navigation_screen/navigation_screen.dart';
import 'package:evently_6/ui/screens/signup_screen/signup_screen.dart';
import 'package:flutter/material.dart';

abstract final class AppRoutes {
  static MaterialPageRoute get signupScreen =>
      MaterialPageRoute(builder: (_) => SignupScreen());

  static MaterialPageRoute get loginScreen =>
      MaterialPageRoute(builder: (_) => LoginScreen());

  static MaterialPageRoute get navigationScreen =>
      MaterialPageRoute(builder: (_) => NavigationScreen());
}
