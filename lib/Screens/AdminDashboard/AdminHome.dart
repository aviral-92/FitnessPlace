import 'package:FitnessPlace/Constant/FitnessConstant.dart';
import 'package:FitnessPlace/Repository/ClassScheduleRepository.dart';
import 'package:FitnessPlace/Screens/AdminDashboard/AdminHomeScreen.dart';
import 'package:FitnessPlace/Screens/AdminDashboard/ChangeRole.dart';
import 'package:FitnessPlace/Screens/TrainerDashboard/TrainersProfile.dart';
import 'package:flutter/material.dart';

import 'Schedule/ScheduleHome.dart';

class AdminHome extends StatefulWidget {
  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  int _currentIndex = 0;
  String appBarTxt = 'Dashboard';
  final List _children = [
    AdminHomeScreen(),
    ScheduleHome(),
    ChangeRole(),
    TrainersProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width / 2 - 75),
              child: Text(appBarTxt),
            ),
            IconButton(
                icon: Icon(Icons.add_to_home_screen),
                onPressed: () {
                  //Navigator.pop(context);
                  ClassScheduleRepository classScheduleRepository =
                      new ClassScheduleRepository();
                  classScheduleRepository.logout(context);
                }),
          ],
        ),
        backgroundColor: FitnessConstant.appBarColor,
        automaticallyImplyLeading: false,
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: FitnessConstant.appBarColor,
        elevation: 6,
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            title: Text('Home'),
            icon: Icon(Icons.home),
            activeIcon: Icon(Icons.dashboard),
          ),
          BottomNavigationBarItem(
            title: Text('Schedule'),
            icon: Icon(Icons.schedule),
          ),
          BottomNavigationBarItem(
            title: Text('Role'),
            icon: Icon(Icons.radio_button_checked),
          ),
          BottomNavigationBarItem(
            title: Text('Profile'),
            icon: Icon(Icons.person),
          ),
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    print(index);
    setState(() {
      _currentIndex = index;
      if (index == 0) {
        appBarTxt = 'HOME';
      } else if (index == 1) {
        appBarTxt = 'SCHEDULE';
      } else if (index == 2) {
        appBarTxt = 'CHANGE ROLE';
      } else {
        appBarTxt = "PROFILE";
      }
    });
  }
}
