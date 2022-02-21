import 'package:FitnessPlace/Modal/Role.dart';

class RoleList {
  List<Role> roleList;

  RoleList({this.roleList});

  RoleList.fromJson(List<dynamic> parsedJson) {
    roleList = new List<Role>();
    parsedJson.forEach((element) {
      roleList.add(Role.fromMap(element));
    });
  }
}
