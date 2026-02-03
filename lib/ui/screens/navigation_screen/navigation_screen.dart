import 'package:evently_6/ui/screens/navigation_screen/tabs/favorite_tab/favorite_tab.dart';
import 'package:evently_6/ui/screens/navigation_screen/tabs/home_tab/home_tab.dart';
import 'package:evently_6/ui/screens/navigation_screen/tabs/profile_tab/profile_tab.dart';
import 'package:evently_6/ui/utils/app_colors.dart';
import 'package:evently_6/ui/utils/app_routes.dart';
import 'package:flutter/material.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int selectedTap = 0;
  List tabs = [HomeTab(), FavoriteTab(), ProfileTab()];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: tabs[selectedTap],
        floatingActionButton: buildFloatingActionButton(),
        bottomNavigationBar: buildBottomNavigationBar(),
      ),
    );
  }

  FloatingActionButton buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(context, AppRoutes.addEventScreen);
      },
      shape: CircleBorder(),
      backgroundColor: AppColors.blue,
      child: Icon(Icons.add, color: AppColors.white),
    );
  }

  Widget buildBottomNavigationBar() => Theme(
    data: ThemeData(canvasColor: AppColors.white),
    child: BottomNavigationBar(
      selectedItemColor: AppColors.blue,
      unselectedItemColor: AppColors.grey2,
      currentIndex: selectedTap,
      onTap: (index) {
        setState(() {
          selectedTap = index;
        });
      },
      items: [
        buildBottomNavigationBarItem(
          selectedTap == 0 ? Icons.home_filled : Icons.home_outlined,
          "Home",
        ),
        buildBottomNavigationBarItem(
          selectedTap == 1 ? Icons.favorite : Icons.favorite_border_outlined,
          "Favorite",
        ),
        buildBottomNavigationBarItem(
          selectedTap == 2 ? Icons.person_2 : Icons.person_2_outlined,
          "Profile",
        ),
      ],
    ),
  );

  BottomNavigationBarItem buildBottomNavigationBarItem(
    IconData icon,
    String label,
  ) => BottomNavigationBarItem(icon: Icon(icon), label: label);
}
