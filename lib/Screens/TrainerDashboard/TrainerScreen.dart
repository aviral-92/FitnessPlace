import 'package:FitnessPlace/Constant/FitnessConstant.dart';
import 'package:FitnessPlace/Repository/ClassScheduleRepository.dart';
import 'package:FitnessPlace/Screens/TrainerDashboard/AddTrainerSchedule.dart';
import 'package:FitnessPlace/Screens/TrainerDashboard/TrainersHome.dart';
import 'package:FitnessPlace/Screens/TrainerDashboard/TrainersProfile.dart';
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
    TrainersProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width / 2 - 50),
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
      } else {
        appBarTxt = "PROFILE";
      }
    });
  }
}
