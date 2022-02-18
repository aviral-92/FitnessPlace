import 'dart:convert';
import 'dart:io';
import 'package:FitnessPlace/Constant/ConstantWidgets.dart';
import 'package:FitnessPlace/Constant/FitnessConstant.dart';
import 'package:FitnessPlace/Exception/AppException.dart';
import 'package:FitnessPlace/Screens/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiBaseHelper {
  final storage = FlutterSecureStorage();
  //SharedPreferences sharedPreferences = sharedPreferences.getins

  Future<dynamic> get(String url, BuildContext context) async {
    print('Api GET, url $url');
    var responseJson;
    Map<String, String> headers = new Map();
    String token = await getTokenOrUsername('token');
    print('token-----> $token');
    headers.putIfAbsent(HttpHeaders.authorizationHeader, () => 'Bearer $token');
    try {
      final response = await http.get(url, headers: headers);
      print('RESPONSE===> $response');
      responseJson = _returnResponse(response, context);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api get recieved!');
    return responseJson;
  }

  Future<dynamic> post(String url, String objectJson, bool tokenRequired,
      BuildContext context) async {
    print('Api POST, url $url, object $objectJson');
    Map<String, String> headers = new Map();
    headers.putIfAbsent(
        FitnessConstant.CONTENT_TYPE, () => FitnessConstant.APPLICATION_JSON);
    if (tokenRequired) {
      String token;
      await getTokenOrUsername('token').then((val) => token = val);
      print('token-----> $token');
      headers.putIfAbsent(
          HttpHeaders.authorizationHeader, () => 'Bearer $token');
    }
    final response = await http.post(url, headers: headers, body: objectJson);
    print('ApiBaseHelper--------->$response');
    var responseJson;
    try {
      responseJson = _returnResponse(response, context);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api post recieved!');
    return responseJson;
  }

  Future<dynamic> put(String url, String objectJson, bool tokenRequired,
      BuildContext context) async {
    print('Api PUT, url $url, object $objectJson');
    Map<String, String> headers = new Map();
    headers.putIfAbsent(
        FitnessConstant.CONTENT_TYPE, () => FitnessConstant.APPLICATION_JSON);
    if (tokenRequired) {
      String token;
      await getTokenOrUsername('token').then((val) => token = val);
      print('token-----> $token');
      headers.putIfAbsent(
          HttpHeaders.authorizationHeader, () => 'Bearer $token');
    }
    final response = await http.put(url, headers: headers, body: objectJson);
    print('ApiBaseHelper--------->$response');
    var responseJson;
    try {
      responseJson = _returnResponse(response, context);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api get recieved!');
    return responseJson;
  }

  /* NOT WORKING */
  Future<dynamic> delete(String url, String objectJson, bool tokenRequired,
      BuildContext context) async {
    print('Api DELETE, url $url, object $objectJson');
    Map<String, String> headers = new Map();
    if (tokenRequired) {
      String token;
      await getTokenOrUsername('token').then((val) => token = val);
      print('token-----> $token');
      headers.putIfAbsent(
          HttpHeaders.authorizationHeader, () => 'Bearer $token');
      final request = http.Request('DELETE', Uri.parse(url));
      request.headers.addAll(headers);
      request.body = objectJson;
      final response = await request.send();

      print('ApiBaseHelper--------->$response');

      String responseJson = await response.stream.bytesToString();
      print('api DELETE recieved!');
      return responseJson;
    }
  }

  void logout(BuildContext context) {
    Navigator.pushAndRemoveUntil(
        context,
        PageRouteBuilder(pageBuilder: (BuildContext context,
            Animation animation, Animation secondaryAnimation) {
          flush();
          return LoginPage();
        }, transitionsBuilder: (BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child) {
          return new SlideTransition(
            position: new Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        }),
        (Route route) => false);
  }

  dynamic _returnResponse(http.Response response, BuildContext context) {
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        var responseJson;
        var decodeSucceeded = false;
        try {
          responseJson = json.decode(response.body.toString());
          decodeSucceeded = true;
          print('responseJson ------->>>>>>>>>>>> $responseJson');
        } on FormatException {
          print('The provided string is not valid JSON');
        }
        if (!decodeSucceeded) {
          return response.body.toString();
        }
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        print('00000000---------0000000');
        logout(context);
        ConstantWidgets.showMaterialDialog(context,
            'Unable to authorize, please Signin.', 'Unable to authorize');
        return;
      //throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        ConstantWidgets.showMaterialDialog(
            context,
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}, ${response.body}',
            'Error occured');
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}, ${response.body}');
    }
  }

  Future<String> getTokenOrUsername(String key) {
    print('======$key');
    return storage.read(key: key);
  }

  void seStorage(String key, String token) {
    print('======$key');
    print('======$token');
    storage.write(key: key, value: token);
    addSharedPrefrence(key, token);
  }

  Future<void> addSharedPrefrence(String key, String value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(key, value);
  }

  void isLoggedIn(bool value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool('isLoggedIn', value);
  }

  void flush() {
    print('Logging Out...');
    storage.deleteAll();
  }
}
