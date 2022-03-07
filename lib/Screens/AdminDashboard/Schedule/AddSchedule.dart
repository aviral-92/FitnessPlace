import 'dart:io';

import 'package:FitnessPlace/Constant/ConstantWidgets.dart';
import 'package:FitnessPlace/Constant/FitnessConstant.dart';
import 'package:FitnessPlace/CustomWidget/CustomFlatButton.dart';
import 'package:FitnessPlace/CustomWidget/CustomNavigationBar.dart';
import 'package:FitnessPlace/CustomWidget/CustomTextField.dart';
import 'package:FitnessPlace/Modal/ClassSchedule.dart';
import 'package:FitnessPlace/Modal/User.dart';
import 'package:FitnessPlace/Service/TrainerScheduleService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddSchedule extends StatefulWidget {
  @override
  _AddScheduleState createState() => _AddScheduleState();
}

class _AddScheduleState extends State<AddSchedule> {
  DateTime currentDate = DateTime.now();
  DateFormat dateFormat = new DateFormat('MMM-dd-yyyy');
  DateFormat timeFormat = new DateFormat('hh:mm a');

  String currDate = '';
  TextEditingController _controllerDate = new TextEditingController();
  TextEditingController _controllerTime = new TextEditingController();
  TextEditingController _controllerDuration = new TextEditingController();
  TextEditingController _controllerType = new TextEditingController();
  TextEditingController _controllerCapacity = new TextEditingController();
  TextEditingController _controllerTrainer = new TextEditingController();
  TextEditingController _controllerSlotOccupied = new TextEditingController();

  bool progressBarEnable = false;
  List<User> users;

  final List<Text> pickerItems = [
    Text('15 Minutes'),
    Text('30 Minutes'),
    Text('45 Minutes'),
    Text('60 Minutes')
  ];

  @override
  void initState() {
    setUsersList();
    print('*****************************');
    //print('------$users---------');

    currDate = FitnessConstant.dateFormat.format(currentDate);
    super.initState();
  }

