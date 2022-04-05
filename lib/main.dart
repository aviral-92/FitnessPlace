import 'dart:io';

import 'package:FitnessPlace/Screens/LandingPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //checkLoggedin();
    return Platform.isIOS
        ? CupertinoApp(
            debugShowCheckedModeBanner: false,
            theme: CupertinoThemeData(
              brightness: Brightness.light,
            ),
            home: CupertinoPageScaffold(
              resizeToAvoidBottomInset: false,
              child: LandingPage(),
            ),
            localizationsDelegates: [
              DefaultMaterialLocalizations.delegate,
              DefaultCupertinoLocalizations.delegate,
              DefaultWidgetsLocalizations.delegate,
            ],
          )
        : MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              brightness: Brightness.light,
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
            ),
            home: Scaffold(
              resizeToAvoidBottomInset: false,
              body: LandingPage(),
            ),
          );
  }
}
