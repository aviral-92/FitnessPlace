import 'dart:convert';
import '../Constant/FitnessConstant.dart';
import '../Modal/Role.dart';
import '../Networking/ApiBaseHelper.dart';
import 'package:flutter/material.dart';

class RoleRepository {
  ApiBaseHelper _helper = ApiBaseHelper();
  //static String basePath = 'http://localhost:8080';

  Future<Object> findAllRoles(BuildContext context) async {
    final response =
        await _helper.get('${FitnessConstant.BASE_PATH}/role/', context);
    if (response == null) return null;
    return response;
  }

  Future<Object> changeRole(
      BuildContext context, String username, Role role) async {
    final response = await _helper.put(
        '${FitnessConstant.BASE_PATH}/role/?username=$username',
        json.encode(role.toMap()),
        true,
        context);
    if (response == null) return null;
    return response;
  }

  Future<Object> getRoleFromUsername(
      BuildContext context, String username) async {
    final response = await _helper.get(
        '${FitnessConstant.BASE_PATH}/role/getRoleFromUsername?username=$username',
        context);
    if (response == null) return null;
    return response;
  }
}
