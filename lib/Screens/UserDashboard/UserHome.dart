import 'package:FitnessPlace/Constant/FitnessConstant.dart';
import 'package:FitnessPlace/Constant/SizeConfig.dart';
import 'package:FitnessPlace/Repository/ClassScheduleRepository.dart';
import 'package:FitnessPlace/Screens/UserDashboard/ClassScheduleScreen.dart';
import 'package:FitnessPlace/Screens/UserDashboard/Gallary.dart';
import 'package:FitnessPlace/Screens/UserDashboard/UserProfile.dart';
import 'package:flutter/material.dart';

class UserHome extends StatefulWidget {
  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  int _currentIndex = 0;
  String appBarTxt = 'Dashboard';
  final List _children = [
    ClassScheduleScreen(),
    UserProfile(),
    Gallary(),
  ];

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height / 100;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              //MediaQuery.of(context).size.width / 2 - 50
              padding: EdgeInsets.only(
                  left: SizeConfig.blockSizeHorizontal * 45 - 50),
              child: Text(
                appBarTxt,
                style: TextStyle(fontSize: height * 2.5),
              ),
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
        selectedItemColor: FitnessConstant.appBarColor,
        elevation: 6,
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            title: Text(
              'Home',
              style: TextStyle(fontSize: height * 2.1),
            ),
            icon: Icon(
              Icons.home,
              size: height * 3.3,
            ),
            activeIcon: Icon(
              Icons.dashboard,
              size: height * 3.3,
            ),
          ),
          BottomNavigationBarItem(
            title: Text(
              'Profile',
              style: TextStyle(fontSize: height * 2.1),
            ),
            icon: Icon(
              Icons.person,
              size: height * 3.3,
            ),
          ),
          BottomNavigationBarItem(
            title: Text(
              'Gallary',
              style: TextStyle(fontSize: height * 2.1),
            ),
            icon: Icon(
              Icons.games,
              size: height * 3.3,
            ),
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
        appBarTxt = "PROFILE";
      } else {
        appBarTxt = "GALLARY";
      }
    });
  }
}
