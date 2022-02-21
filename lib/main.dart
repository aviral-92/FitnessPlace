import 'package:FitnessPlace/Screens/LandingPage.dart';
import 'package:flutter/material.dart';
//import 'package:shared_preferences/shared_preferences.dart';

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
}
