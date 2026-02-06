import 'package:evently_6/ui/data_models/event_dm.dart';
import 'package:evently_6/ui/screens/add_event_screen/add_event_screen.dart';
import 'package:evently_6/ui/screens/details_screen/details_screen.dart';
import 'package:evently_6/ui/screens/edit_event_screen/edit_event_screen.dart';
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

  static MaterialPageRoute get addEventScreen =>
      MaterialPageRoute(builder: (_) => AddEventScreen());

  static MaterialPageRoute getDetailsEventScreen(EventDm event) =>
      MaterialPageRoute(builder: (_) => DetailsScreen(event: event));

  static MaterialPageRoute getEditEventScreen(EventDm event) =>
      MaterialPageRoute(builder: (_) => EditEventScreen(event: event));
}
