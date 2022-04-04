import 'dart:io';

import 'package:FitnessPlace/Constant/ConstantWidgets.dart';
import 'package:FitnessPlace/Constant/FitnessConstant.dart';
import 'package:FitnessPlace/CustomWidget/CustomNavigationBar.dart';
import 'package:FitnessPlace/CustomWidget/CustomTextField.dart';
import 'package:FitnessPlace/Modal/ClassSchedule.dart';
import 'package:FitnessPlace/Service/TrainerScheduleService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddTrainerSchedule extends StatefulWidget {
  final ClassSchedule classSchedule;

  const AddTrainerSchedule({Key key, this.classSchedule}) : super(key: key);
  @override
  _AddTrainerScheduleState createState() =>
      _AddTrainerScheduleState(this.classSchedule);
}

class _AddTrainerScheduleState extends State<AddTrainerSchedule> {
  DateTime currentDate = DateTime.now();
  DateFormat dateFormat = new DateFormat('MMM-dd-yyyy');
  //DateFormat dateFormat = new DateFormat('MMM-dd-yyyy');
  String currDate = '';
  TextEditingController _controllerDate = new TextEditingController();
  TextEditingController _controllerTime = new TextEditingController();
  TextEditingController _controllerDuration = new TextEditingController();
  TextEditingController _controllerType = new TextEditingController();
  TextEditingController _controllerCapacity = new TextEditingController();

  bool progressBarEnable = false;

  final ClassSchedule classSchedule;

  _AddTrainerScheduleState(this.classSchedule);

