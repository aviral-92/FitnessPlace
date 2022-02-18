import 'package:FitnessPlace/Constant/FitnessConstant.dart';
import 'package:FitnessPlace/Modal/ClassSchedule.dart';
import 'package:FitnessPlace/Service/ClassScheduleService.dart';
import 'package:flutter/material.dart';

class AdminHomeScreen extends StatefulWidget {
  @override
  _AdminHomeScreenState createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  List<ClassSchedule> classScheduleList = new List();

  @override
  void initState() {
    addData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return classScheduleList.length != 0
        ? Column(
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
                              getContainer(
                                  FitnessConstant.dateFormat.format(date),
                                  FontWeight.w500),
                              getContainer(classScheduleList[index].time,
                                  FontWeight.w500),
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
          )
        : Container(
            child: Center(
              child: Text('Nothing to display'),
            ),
          );
  }

  Widget getContainer(String data, FontWeight fw) {
    return Container(
      width: 100,
      child: Text(
        data,
        style: TextStyle(fontSize: 16, fontWeight: fw),
      ),
    );
  }

  void addData() {
    ClassScheduleService classScheduleService = new ClassScheduleService();
    final response = classScheduleService.findByDate(context);
    response.then((map) {
      setState(() {
        map.values.forEach((element) {
          classScheduleList.addAll(element);
        });
      });
    });
  }
}