  void setUsersList() {
    TrainerScheduleService trainerScheduleService =
        new TrainerScheduleService();
    final response = trainerScheduleService.findTrainersByRole(context);
    print('Response fetched....');
    response.then((value) {
      if (value != null) {
        print('value fetched....');
        setState(() {
          users = User.fromList(value);
          print('value set....');
        });
      }
    });
    print('Response retured....');
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: currentDate,
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        currDate = FitnessConstant.dateFormat.format(pickedDate);
        _controllerDate.text = currDate;
      });
  }

  Future<TimeOfDay> _selectedTime(BuildContext context) async {
    final TimeOfDay pickedDate = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.input,
    );
    return pickedDate;
  }

  CustomNavigationBar _customNavigationBar = new CustomNavigationBar(
    bgColor: FitnessConstant.appBarColor,
    txt: 'Add Schedule',
    isBackButtonReq: true,
    txtColor: Colors.white,
    isIconRequired: false,
  );

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoPageScaffold(
            resizeToAvoidBottomInset: false,
            navigationBar: _customNavigationBar.getCupertinoNavigationBar(),
            child: pageBody(),
          )
        : Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width / 6),
                    child: Text('Add Schedule'),
                  ),
                ],
              ),
              backgroundColor: FitnessConstant.appBarColor,
              automaticallyImplyLeading: true,
            ),
            body: pageBody(),
          );
  }

  Widget pageBody() {
    return SingleChildScrollView(
      //physics: Scrol(),
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: Platform.isAndroid
                      ? MediaQuery.of(context).size.width - 70
                      : MediaQuery.of(context).size.width - 30,
                  padding: const EdgeInsets.only(left: 20),
                  child: CustomTextField(
                    hintTxt: 'Choose Date',
                    controller: _controllerDate,
                    obscure: false,
                    mode: OverlayVisibilityMode.editing,
                    isReadOnly: true,
                    icon: Icon(
                      Icons.calendar_today,
                      color: FitnessConstant.appBarColor,
                    ),
                    fun: () => _showDatePicker(context, _controllerDate),
                  ),
                  /*TextField(
                    decoration: InputDecoration(hintText: 'Enter Date'),
                    controller: _controllerDate,
                    style: TextStyle(fontSize: 22),
                  ),*/
                ),
                Platform.isIOS
                    ? SizedBox()
                    : IconButton(
                        icon: Icon(
                          Icons.calendar_today,
                          color: Colors.deepPurple[900],
                          size: 30,
                        ),
                        onPressed: () => _selectDate(context),
                      ),
              ],
            ),
            //showTimePicker(context: null, initialTime: null)
            SizedBox(height: 20),
            Row(
              children: [
                Container(
                  width: Platform.isAndroid
                      ? MediaQuery.of(context).size.width - 70
                      : MediaQuery.of(context).size.width - 30,
                  padding: const EdgeInsets.only(left: 20),
                  child: CustomTextField(
                    hintTxt: 'Choose Time',
                    controller: _controllerTime,
                    icon: Icon(
                      Icons.timer,
                      color: FitnessConstant.appBarColor,
                    ),
                    isReadOnly: true,
                    obscure: false,
                    mode: OverlayVisibilityMode.editing,
                    fun: () => _showTimePicker(context, _controllerTime),
                  ),
                  /*TextField(
                    decoration: InputDecoration(hintText: 'Enter Time'),
                    controller: _controllerTime,
                    style: TextStyle(fontSize: 22),
                  ),*/
                ),
                Platform.isIOS
                    ? SizedBox()
                    : IconButton(
                        icon: Icon(
                          Icons.timer,
                          color: Colors.deepPurple[900],
                          size: 34,
                        ),
                        onPressed: () {
                          final value = _selectedTime(context);
                          value.then((timeOfDay) {
                            String str = (timeOfDay.hour).toString() +
                                ':' +
                                timeOfDay.minute.toString();
                            setState(() {
                              _controllerTime.text = str;
                            });
                          });
                        },
                      ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Container(
                    width: Platform.isAndroid
                        ? MediaQuery.of(context).size.width - 90
                        : MediaQuery.of(context).size.width - 50,
                    child: CustomTextField(
                      controller: _controllerDuration,
                      hintTxt: 'Choose Duration',
                      icon: Icon(
                        Icons.av_timer,
                        color: FitnessConstant.appBarColor,
                      ),
                      isReadOnly: true,
                      obscure: false,
                      mode: OverlayVisibilityMode.editing,
                      fun: () => forIOS(_controllerDuration),
                    ),
                    /*TextField(
                      decoration: InputDecoration(hintText: 'Enter Duration'),
                      controller: _controllerDuration,
                      style: TextStyle(fontSize: 22),
                    ),*/
                  ),
                ),
                Platform.isAndroid
                    ? Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: DropdownButton<String>(
                          items: <String>['15', '30', '45', '60']
                              .map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (_) {
                            print(_);
                            setState(() {
                              _controllerDuration.text = _ + ' Minutes';
                            });
                          },
                        ),
                      )
                    : SizedBox(),
              ],
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Container(
                  width: 325,
                  child: CustomTextField(
                    controller: _controllerType,
                    hintTxt: 'Enter Workout type',
                    obscure: false,
                    mode: OverlayVisibilityMode.editing,
                  )

                  /*TextField(
                  decoration: InputDecoration(hintText: 'Enter Workout Type'),
                  controller: _controllerType,
                  style: TextStyle(fontSize: 22),
                ),*/
                  ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Container(
                width: 325,
                child: CustomTextField(
                  controller: _controllerCapacity,
                  hintTxt: 'Enter Capacity',
                  obscure: false,
                  mode: OverlayVisibilityMode.editing,
                ),

                /*TextField(
                  decoration: InputDecoration(hintText: 'Enter Capacity'),
                  controller: _controllerCapacity,
                  style: TextStyle(fontSize: 22),
                ),*/
              ),
            ),
            SizedBox(height: 20),
            users != null
                ? Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Container(
                          width: Platform.isIOS
                              ? MediaQuery.of(context).size.width - 50
                              : MediaQuery.of(context).size.width - 200,
                          child: CustomTextField(
                            controller: _controllerTrainer,
                            hintTxt: 'Enter Trainer',
                            icon: Icon(
                              Icons.person,
                              color: FitnessConstant.appBarColor,
                            ),
                            isReadOnly: true,
                            obscure: false,
                            mode: OverlayVisibilityMode.editing,
                            fun: () => _trainerForIOS(_controllerTrainer),
                          ),
                          /*TextField(
                            decoration:
                                InputDecoration(hintText: 'Enter Trainer'),
                            controller: _controllerTrainer,
                            style: TextStyle(fontSize: 22),
                          ),*/
                        ),
                      ),
                      Platform.isAndroid
                          ? Padding(
                              padding: const EdgeInsets.only(top: 12),
                              child: DropdownButton<String>(
                                items: users.map((User user) {
                                  return DropdownMenuItem<String>(
                                    value: user.username,
                                    child: Text(user.username),
                                  );
                                }).toList(),
                                onChanged: (_) {
                                  print(_);
                                  setState(() {
                                    _controllerTrainer.text = _;
                                  });
                                },
                              ),
                            )
                          : SizedBox(),
                    ],
                  )
                : SizedBox(),
            Platform.isIOS
                ? Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: CustomFlatButton(
                        txt: 'ADD',
                        fun: () => _onButtonClicked(),
                      ),
                    ),
                  )
                : Center(
                    child: RaisedButton(
                        color: Colors.deepPurple[900],
                        child: !progressBarEnable
                            ? Text(
                                'ADD',
                                style: TextStyle(
                                    fontSize: 22, color: Colors.white),
                              )
                            : CircularProgressIndicator(),
                        onPressed: () => _onButtonClicked()),
                  ),
          ],
        ),
      ),
    );
  }

  void _onButtonClicked() {
    setState(() {
      progressBarEnable = true;
    });
    TrainerScheduleService trainerScheduleService =
        new TrainerScheduleService();

    final classScheduleResponse = trainerScheduleService.addClassSchedule(
        _controllerDate.text,
        _controllerTime.text,
        _controllerDuration.text,
        _controllerType.text,
        _controllerCapacity.text.isNotEmpty
            ? int.parse(_controllerCapacity.text)
            : 0,
        _controllerTrainer.text,
        context);
    print('------------------------');
    classScheduleResponse.then((value) {
      print('classSchedule at the end --->>> $value');
      if (value != null) {
        if (Platform.isIOS) {
          print(
              'IOS IOS IOS IOS IOS IOS IOS IOS IOS IOS IOS IOS IOS IOS IOS IOS');
          ConstantWidgets.cupertinoOkAlertDialog(
              context, 'Schedule added!', 'Successfully added your schedule');
        } else {
          ConstantWidgets.showMaterialDialog(
              context, 'Successfully added your schedule', 'Schedule added!');
        } //Navigator.pop(context);
      } else {
        if (Platform.isIOS) {
          ConstantWidgets.cupertinoOkAlertDialog(
              context, 'Network issue!', 'unable to add, check later');
        } else {
          ConstantWidgets.showMaterialDialog(
              context, 'unable to add, check later', 'Network issue!');
        }
      }
      _controllerDate.clear();
      _controllerTime.clear();
      _controllerDuration.clear();
      _controllerCapacity.clear();
      _controllerType.clear();
      _controllerTrainer.clear();

      setState(() {
        progressBarEnable = false;
      });
    });
  }

  void _showDatePicker(ctx, TextEditingController controller) {
    showCupertinoModalPopup(
        context: ctx,
        builder: (_) => Container(
              height: 300,
              color: const Color.fromARGB(255, 255, 255, 255),
              child: Column(
                children: [
                  SizedBox(
                    height: 300,
                    child: CupertinoDatePicker(
                        initialDateTime: DateTime.now(),
                        minimumDate:
                            dateFormat.parse(dateFormat.format(DateTime.now())),
                        mode: CupertinoDatePickerMode.date,
                        onDateTimeChanged: (val) {
                          print(val);
                          setState(() {
                            controller.text = dateFormat.format(val);
                          });
                        }),
                  ),
                ],
              ),
            ),
        semanticsDismissible: false);
  }

  void _showTimePicker(ctx, TextEditingController controller) {
    DateTime initial = DateTime.now();
    showCupertinoModalPopup(
        context: ctx,
        builder: (_) => Container(
              height: 300,
              color: const Color.fromARGB(255, 255, 255, 255),
              child: Column(
                children: [
                  SizedBox(
                    height: 300,
                    child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.time,
                      initialDateTime: DateTime(
                        initial.year,
                        initial.month,
                        initial.day,
                        initial.hour,
                        0,
                      ),
                      minuteInterval: 15,
                      minimumDate:
                          timeFormat.parse(timeFormat.format(DateTime.now())),
                      onDateTimeChanged: (value) {
                        print(value);
                        controller.text = timeFormat.format(value);
                      },
                      use24hFormat: false,
                    ),
                  ),
                ],
              ),
            ),
        semanticsDismissible: false);
  }

  void forIOS(TextEditingController controller) {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext builder) {
          return Container(
            height: MediaQuery.of(context).copyWith().size.height * 0.25,
            color: Colors.white,
            child: CupertinoPicker(
              children: pickerItems,
              onSelectedItemChanged: (value) {
                Text text = pickerItems[value];
                setState(() {
                  controller.text = text.data;
                });
              },
              itemExtent: 25,
              diameterRatio: 1,
              useMagnifier: true,
              magnification: 1.2,
            ),
          );
        });
  }

  void _trainerForIOS(TextEditingController controller) {
    List<Text> userItems = new List();
    users.forEach((user) {
      userItems.add(Text(user.username));
    });
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext builder) {
          return Container(
            height: MediaQuery.of(context).copyWith().size.height * 0.25,
            color: Colors.white,
            child: CupertinoPicker(
              children: userItems,
              onSelectedItemChanged: (value) {
                Text text = userItems[value];
                setState(() {
                  controller.text = text.data;
                });
              },
              itemExtent: 25,
              diameterRatio: 1,
              useMagnifier: true,
              magnification: 1.2,
            ),
          );
        });
  }
}
