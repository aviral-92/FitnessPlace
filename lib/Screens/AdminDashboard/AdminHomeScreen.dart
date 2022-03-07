import 'dart:io';

import 'package:FitnessPlace/Constant/FitnessConstant.dart';
import 'package:FitnessPlace/Modal/ClassSchedule.dart';
import 'package:FitnessPlace/Service/ClassScheduleService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdminHomeScreen extends StatefulWidget {
  @override
  _AdminHomeScreenState createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  //List<ClassSchedule> classScheduleList = new List();
  ClassScheduleService classScheduleService = new ClassScheduleService();
  @override
  void initState() {
    //addData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              backgroundColor: FitnessConstant.appBarColor,
              middle: Text(
                'HOME',
                style: TextStyle(color: Colors.white),
              ),
            ),
            child: pageBody())
        : pageBody();
  }

  Widget getColumn(List<ClassSchedule> classScheduleList) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(border: Border.all()),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              getContainer('DATE', FontWeight.w700),
              getContainer('TIME', FontWeight.w700),
              getContainer('SLOTS/ CAPACITY', FontWeight.w700),
            ],
          ),
        ),
        ListView.builder(
            itemCount: classScheduleList.length,
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemBuilder: (context, index) {
              DateTime date =
                  FitnessConstant.df.parse(classScheduleList[index].date);
              return Container(
                decoration: BoxDecoration(
                  border: Border.all(),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        getContainer(FitnessConstant.dateFormat.format(date),
                            FontWeight.w500),
                        getContainer(
                            classScheduleList[index].time, FontWeight.w500),
                        getContainer(
                            '${classScheduleList[index].slotOccupied} / ${classScheduleList[index].capacity}',
                            FontWeight.w500),
                      ],
                    ),
                  ],
                ),
              );
            }),
      ],
    );
  }

  Widget pageBody() {
    return FutureBuilder(
      future: classScheduleService.findByDate(context),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(
              child: Platform.isAndroid
                  ? CircularProgressIndicator()
                  : CupertinoActivityIndicator(
                      animating: true,
                      radius: 50,
                    ),
            );
          case ConnectionState.done:
            if (snapshot.hasData && snapshot.data != null) {
              Map<String, List<ClassSchedule>> response = snapshot.data;
              List<ClassSchedule> classScheduleList = new List();
              response.values.forEach((element) {
                classScheduleList.addAll(element);
              });
              return getColumn(classScheduleList);
            }
            return Center(child: Text('Nothing exist.'));
          default:
            return SizedBox();
        }
      },
    );
  }

  Widget getContainer(String data, FontWeight fw) {
    return Container(
      width: 110,
      child: Text(
        data,
        style: TextStyle(fontSize: 16, fontWeight: fw),
      ),
    );
  }
}
