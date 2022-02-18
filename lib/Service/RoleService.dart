import 'package:FitnessPlace/Modal/Role.dart';
import 'package:FitnessPlace/Repository/RoleRepository.dart';
import 'package:flutter/material.dart';

class RoleService {
  RoleRepository _roleRepository = new RoleRepository();

  Future<List<Role>> findAll(BuildContext context) async {
    final response = await _roleRepository.findAllRoles(context);
    print('RESPONSE====>>>>>\n$response');
    if (response == null) return null;
    RolesList rolesList = RolesList.fromJson(response);
    return rolesList.roleList;
  }

  Future<String> changeRole(
      BuildContext context, String username, Role role) async {
    final response = await _roleRepository.changeRole(context, username, role);
    print('RESPONSE====>>>>>\n$response');
    if (response == null) return null;
    return response;
  }
}

class RolesList {
  List<Role> roleList;

  RolesList({this.roleList});

  RolesList.fromJson(List<dynamic> parsedJson) {
    roleList = new List<Role>();
    parsedJson.forEach((element) {
      roleList.add(Role.fromMap(element));
    });
  }
}