  @override
  void initState() {
    if (classSchedule != null) {
      _controllerDate.text = classSchedule.date;
      _controllerTime.text = classSchedule.time;
      _controllerDuration.text = classSchedule.duration;
      _controllerType.text = classSchedule.workoutType;
      _controllerCapacity.text = classSchedule.capacity == null
          ? '0'
          : classSchedule.capacity.toString();
    }
    currDate = FitnessConstant.dateFormat.format(currentDate);
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    CustomNavigationBar customNavigationBar = new CustomNavigationBar(
      bgColor: FitnessConstant.appBarColor,
      txt: 'Add Schedule',
      txtColor: Colors.white,
      isBackButtonReq: classSchedule == null ? false : true,
      isIconRequired: false,
    );
    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: customNavigationBar.getCupertinoNavigationBar(),
            child: _pageBody())
        : classSchedule == null
            ? _pageBody()
            : Scaffold(
                resizeToAvoidBottomInset: false,
                appBar: AppBar(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width / 6),
                        child: Text(classSchedule == null
                            ? 'Add Schedule'
                            : 'Update Schedule'),
                      ),
                    ],
                  ),
                  backgroundColor: FitnessConstant.appBarColor,
                  automaticallyImplyLeading: true,
                ),
                body: _pageBody(),
              );
  }

  Widget _pageBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: Platform.isIOS
                  ? MediaQuery.of(context).size.width - 30
                  : MediaQuery.of(context).size.width - 70,
              padding: const EdgeInsets.only(left: 20, top: 10),
              child: CustomTextField(
                controller: _controllerDate,
                hintTxt: 'Choose Date',
                icon: Icon(
                  Icons.calendar_today,
                  color: FitnessConstant.appBarColor,
                ),
                isReadOnly: true,
                obscure: false,
                mode: OverlayVisibilityMode.editing,
                fun: () => _showDatePicker(context, _controllerDate),
              ),

              /*TextField(
                decoration: InputDecoration(hintText: 'Enter Date'),
                controller: _controllerDate,
                style: TextStyle(fontSize: 22),
              ),*/
            ),
            Platform.isAndroid
                ? IconButton(
                    icon: Icon(
                      Icons.calendar_today,
                      color: Colors.deepPurple[900],
                      size: 30,
                    ),
                    onPressed: () => _selectDate(context),
                  )
                : SizedBox(),
          ],
        ),
        //showTimePicker(context: null, initialTime: null)
        SizedBox(height: 20),
        Row(
          children: [
            Container(
              width: Platform.isIOS
                  ? MediaQuery.of(context).size.width - 30
                  : MediaQuery.of(context).size.width - 70,
              padding: const EdgeInsets.only(left: 20),
              child: CustomTextField(
                controller: _controllerTime,
                hintTxt: 'Choose Time',
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
            Platform.isAndroid
                ? IconButton(
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
                  )
                : SizedBox(),
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
                      items:
                          <String>['15', '30', '45', '60'].map((String value) {
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
            ),
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
        Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(left: 20, right: 30),
          child: RaisedButton(
              color: Colors.deepPurple[900],
              child: !progressBarEnable
                  ? Text(
                      classSchedule == null ? 'ADD' : 'UPDATE',
                      style: TextStyle(fontSize: 22, color: Colors.white),
                    )
                  : CircularProgressIndicator(),
              onPressed: () {
                setState(() {
                  progressBarEnable = true;
                });
                final classScheduleResponse = futureClassSchedule();
                /*TrainerScheduleService trainerScheduleService =
                    new TrainerScheduleService();
                
                final classSchedule = trainerScheduleService.addClassSchedule(
                    _controllerDate.text,
                    _controllerTime.text,
                    _controllerDuration.text,
                    _controllerType.text,
                    _controllerCapacity.text.isNotEmpty
                        ? int.parse(_controllerCapacity.text)
                        : 0,
                    null,
                    context);*/
                print('------------------------');
                classScheduleResponse.then((value) {
                  print('classSchedule at the end --->>> $value');
                  if (value != null) {
                    Platform.isAndroid
                        ? ConstantWidgets.showMaterialDialog(
                            context,
                            'Successfully added your schedule',
                            'Schedule added!')
                        : ConstantWidgets.cupertinoOkAlertDialog(
                            context,
                            'Schedule added!',
                            'Successfully added your schedule');
                  } else {
                    Platform.isAndroid
                        ? ConstantWidgets.showMaterialDialog(context,
                            'unable to add, check later', 'Network issue!')
                        : ConstantWidgets.cupertinoOkAlertDialog(context,
                            'Network issue!', 'unable to add, check later');
                  }
                  _controllerDate.clear();
                  _controllerTime.clear();
                  _controllerDuration.clear();
                  _controllerCapacity.clear();
                  _controllerType.clear();

                  setState(() {
                    progressBarEnable = false;
                  });
                });
              }),
        ),
      ],
    );
  }

  Future<ClassSchedule> futureClassSchedule() {
    TrainerScheduleService trainerScheduleService =
        new TrainerScheduleService();
    if (classSchedule == null) {
      return trainerScheduleService.addClassSchedule(
          _controllerDate.text,
          _controllerTime.text,
          _controllerDuration.text,
          _controllerType.text,
          _controllerCapacity.text.isNotEmpty
              ? int.parse(_controllerCapacity.text)
              : 0,
          null,
          context);
    } else {
      print('status ====----====>>>> ${classSchedule.scheduleStatus}');
      ClassSchedule newClassSchedule = new ClassSchedule(
        id: classSchedule.id,
        date: _controllerDate.text,
        time: _controllerTime.text,
        capacity: _controllerCapacity.text != null
            ? int.parse(_controllerCapacity.text)
            : 0,
        duration: _controllerDuration.text,
        workoutType: _controllerType.text,
        classStatus: classSchedule.scheduleStatus != null
            ? classSchedule.scheduleStatus.toString()
            : '',
        //status: classSchedule.scheduleStatus,
        profile: classSchedule.profile,
      );
      return trainerScheduleService.updateClassSchedule(
          context, newClassSchedule);
    }
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

  DateFormat timeFormat = new DateFormat('hh:mm a');

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

  final List<Text> pickerItems = [
    Text('15 Minutes'),
    Text('30 Minutes'),
    Text('45 Minutes'),
    Text('60 Minutes')
  ];

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
}
