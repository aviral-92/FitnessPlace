import 'dart:io';

import 'package:FitnessPlace/Constant/FitnessConstant.dart';
import 'package:FitnessPlace/Constant/SizeConfig.dart';
import 'package:FitnessPlace/Repository/ClassScheduleRepository.dart';
import 'package:FitnessPlace/Screens/UserDashboard/ClassScheduleScreen.dart';
import 'package:FitnessPlace/Screens/UserDashboard/Gallary.dart';
import 'package:FitnessPlace/Screens/UserDashboard/UserProfile.dart';
import 'package:flutter/cupertino.dart';
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

  final GlobalKey<NavigatorState> firstTabNavKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> secondTabNavKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> thirdTabNavKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height / 100;
    return Platform.isIOS
        ? CupertinoTabScaffold(
            resizeToAvoidBottomInset: false,
            tabBar: CupertinoTabBar(
              items: [
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.home),
                  title: Text('Home'),
                  activeIcon: Icon(
                    CupertinoIcons.home,
                    color: Colors.grey[900],
                  ),
                ),
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.person_solid),
                  title: Text('Profile'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.game_controller_solid),
                  title: Text('Gallary'),
                ),
              ],
            ),
            tabBuilder: (BuildContext context, index) {
              switch (index) {
                case 0:
                  return CupertinoTabView(
                    navigatorKey: firstTabNavKey,
                    builder: (context) => ClassScheduleScreen(),
                  );
                case 1:
                  return CupertinoTabView(
                    navigatorKey: secondTabNavKey,
                    builder: (context) => UserProfile(),
                  );
                case 2:
                  return CupertinoTabView(
                    navigatorKey: thirdTabNavKey,
                    builder: (context) => Gallary(),
                  );
                default:
                  return SizedBox();
              }
            })
        : Scaffold(
            resizeToAvoidBottomInset: false,
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
