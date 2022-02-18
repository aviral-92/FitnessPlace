import 'dart:convert';

import 'package:FitnessPlace/Constant/FitnessConstant.dart';
import 'package:FitnessPlace/Modal/Profile.dart';
import 'package:FitnessPlace/Modal/User.dart';
import 'package:FitnessPlace/Networking/ApiBaseHelper.dart';
import 'package:flutter/material.dart';

class ProfileRepository {
  ApiBaseHelper _helper = ApiBaseHelper();
  //static String basePath = 'http://localhost:8080';

  Future<Profile> getProfileByUsername(
      String username, BuildContext context) async {
    String uName = username == null
        ? await _helper.getTokenOrUsername('username')
        : username;
    final response = await _helper.get(
        '${FitnessConstant.BASE_PATH}/profile/getProfileByUsername?username=$uName',
        context);
    if (response == null) return null;
    Profile profile = Profile.fromMap(response);
    print(profile);
    return profile;
  }

  Future<Profile> updateProfile(User user, BuildContext context) async {
    String username = await _helper.getTokenOrUsername('username');
    user.username = username;
    final response = await _helper.put('${FitnessConstant.BASE_PATH}/profile/',
        json.encode(user.toMap()), true, context);
    if (response == null) return null;
    Profile profile = Profile.fromMap(response);
    print(profile);
    return profile;
  }
}
