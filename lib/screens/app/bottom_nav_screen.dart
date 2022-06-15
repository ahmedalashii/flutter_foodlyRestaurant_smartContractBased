import "package:flutter/material.dart";

import 'homepage.dart';
import 'orders_screen.dart';

import 'search_screen.dart';
import "../../constants/colors.dart" as colors;

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {

  final List _screens = [
    const HomePageScreen(),
    const SearchScreen(),
    const OrdersScreen(),
    const Scaffold(backgroundColor: Colors.blue),
  ];

  int _currentIndex = 0;

  final Map<String, IconData> _bottomIcons = {
    "Home": Icons.fastfood_rounded,
    "Search": Icons.search_sharp,
    "Orders": Icons.event_note,
    "Profile": Icons.person_rounded
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.backgroundColor,
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: colors.buttonColorGreen,
        unselectedItemColor: Colors.grey.shade500,
        iconSize: 30,
        selectedLabelStyle:
            const TextStyle(fontFamily: "Raleway", fontSize: 13),
        unselectedLabelStyle:
            const TextStyle(fontFamily: "Raleway", fontSize: 13),
        items: _bottomIcons
            .map(
              (key, value) => MapEntry(
                key,
                BottomNavigationBarItem(
                  label: key,
                  icon: Container(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Icon(value),
                  ),
                ),
              ),
            )
            .values
            .toList(),
      ),
    );
  }
}
