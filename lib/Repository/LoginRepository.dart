import 'dart:convert';
import 'package:FitnessPlace/Constant/FitnessConstant.dart';
import 'package:FitnessPlace/Modal/JwtResponse.dart';
import 'package:FitnessPlace/Modal/User.dart';
import 'package:FitnessPlace/Networking/ApiBaseHelper.dart';
import 'package:flutter/material.dart';

class LoginRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<JwtResponse> signin(User user, BuildContext context) async {
    print(user.toMapLogin());
    final response = await _helper.post(
        '${FitnessConstant.BASE_PATH}/api/auth/signin',
        json.encode(user.toMapLogin()),
        false,
        context);
    if (response == null) {
      return null;
    }
    JwtResponse jwt = JwtResponse.fromMap(response);
    _helper.seStorage('username', jwt.username);
    _helper.seStorage('token', jwt.token);
    return jwt;
  }

  Future<String> signUp(User user, BuildContext context) async {
    print(user.toMap());
    final response = await _helper.post(
        '${FitnessConstant.BASE_PATH}/api/auth/signup',
        json.encode(user.toMap()),
        false,
        context);
    if (response == null) return null;
    return response.toString();
  }
}
