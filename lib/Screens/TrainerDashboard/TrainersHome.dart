import 'dart:io';

import 'package:FitnessPlace/Constant/FitnessConstant.dart';
import 'package:FitnessPlace/Modal/ClassSchedule.dart';
import 'package:FitnessPlace/Service/ClassScheduleService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TrainersHome extends StatefulWidget {
  @override
  _TrainersHomeState createState() => _TrainersHomeState();
}

class _TrainersHomeState extends State<TrainersHome> {
  DateFormat dateFormat = new DateFormat('yyyy-MM-dd');
  String currentDate;
  @override
  void initState() {
    currentDate = dateFormat.format(DateTime.now());
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
            child: futureBuilderData())
        : futureBuilderData();
  }

  Widget getWidget(Map<String, List<ClassSchedule>> map) {
    List<String> keys = map != null ? map.keys.toList() : [];
    return ListView.builder(
        itemCount: map.length,
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemBuilder: (context, index) {
          List<ClassSchedule> classScheduleList = map[keys[index]];
          //print('Map first value --> ${map[keys[index]]}');
          return Container(
            child: Card(
              color: Colors.grey[200],
              elevation: 6,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(),
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Text(
                          'DATE:  ${keys[index]}',
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 16),
                        ),
                      ),
                    ),
                    classScheduleList.length != 0
                        ? ListView.builder(
                            itemCount: classScheduleList.length,
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Container(
                                decoration: BoxDecoration(
                                  border: Border.all(),
                                  color: Colors.white,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      '${classScheduleList[index].time}',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      '${classScheduleList[index].duration}',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      '${classScheduleList[index].slotOccupied} / ${classScheduleList[index].capacity}',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              );
                            })
                        : Container(
                            child: Center(
                              child: Text('Nothing to display'),
                            ),
                          ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  /*void _showDatePicker(ctx) {
    showCupertinoModalPopup(
        context: ctx,
        builder: (_) => Container(
              height: 500,
              color: const Color.fromARGB(255, 255, 255, 255),
              child: Column(
                children: [
                  SizedBox(
                    height: 500,
                    child: CupertinoDatePicker(
                        initialDateTime: DateTime.now(),
                        minimumDate:
                            dateFormat.parse(dateFormat.format(DateTime.now())),
                        mode: CupertinoDatePickerMode.date,
                        onDateTimeChanged: (val) {
                          print(val);
                          setState(() {
                            currentDate = dateFormat.format(val);
                          });
                        }),
                  ),
                ],
              ),
            ),
        semanticsDismissible: false);
  }*/

  FutureBuilder futureBuilderData() {
    ClassScheduleService classScheduleService = new ClassScheduleService();
    return FutureBuilder(
        future: classScheduleService.findByGivenDate(context, currentDate),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Platform.isIOS
                  ? CupertinoActivityIndicator(
                      animating: true,
                      radius: 50,
                    )
                  : CircularProgressIndicator(),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData)
              return getWidget(snapshot.data);
            else
              return Text('No schedule found');
          } else {
            return const Text('Somthing went wrong!! please contact admin');
          }
        });
  }

  /*Future<Map<String, List<ClassSchedule>>> _data() async {
    ClassScheduleService classScheduleService = new ClassScheduleService();
    return await classScheduleService.findByGivenDate(context, currentDate);
  }*/
}
