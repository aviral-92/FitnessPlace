//import 'package:FitnessPlace/Service/GallaryService.dart';
import 'dart:io';

import 'package:FitnessPlace/Constant/FitnessConstant.dart';
import 'package:FitnessPlace/CustomWidget/CustomNavigationBar.dart';
import 'package:FitnessPlace/Networking/ApiBaseHelper.dart';
import 'package:FitnessPlace/Repository/ClassScheduleRepository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Gallary extends StatefulWidget {
  @override
  _GallaryState createState() => _GallaryState();
}

class _GallaryState extends State<Gallary> {
  @override
  Widget build(BuildContext context) {
    CustomNavigationBar _customNavigationBar = new CustomNavigationBar(
      bgColor: FitnessConstant.appBarColor,
      isBackButtonReq: false,
      isIconRequired: true,
      txt: 'GALLARY',
      txtColor: Colors.white,
      w: GestureDetector(
        child: Icon(Icons.add_to_home_screen),
        onTap: () {
          if (Platform.isAndroid) {
            ClassScheduleRepository classScheduleRepository =
                new ClassScheduleRepository();
            classScheduleRepository.logout(context);
          } else {
            ApiBaseHelper _api = new ApiBaseHelper();
            _api.flush();
            Navigator.of(context, rootNavigator: true).pop();
          }
        },
      ),
    );
    return Platform.isAndroid
        ? pageBody()
        : CupertinoPageScaffold(
            navigationBar: _customNavigationBar.getCupertinoNavigationBar(),
            child: pageBody(),
          );
  }

  Widget pageBody() {
    List<String> list = List();
    list.add('assets/img/IMG_7817.JPG');
    list.add('assets/img/7EBC215E-30C2-49BE-B5E4-F46826F959DE.jpeg');
    list.add('assets/img/8E053972-17A0-4DE1-99A9-968C32BDF6C1.jpeg');
    list.add('assets/img/12599F3D-41E0-4F10-BA8A-0C04E51378F0.jpeg');
    list.add('assets/img/IMG_8565.JPG');
    list.add('assets/img/100353E2-DC6E-423A-99A2-F49AFA80BA81.jpeg');
    list.add('assets/img/B1F6542E-07E0-4BA1-BA39-CF009393A2A9.jpeg');
    list.add('assets/img/D7B9A39D-5E12-4D86-840F-ACFF54AE36CB.jpeg');
    list.add('assets/img/EB84B7AE-F621-4AC3-86CC-3B3078C28BFB.jpeg');
    list.add('assets/img/IMG_8441.JPG');
    return Container(
      child: ListView(
        physics: ScrollPhysics(),
        children: [
          getContainer(list),
        ],
      ),
    );
  }

  Widget getContainer(List<String> paths) {
    final height = MediaQuery.of(context).size.height;
    return Container(
      height: height - height / 4.4,
      width: MediaQuery.of(context).size.width / 2,
      child: GridView.builder(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemCount: 10,
          physics: ScrollPhysics(),
          itemBuilder: (context, index) {
            return Card(
              elevation: 6,
              child: Container(
                height: 350,
                width: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(paths[index]),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          }),
    );
  }
}
