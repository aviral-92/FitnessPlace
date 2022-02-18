import 'dart:convert';

import 'package:collection/collection.dart';

import 'Profile.dart';
import 'Role.dart';

class User {
  int id;
  String username;
  String password;
  Profile profile;
  Set<Role> roles;
  bool status;

  User({
    this.id,
    this.username,
    this.password,
    this.profile,
    this.roles,
    this.status,
  });

  User userRequest(String username, String password) {
    return User(username: username, password: password);
    //this.username = username;
    //this.password = password;
  }

  Map<String, dynamic> toMapLogin() {
    return {
      'username': username,
      'password': password,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'password': password,
      'profile': profile != null ? profile.toMap() : null,
      'roles': roles?.map((x) => x.toMap())?.toList(),
      'status': status,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      username: map['username'],
      password: map['password'],
      profile: Profile.fromMap(map['profile']),
      roles: Set<Role>.from(map['roles']?.map((x) => Role.fromMap(x))),
      status: map['status'],
    );
  }

  static List<User> fromList(List<dynamic> list) {
    List<User> users = List();
    for (int i = 0; i < list.length; i++) {
      //print('LIST=====> ${list[i]}');
      User user = User.fromMap(list[i]);
      users.add(user);
    }
    return users;
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(id: $id, username: $username, password: $password, profile: $profile, roles: $roles, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final setEquals = const DeepCollectionEquality().equals;

    return other is User &&
        other.id == id &&
        other.username == username &&
        other.password == password &&
        other.profile == profile &&
        setEquals(other.roles, roles) &&
        other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        username.hashCode ^
        password.hashCode ^
        profile.hashCode ^
        roles.hashCode ^
        status.hashCode;
  }
}
