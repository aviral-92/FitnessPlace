import 'dart:io';

import 'package:FitnessPlace/Constant/FitnessConstant.dart';
import 'package:FitnessPlace/Repository/ClassScheduleRepository.dart';
import 'package:FitnessPlace/Screens/TrainerDashboard/AddTrainerSchedule.dart';
import 'package:FitnessPlace/Screens/TrainerDashboard/TrainersHome.dart';
import 'package:FitnessPlace/Screens/TrainerDashboard/TrainersProfile.dart';
import 'package:FitnessPlace/Screens/TrainerDashboard/UpdateScheduleScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TrainerScreen extends StatefulWidget {
  @override
  _TrainerScreenState createState() => _TrainerScreenState();
}

class _TrainerScreenState extends State<TrainerScreen> {
  int _currentIndex = 0;
  String appBarTxt = 'Dashboard';
  final List _children = [
    TrainersHome(),
    AddTrainerSchedule(),
    UpdateScheduleScreen(),
    TrainersProfile(),
  ];

  final GlobalKey<NavigatorState> firstTabNavKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> secondTabNavKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> thirdTabNavKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> fourthTabNavKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoTabScaffold(
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
                  icon: Icon(CupertinoIcons.bus),
                  title: Text('Add'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.update),
                  title: Text('Update'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle),
                  title: Text('Profile'),
                ),
              ],
            ),
            tabBuilder: (BuildContext context, index) {
              switch (index) {
                case 0:
                  return CupertinoTabView(
                    navigatorKey: firstTabNavKey,
                    builder: (context) => TrainersHome(),
                  );
                case 1:
                  return CupertinoTabView(
                    navigatorKey: secondTabNavKey,
                    builder: (context) => AddTrainerSchedule(),
                  );
                case 2:
                  return CupertinoTabView(
                    navigatorKey: thirdTabNavKey,
                    builder: (context) => UpdateScheduleScreen(),
                  );
                case 3:
                  return CupertinoTabView(
                    navigatorKey: fourthTabNavKey,
                    builder: (context) => TrainersProfile(),
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
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width / 2 - 80),
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
                  title: Text('Add'),
                  icon: Icon(Icons.add_box),
                ),
                BottomNavigationBarItem(
                  title: Text('Update'),
                  icon: Icon(Icons.update),
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
        appBarTxt = 'ADD';
      } else if (index == 2) {
        appBarTxt = 'Update';
      } else {
        appBarTxt = "PROFILE";
      }
    });
  }
}
