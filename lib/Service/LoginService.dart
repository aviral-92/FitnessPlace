import 'package:FitnessPlace/Constant/ConstantWidgets.dart';
import 'package:FitnessPlace/Modal/JwtResponse.dart';
import 'package:FitnessPlace/Modal/User.dart';
import 'package:FitnessPlace/Repository/LoginRepository.dart';
import 'package:FitnessPlace/Screens/AdminDashboard/AdminHome.dart';
import 'package:FitnessPlace/Screens/TrainerDashboard/TrainerScreen.dart';
import 'package:FitnessPlace/Screens/UserDashboard/UserHome.dart';
import 'package:flutter/material.dart';

import 'NetworkingService.dart';

class LoginService {
  final BuildContext context;
  final TextEditingController usernameController;
  final TextEditingController passwordController;

  LoginService(
      {this.context, this.usernameController, this.passwordController});

  bool login() {
    NetworkingService ns = new NetworkingService();
    ns.isConnected().then((value) {
      if (!value) {
        return ConstantWidgets.showMaterialDialog(
            context, 'Please check Network Connection', 'Network Error');
      }
    });
    User user = new User();
    if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
      ConstantWidgets.showMaterialDialog(
          context, 'Username/Password is empty', 'Field\'s Empty ');
    } else {
      user.username = usernameController.text;
      user.password = passwordController.text;
      LoginRepository login = new LoginRepository();
      Future<JwtResponse> jwtResponseFuture = login.signin(user, context);

      jwtResponseFuture.then((value) {
        if (value != null && value.roles.length > 0) {
          String role = value.roles[0];
          print(role);
          Object obj = getPageFromRole(role);
          Navigator.push(context, MaterialPageRoute(builder: (context) => obj));
          return false;
        }
      });
      jwtResponseFuture.catchError((onError) {
        print('????======>>>>>$onError');
        ConstantWidgets.showMaterialDialog(
          context,
          'Credentials or internet connections error!!',
          'Try Again!',
        );
        return false;
      }).timeout(Duration(seconds: 6));
      return true;
    }
    return false;
  }

  Object getPageFromRole(String role) {
    switch (role) {
      case 'ROLE_USER':
        return UserHome();
      case 'ROLE_TRAINER':
        return TrainerScreen();
      case 'ROLE_ADMIN':
        return AdminHome();
    }
    return null;
  }
}
