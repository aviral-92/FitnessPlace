import 'package:FitnessPlace/Constant/ConstantWidgets.dart';
import 'package:FitnessPlace/Constant/FitnessConstant.dart';
import 'package:FitnessPlace/Modal/User.dart';
import 'package:FitnessPlace/Service/TrainerScheduleService.dart';
import 'package:flutter/material.dart';

class AddSchedule extends StatefulWidget {
  @override
  _AddScheduleState createState() => _AddScheduleState();
}

class _AddScheduleState extends State<AddSchedule> {
  DateTime currentDate = DateTime.now();
  //DateFormat dateFormat = new DateFormat('MMM-dd-yyyy');
  String currDate = '';
  TextEditingController _controllerDate = new TextEditingController();
  TextEditingController _controllerTime = new TextEditingController();
  TextEditingController _controllerDuration = new TextEditingController();
  TextEditingController _controllerType = new TextEditingController();
  TextEditingController _controllerCapacity = new TextEditingController();
  TextEditingController _controllerTrainer = new TextEditingController();

  bool progressBarEnable = false;
  List<User> users;

  @override
  void initState() {
    setUsersList();
    print('*****************************');
    print('------$users---------');
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding:
                  EdgeInsets.only(left: MediaQuery.of(context).size.width / 6),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width - 70,
              padding: const EdgeInsets.only(left: 20),
              child: TextField(
                decoration: InputDecoration(hintText: 'Enter Date'),
                controller: _controllerDate,
                style: TextStyle(fontSize: 22),
              ),
            ),
            IconButton(
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
              width: MediaQuery.of(context).size.width - 70,
              padding: const EdgeInsets.only(left: 20),
              child: TextField(
                decoration: InputDecoration(hintText: 'Enter Time'),
                controller: _controllerTime,
                style: TextStyle(fontSize: 22),
              ),
            ),
            IconButton(
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
                width: MediaQuery.of(context).size.width - 90,
                child: TextField(
                  decoration: InputDecoration(hintText: 'Enter Duration'),
                  controller: _controllerDuration,
                  style: TextStyle(fontSize: 22),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: DropdownButton<String>(
                items: <String>['15', '30', '45', '60'].map((String value) {
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
            ),
          ],
        ),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Container(
            width: 325,
            child: TextField(
              decoration: InputDecoration(hintText: 'Enter Workout Type'),
              controller: _controllerType,
              style: TextStyle(fontSize: 22),
            ),
          ),
        ),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Container(
            width: 325,
            child: TextField(
              decoration: InputDecoration(hintText: 'Enter Capacity'),
              controller: _controllerCapacity,
              style: TextStyle(fontSize: 22),
            ),
          ),
        ),
        SizedBox(height: 20),
        users != null
            ? Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Container(
                      width: MediaQuery.of(context).size.width - 200,
                      child: TextField(
                        decoration: InputDecoration(hintText: 'Enter Trainer'),
                        controller: _controllerTrainer,
                        style: TextStyle(fontSize: 22),
                      ),
                    ),
                  ),
                  Padding(
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
                  ),
                ],
              )
            : SizedBox(),
        Center(
          child: RaisedButton(
              color: Colors.deepPurple[900],
              child: !progressBarEnable
                  ? Text(
                      'ADD',
                      style: TextStyle(fontSize: 22, color: Colors.white),
                    )
                  : CircularProgressIndicator(),
              onPressed: () {
                setState(() {
                  progressBarEnable = true;
                });
                TrainerScheduleService trainerScheduleService =
                    new TrainerScheduleService();
                print('------------------------');
                final classSchedule = trainerScheduleService.addClassSchedule(
                    _controllerDate.text,
                    _controllerTime.text,
                    _controllerDuration.text,
                    _controllerType.text,
                    _controllerCapacity.text.isNotEmpty
                        ? int.parse(_controllerCapacity.text)
                        : 0,
                    _controllerTrainer.text,
                    context);
                classSchedule.then((value) {
                  print('classSchedule at the end --->>> $value');
                  if (value != null) {
                    ConstantWidgets.showMaterialDialog(context,
                        'Successfully added your schedule', 'Schedule added!');
                    //Navigator.pop(context);
                  } else {
                    ConstantWidgets.showMaterialDialog(context,
                        'unable to add, check later', 'Network issue!');
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
      //),
    );
  }
}
