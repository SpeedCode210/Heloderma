import 'package:flutter/material.dart';
import 'package:heloderma/colors.dart' as HelodermaColors;
import 'package:heloderma/screens/homepage.dart';
import 'package:heloderma/screens/folderspage.dart';
import 'package:heloderma/screens/profile.dart';
import 'package:heloderma/screens/treatments.dart';

import '../icons.dart';

import 'calandar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _mainScreenState();
}

class _mainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    const HomePage(),
    const FoldersPage(),
    const TreatmentsPage(),
    const CalendarPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              child: _widgetOptions.elementAt(_selectedIndex),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey[300]!, width: 2),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: svgIcon('assets/navigation/nav-home.svg'),
            activeIcon: svgIcon('assets/navigation/nav-home-active.svg'),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: svgIcon('assets/navigation/nav-folders.svg'),
            activeIcon: svgIcon('assets/navigation/nav-folders-active.svg'),
            label: 'Folders',
          ),
          BottomNavigationBarItem(
            icon: svgIcon('assets/navigation/nav-treatments.svg'),
            activeIcon: svgIcon('assets/navigation/nav-treatments-active.svg'),
            label: 'Treatments',
          ),
          BottomNavigationBarItem(
            icon: svgIcon('assets/navigation/nav-calendar.svg'),
            activeIcon: svgIcon('assets/navigation/nav-calendar-active.svg'),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: svgIcon('assets/navigation/nav-profile.svg'),
            activeIcon: svgIcon('assets/navigation/nav-profile-active.svg'),
            label: 'Profile',
          ),
        ],
        backgroundColor: Colors.white,
        currentIndex: _selectedIndex,
        selectedItemColor: HelodermaColors.darkPink,
        unselectedItemColor: HelodermaColors.darkBlue,
        showUnselectedLabels: true,
        onTap: (index) => setState(() {
          _selectedIndex = index;
        }),
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
