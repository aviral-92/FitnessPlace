import 'package:FitnessPlace/Modal/ClassSchedule.dart';
import 'package:FitnessPlace/Service/TrainerScheduleService.dart';
import 'package:flutter/material.dart';

class TrainersHome extends StatefulWidget {
  @override
  _TrainersHomeState createState() => _TrainersHomeState();
}

class _TrainersHomeState extends State<TrainersHome> {
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //mainAxisSize: MainAxisSize.min,
                  children: [
                    getContainer('DATE', FontWeight.w700),
                    getContainer('TIME', FontWeight.w700),
                    getContainer('DURATION', FontWeight.w700),
                    getContainer('SLOTS', FontWeight.w700),
                  ],
                ),
              ),
              ListView.builder(
                  itemCount: classScheduleList.length,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        border: Border.all(),
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              getContainer(
                                  classScheduleList[index].date.substring(0, 6),
                                  FontWeight.w500),
                              getContainer(classScheduleList[index].time,
                                  FontWeight.w500),
                              getContainer(classScheduleList[index].duration,
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
      //width: 100,
      //width: 95,
      //width: MediaQuery.of(context).size.width / 4,
      child: Text(
        data,
        style: TextStyle(fontSize: 16, fontWeight: fw),
      ),
    );
  }

  void addData() {
    TrainerScheduleService trainerScheduleService =
        new TrainerScheduleService();
    final response = trainerScheduleService.findByDateWithProfile(context);
    response.then((list) {
      setState(() {
        classScheduleList = list;
      });
    });
  }
}
