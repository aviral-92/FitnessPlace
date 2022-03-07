import 'dart:io';
import 'package:FitnessPlace/Constant/FitnessConstant.dart';
import 'package:FitnessPlace/Constant/SizeConfig.dart';
import 'package:FitnessPlace/Screens/SignupPage.dart';
import 'package:FitnessPlace/Service/LoginService.dart';
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
    isChange = false;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: pageBody(),
    );
  }

  Widget pageBody() {
    return SafeArea(
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
                        LoginService loginService = new LoginService(
                          context: context,
                          usernameController: usernameController,
                          passwordController: passwordController,
                        );
                        bool stateBool = loginService.login();
                        print('stateBool=$stateBool');
                        setState(() {
                          isChange = stateBool;
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
    );
  }

  /*Widget setFutureWidget() {
    return FutureBuilder(
        future: futureCall(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.connectionState == ConnectionState.done) {
            return Navigator.push(
                context, MaterialPageRoute(builder: (context) => null));
          } else
            return Container();
        });
  }*/

  /*Future<JwtResponse> futureCall() async {
    User user = new User(
        username: usernameController.text, password: passwordController.text);
    LoginRepository login = new LoginRepository();
    return await login.signin(user, context);
  }*/

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
