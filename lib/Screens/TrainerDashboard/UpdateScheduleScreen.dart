import 'dart:io';

import 'package:FitnessPlace/Constant/FitnessConstant.dart';
import 'package:FitnessPlace/CustomWidget/CustomFlatButton.dart';
import 'package:FitnessPlace/CustomWidget/CustomNavigationBar.dart';
import 'package:FitnessPlace/CustomWidget/CustomTextField.dart';
import 'package:FitnessPlace/Modal/ClassSchedule.dart';
import 'package:FitnessPlace/Modal/Profile.dart';
import 'package:FitnessPlace/Screens/TrainerDashboard/AddTrainerSchedule.dart';
import 'package:FitnessPlace/Service/ClassScheduleService.dart';
import 'package:FitnessPlace/Service/TrainerScheduleService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UpdateScheduleScreen extends StatefulWidget {
  @override
  _UpdateScheduleScreenState createState() => _UpdateScheduleScreenState();
}

class _UpdateScheduleScreenState extends State<UpdateScheduleScreen> {
  CustomNavigationBar customNavigationBar = new CustomNavigationBar(
    bgColor: FitnessConstant.appBarColor,
    isBackButtonReq: false,
    isIconRequired: false,
    txt: 'Update',
    txtColor: Colors.white,
  );
  TrainerScheduleService trainerScheduleService = new TrainerScheduleService();
  ClassScheduleService classScheduleService = new ClassScheduleService();
  TextEditingController dateController = new TextEditingController();
  TextEditingController timeController = new TextEditingController();
  TextEditingController capacityController = new TextEditingController();
  TextEditingController durationController = new TextEditingController();
  TextEditingController slotOccupiedController = new TextEditingController();
  TextEditingController workoutTypeController = new TextEditingController();
  TextEditingController idController = new TextEditingController();
  TextEditingController statusController = new TextEditingController();
  Profile profile;

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: customNavigationBar.getCupertinoNavigationBar(),
            child: _futureCall(),
          )
        : Container(
            child: FutureBuilder(
                future: trainerScheduleService.findByDateWithProfile(context),
                builder: (context, snapshot) {
                  return _futureCall();
                }),
          );
  }

  Widget _futureCall() {
    return FutureBuilder(
        future: classScheduleService.findByDateAndClassBooked(context),
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
            return _setFutureWidget(snapshot.data);
          } else {
            return const Text('Somthing went wrong!! please contact admin');
          }
        });
  }

  Widget _setFutureWidget(Map<String, List<ClassSchedule>> map) {
    List<String> keys = map == null ? [] : map.keys.toList();
    //print('map.length========>>>>>>${map.length}');
    return ListView.builder(
        itemCount: map != null ? map.length : 0,
        physics: ScrollPhysics(),
        itemBuilder: (context, index) {
          List<ClassSchedule> classScheduleList = map[keys[index]];
          print(
              'classScheduleList.length========>>>>>>${classScheduleList.length}');
          return Container(
            height: 30,
            child: ListView.builder(
                physics: ScrollPhysics(),
                itemCount: classScheduleList.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 6,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          classScheduleList[index].date,
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                        Text(
                          classScheduleList[index].time,
                          style: TextStyle(fontSize: 17),
                        ),
                        Container(
                          width: 90,
                          height: 20,
                          child: CustomFlatButton(
                            txt: 'update',
                            fontsize: 17,
                            fun: () {
                              print(
                                  '====>>>>>${classScheduleList[index].date}');
                              Platform.isAndroid
                                  ? Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            AddTrainerSchedule(
                                          classSchedule:
                                              classScheduleList[index],
                                        ),
                                      ),
                                    )
                                  : forIOS(classScheduleList[index]);
                            },
                          ),
                        ),
                        Container(
                          child: GestureDetector(
                            child: Icon(
                              Icons.delete,
                              color: FitnessConstant.appBarColor,
                            ),
                            onTap: () {
                              final response =
                                  classScheduleService.deleteSchedule(
                                      context, classScheduleList[index].id);
                              response.then((value) {
                                if (value != null) {
                                  showDialog<void>(
                                    context: context,
                                    barrierDismissible:
                                        false, // user must tap button!
                                    builder: (BuildContext context) {
                                      return CupertinoAlertDialog(
                                        title: Text('Successfully deleted.'),
                                        actions: <Widget>[
                                          CupertinoDialogAction(
                                            child: Text('OK'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          );
        });
  }

  void forIOS(ClassSchedule classSchedule) {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext builder) {
          return commonForIosAndroid(classSchedule);
        });
  }

  Widget commonForIosAndroid(ClassSchedule classSchedule) {
    dateController.text = classSchedule.date;
    timeController.text = classSchedule.time;
    capacityController.text =
        classSchedule.capacity != null ? classSchedule.capacity.toString() : '';
    durationController.text = classSchedule.duration;
    slotOccupiedController.text = classSchedule.slotOccupied != null
        ? classSchedule.slotOccupied.toString()
        : '';
    workoutTypeController.text = classSchedule.workoutType;
    idController.text =
        classSchedule.id != null ? classSchedule.id.toString() : '';
    statusController.text =
        classSchedule.status != null ? classSchedule.status.toString() : '';
    profile = classSchedule.profile;
    return Container(
      height: MediaQuery.of(context).copyWith().size.height * 0.49,
      color: Colors.white,
      child: Column(
        children: [
          getCustomTextField(dateController, 'Date'),
          getCustomTextField(timeController, 'Time'),
          getCustomTextField(capacityController, 'Capacity'),
          getCustomTextField(durationController, 'Duration'),
          getCustomTextField(slotOccupiedController, 'Slot Occupied'),
          getCustomTextField(workoutTypeController, 'Workout Type'),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: CustomFlatButton(
                txt: 'Upadte',
                fun: () {
                  ClassSchedule classSchedule = new ClassSchedule(
                    id: idController.text != null
                        ? int.parse(idController.text)
                        : 0,
                    date: dateController.text,
                    time: timeController.text,
                    capacity: capacityController.text != null
                        ? int.parse(capacityController.text)
                        : 0,
                    duration: durationController.text,
                    slotOccupied: slotOccupiedController.text != null
                        ? int.parse(slotOccupiedController.text)
                        : 0,
                    workoutType: workoutTypeController.text,
                    status: bool.fromEnvironment(statusController.text),
                    profile: profile,
                  );
                  print(classSchedule.toString());
                  final response = trainerScheduleService.updateClassSchedule(
                      context, classSchedule);
                  response.then((classSchedule) {
                    if (classSchedule != null) {
                      print('Success');
                    } else {
                      print('Error from else');
                    }
                  }).catchError((onError) {
                    print('Catch Error $onError');
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getCustomTextField(TextEditingController controller, String txt) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
      child: CustomTextField(
        controller: controller,
        hintTxt: txt,
        obscure: false,
        mode: OverlayVisibilityMode.editing,
      ),
    );
  }
}
