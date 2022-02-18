import 'dart:io';

import 'package:FitnessPlace/Constant/ConstantWidgets.dart';
import 'package:FitnessPlace/Constant/FitnessConstant.dart';
import 'package:FitnessPlace/Constant/SizeConfig.dart';
import 'package:FitnessPlace/Modal/JwtResponse.dart';
import 'package:FitnessPlace/Modal/User.dart';
import 'package:FitnessPlace/Repository/LoginRepository.dart';
import 'package:FitnessPlace/Screens/AdminDashboard/AdminHome.dart';
import 'package:FitnessPlace/Screens/SignupPage.dart';
import 'package:FitnessPlace/Screens/TrainerDashboard/TrainerScreen.dart';
import 'package:FitnessPlace/Screens/UserDashboard/UserHome.dart';
import 'package:FitnessPlace/Service/NetworkingService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isChange = false;
  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        top: false,
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                // height: 400,
                height: MediaQuery.of(context).size.height / 2.0,
                decoration: BoxDecoration(
                  //color: Colors.grey[200],
                  image: DecorationImage(
                      image: AssetImage('assets/img/Diane.JPG'),
                      fit: BoxFit.contain),
                ),
              ),
              Text(
                "Welcome!",
                style: GoogleFonts.kaushanScript(
                  color: Colors.black.withOpacity(1),
                  fontSize: SizeConfig.scaleFactor * 4.5, //30.0,
                  fontWeight: FontWeight.w900,
                ),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                child: Container(
                  width: double.infinity,
                  height: 45,
                  child: Platform.isIOS
                      ? CupertinoTextField(
                          placeholder: 'Username',
                          keyboardType: TextInputType.emailAddress,
                          controller: usernameController,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: SizeConfig.scaleFactor * 2.5,
                          ),
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: FitnessConstant.appBarColor),
                          ),
                        )
                      : TextField(
                          style: TextStyle(
                            fontSize: SizeConfig.scaleFactor * 2.5, //20,
                          ),
                          decoration: InputDecoration(
                              fillColor: Colors.black,
                              border: new OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: new BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              hintText: 'Username',
                              labelText: 'Username'),
                          controller: usernameController,
                          keyboardType: TextInputType.emailAddress,
                        ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                child: Container(
                  width: double.infinity,
                  height: 45,
                  child: Platform.isIOS
                      ? CupertinoTextField(
                          placeholder: 'Password',
                          keyboardType: TextInputType.visiblePassword,
                          controller: passwordController,
                          obscureText: true,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: SizeConfig.scaleFactor * 2.5,
                          ),
                          //prefix: Icon(Icons.photo_size_select_small),
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: FitnessConstant.appBarColor),
                          ),
                        )
                      : TextField(
                          style: TextStyle(
                            fontSize: SizeConfig.scaleFactor * 2.5, //20,
                          ),
                          decoration: InputDecoration(
                              fillColor: Colors.black,
                              border: new OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: new BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              hintText: 'Password',
                              labelText: 'Password'),
                          obscureText: true,
                          controller: passwordController,
                        ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25, left: 24, right: 20),
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    /*Text(
                      'Forgot password',
                      style: GoogleFonts.kameron(
                        color: Colors.black.withOpacity(0.8),
                        fontSize: SizeConfig.scaleFactor * 2.5, //20.0,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline,
                      ),
                    ),*/
                    /* ----FLATBUTTON------*/
                    Container(
                      width: MediaQuery.of(context).size.width - 45,
                      child: FlatButton(
                        color: Colors.deepPurple[700],
                        onPressed: () {
                          NetworkingService ns = new NetworkingService();
                          ns.isConnected().then((value) {
                            if (!value) {
                              return ConstantWidgets.showMaterialDialog(
                                  context,
                                  'Please check Network Connection',
                                  'Network Error');
                            }
                          });
                          User user = new User();
                          if (usernameController.text.isEmpty ||
                              passwordController.text.isEmpty) {
                            return ConstantWidgets.showMaterialDialog(
                                context,
                                'Username/Password is empty',
                                'Field\'s Empty ');
                          }
                          user.username = usernameController.text;
                          user.password = passwordController.text;
                          LoginRepository login = new LoginRepository();
                          Future<JwtResponse> jwtResponseFuture =
                              login.signin(user, context);
                          jwtResponseFuture.then((value) {
                            if (value != null && value.roles.length > 0) {
                              String role = value.roles[0];
                              print(role);
                              if (role == 'ROLE_USER') {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (_) {
                                  return UserHome();
                                }));
                              } else if (role == 'ROLE_TRAINER') {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (_) {
                                  return TrainerScreen();
                                }));
                              } else if (role == 'ROLE_ADMIN') {
                                //ADMIN AdminHome
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (_) {
                                  return AdminHome();
                                }));
                              }
                              setState(() {
                                isChange = false;
                              });
                            }
                          });
                          jwtResponseFuture.catchError((onError) {
                            print('????======>>>>>$onError');
                            setState(() {
                              isChange = false;
                            });
                            return ConstantWidgets.showMaterialDialog(
                              context,
                              'Credentials or internet connections error!!',
                              'Try Again!',
                            );
                          }).timeout(Duration(seconds: 6));
                          setState(() {
                            isChange = true;
                          });
                        },
                        child: getTextWidget(isChange),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Divider(
                color: Colors.black,
                indent: 25,
                endIndent: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6, left: 24, right: 20),
                child: Row(
                  children: [
                    Text(
                      "Don't you have an account? ",
                      style: GoogleFonts.kameron(
                        color: Colors.black.withOpacity(1),
                        fontSize: SizeConfig.scaleFactor * 2.3, //18.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignupPage(),
                          ),
                        );
                      },
                      child: Text(
                        "Sign Up",
                        style: GoogleFonts.kameron(
                          color: Colors.blue.withOpacity(1),
                          fontSize: SizeConfig.scaleFactor * 2.3, //18.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getTextWidget(bool change) {
    return !change
        ? Text(
            'LOGIN',
            style: GoogleFonts.kameron(
              color: Colors.white.withOpacity(1),
              fontSize: SizeConfig.scaleFactor * 3, //22.0,
              fontWeight: FontWeight.w600,
            ),
          )
        : CircularProgressIndicator(
            //value: 3.0,
            //valueColor: AlwaysStoppedAnimation(Colors.blue),
            );
  }
}
