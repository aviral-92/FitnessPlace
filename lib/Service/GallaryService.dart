/*import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:FitnessPlace/Networking/ApiBaseHelper.dart';
import 'package:flutter/material.dart';

class GallaryService {
  ApiBaseHelper _helper = new ApiBaseHelper();

  void getAllPics(BuildContext context) {
    final response = get("http://localhost:8080/pics/", context);
    if (response == null) return null;
    response.then((file) {
      //print(value);
      //File file = new File(value);
      print(file);
    
      //ZipDecoder().decodeBytes(file.readAsBytes());
      //ArchiveFile archiveFile = new ArchiveFile(name, file.length(), file);
    });
  }

  Future<File> get(String url, BuildContext context) async {
    print('Api GET, url $url');
    //var responseJson;
    Map<String, String> headers = new Map();
    String token = await _helper.getTokenOrUsername('token');
    print('token-----> $token');
    headers.putIfAbsent(HttpHeaders.authorizationHeader, () => 'Bearer $token');
    final response = await http.get(url, headers: headers);
    //final outputFilePath = 'zipFile.zip';
    print('api get recieved!');
    print(response.body);
    //Uint8List bodyBytes = response.bodyBytes;
    File file = File.fromRawPath(response.bodyBytes);
    //print(bodyBytes);
    //final file = await File(outputFilePath).writeAsBytes(bodyBytes);
    return file;
  }
}
*/
