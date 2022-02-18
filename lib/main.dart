import 'package:FitnessPlace/Screens/LandingPage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //checkLoggedin();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: LandingPage(),
      ),
    );
  }

  void checkLoggedin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool value = prefs.getBool('isLoggedIn');
    print('AFTER---->$value');
  }
}
