import 'package:FitnessPlace/Constant/ConstantWidgets.dart';
import 'package:FitnessPlace/Modal/Profile.dart';
import 'package:FitnessPlace/Modal/User.dart';
import 'package:FitnessPlace/Repository/LoginRepository.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final double size = 17;
  TextEditingController nameController = new TextEditingController();
  TextEditingController mobileController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController genderController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: CircleAvatar(
                  radius: MediaQuery.of(context).size.height / 9, //80,
                  backgroundImage: NetworkImage(
                      'https://images.unsplash.com/photo-1517963628607-235ccdd5476c?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTB8fGd5bSUyMHNwaW5pbmd8ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=900&q=60'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                child: Container(
                  width: double.infinity,
                  child: TextField(
                    style: TextStyle(
                      fontSize: size,
                    ),
                    decoration: InputDecoration(
                        fillColor: Colors.black,
                        border: new OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: new BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        hintText: ' Name',
                        labelText: ' Name'),
                    controller: nameController,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                child: Container(
                  width: double.infinity,
                  child: TextField(
                    style: TextStyle(
                      fontSize: size,
                    ),
                    decoration: InputDecoration(
                        fillColor: Colors.black,
                        border: new OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: new BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        hintText: 'Mobile',
                        labelText: 'Mobile'),
                    controller: mobileController,
                    keyboardType: TextInputType.phone,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                child: Container(
                  width: double.infinity,
                  child: TextField(
                    style: TextStyle(
                      fontSize: size,
                    ),
                    decoration: InputDecoration(
                        fillColor: Colors.black,
                        border: new OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: new BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        hintText: 'Email',
                        labelText: 'Email'),
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                child: Container(
                  width: double.infinity,
                  child: TextField(
                    style: TextStyle(
                      fontSize: size,
                    ),
                    decoration: InputDecoration(
                        fillColor: Colors.black,
                        border: new OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: new BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        hintText: 'Gender',
                        labelText: 'Gender'),
                    controller: genderController,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                child: Container(
                  width: double.infinity,
                  child: TextField(
                    style: TextStyle(
                      fontSize: size,
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
                padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                child: Container(
                  width: double.infinity,
                  child: TextField(
                    style: TextStyle(
                      fontSize: size,
                    ),
                    decoration: InputDecoration(
                        fillColor: Colors.black,
                        border: new OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: new BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        hintText: 'Confirm Password',
                        labelText: 'Confirm Password'),
                    obscureText: true,
                    controller: confirmPasswordController,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
                child: Container(
                  width: double.infinity,
                  color: Colors.cyan[700],
                  child: FlatButton(
                    onPressed: () {
                      if (nameController.text.isEmpty ||
                          mobileController.text.isEmpty ||
                          emailController.text.isEmpty ||
                          genderController.text.isEmpty ||
                          passwordController.text.isEmpty ||
                          confirmPasswordController.text.isEmpty) {
                        return ConstantWidgets.showMaterialDialog(context,
                            'Please fill all fields', 'Field\'s Empty');
                      }
                      if (passwordController.text ==
                          confirmPasswordController.text) {
                        User user = new User();
                        user.username = emailController.text;
                        user.password = passwordController.text;
                        Profile profile = new Profile();
                        profile.name = nameController.text;
                        profile.mobile = mobileController.text;
                        profile.gender = genderController.text;
                        user.profile = profile;
                        LoginRepository login = new LoginRepository();
                        login.signUp(user, context).then((value) {
                          ConstantWidgets.showMaterialDialog(
                              context,
                              '${emailController.text} successfully registered',
                              'Successfully Registered');
                        }).catchError((onError) {
                          ConstantWidgets.showMaterialDialog(
                              context, '$onError', 'Error!!');
                        });
                      } else {
                        ConstantWidgets.showMaterialDialog(
                            context,
                            'password & confirm password does not match',
                            'Not Match !');
                      }
                    },
                    child: Text(
                      'Signup',
                      style: GoogleFonts.kameron(
                        color: Colors.white.withOpacity(1),
                        fontSize: 22.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              Divider(
                height: 30,
                color: Colors.black,
                indent: 25,
                endIndent: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6, left: 44, right: 20),
                child: Row(
                  children: [
                    Text(
                      "Already have an account? ",
                      style: GoogleFonts.kameron(
                        color: Colors.black.withOpacity(1),
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Text(
                        "Login",
                        style: GoogleFonts.kameron(
                          color: Colors.blue.withOpacity(1),
                          fontSize: 18.0,
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
}
