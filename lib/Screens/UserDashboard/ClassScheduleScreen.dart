import 'dart:io';

import 'package:FitnessPlace/Constant/FitnessConstant.dart';
import 'package:FitnessPlace/CustomWidget/CustomNavigationBar.dart';
import 'package:FitnessPlace/Modal/ClassSchedule.dart';
import 'package:FitnessPlace/Service/ClassScheduleService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sticky_headers/sticky_headers.dart';

class ClassScheduleScreen extends StatefulWidget {
  @override
  _ClassScheduleScreenState createState() => _ClassScheduleScreenState();
}

class _ClassScheduleScreenState extends State<ClassScheduleScreen> {
  Map<String, List<ClassSchedule>> classSchedulelMap;
  ClassScheduleService classScheduleService = new ClassScheduleService();

  Future<void> futureState() async {
    return classScheduleService.findByDateAndClassBooked(context).then((value) {
      return value;
    }).catchError((onError) {
      return Future.error(onError.toString());
    });
  }

  Widget _listItem(List<ClassSchedule> classScheduleList) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12),
        child: Card(
          elevation: 6,
          child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: classScheduleList.length,
              itemBuilder: (context, index) {
                //Check, current user booked or not.
                //print(classScheduleList[index]);
                /*bool isEnabled = classScheduleService.isEnabled(
                    classScheduleList[index].date,
                    classScheduleList[index].time);*/
                return Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.grey),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '${classScheduleList[index].time}',
                          style: GoogleFonts.pTSansNarrow(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          /*CircleAvatar(
                            radius: 30,
                            backgroundImage: AssetImage(
                                'assets/img/F0345748-C3FC-4BDD-87E2-E1266AFBE06B_4_5005_c.jpeg'),
                            /*NetworkImage(
                                '${classScheduleList[index].profile.picturePath}'),*/
                          ),*/
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 12,
                            ),
                            child: Text(
                              '${classScheduleList[index].profile.name} \n${classScheduleList[index].duration}',
                              style: GoogleFonts.pTSansNarrow(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 12,
                            ),
                            child: Text(
                              '${classScheduleList[index].workoutType}',
                              style: GoogleFonts.pTSansNarrow(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(
                              //width: 70,
                              ),
                          FutureBuilder(
                              future: classScheduleService
                                  .checkClassBookedForSpecificUser(
                                      context, classScheduleList[index]),
                              builder: (context, snapshot) {
                                switch (snapshot.connectionState) {
                                  case ConnectionState.waiting:
                                    return Center(
                                      child: Platform.isAndroid
                                          ? CircularProgressIndicator()
                                          : CupertinoActivityIndicator(
                                              radius: 20,
                                              animating: true,
                                            ),
                                    );
                                  case ConnectionState.done:
                                    bool isExist = snapshot.data;
                                    return MaterialButton(
                                      disabledColor: isExist
                                          ? Colors.deepPurple[900]
                                          : Colors.white,
                                      disabledElevation: isExist ? 0 : 6,
                                      elevation: 6,
                                      color: isExist
                                          ? Colors.deepPurple[900]
                                          : Colors.white,
                                      onPressed: buttonClick(
                                          isExist, classScheduleList[index]),
                                      child: getIcon(isExist),
                                      shape: CircleBorder(),
                                    );
                                  default:
                                    if (snapshot.hasError) {
                                      return Container(
                                        child: Text('Error: ${snapshot.error}'),
                                      );
                                    } else
                                      return Container();
                                }
                              }),
                        ],
                      ),
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }

  Widget getIcon(bool isEnable) {
    if (isEnable)
      return Icon(Icons.check, color: Colors.white);
    else
      return Icon(Icons.add, color: Colors.deepPurple[900]);
  }

  Function buttonClick(bool isEnabled, ClassSchedule classSchedule) {
    ClassScheduleService classScheduleService = new ClassScheduleService();
    if (!isEnabled)
      return () {
        /*BOOK CLASS*/
        classScheduleService.bookClass(context, classSchedule).then((_) {
          setState(() {
            //initState();
          });
        });
      };
    else {
      return () {
        /*CANCEL CLASS*/
        //print('hello->$classSchedule');
        classScheduleService.cancelClass(classSchedule, context).then((value) {
          setState(() {
            initState();
          });
        });
      };
    }
    //return null;
  }

  CustomNavigationBar _customNavigationBar = new CustomNavigationBar(
    bgColor: FitnessConstant.appBarColor,
    isBackButtonReq: false,
    isIconRequired: false,
    txt: 'HOME',
    txtColor: Colors.white,
  );

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? pageBody()
        : CupertinoPageScaffold(
            navigationBar: _customNavigationBar.getCupertinoNavigationBar(),
            child: pageBody(),
          );
  }

  Widget pageBody() {
    return SafeArea(
      //top: false,
      left: false,
      right: false,
      child: FutureBuilder(
        future: futureState(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                child: Platform.isAndroid
                    ? CircularProgressIndicator()
                    : CupertinoActivityIndicator(
                        radius: 50,
                        animating: true,
                      ),
              );
            case ConnectionState.done:
              if (snapshot.hasData && snapshot.data != null) {
                classSchedulelMap = snapshot.data;
                print(
                    'classSchedulelMap length --> ${classSchedulelMap.length}');
                return Container(
                  child: ListView.builder(
                      physics: ScrollPhysics(),
                      itemCount: classSchedulelMap.length,
                      itemBuilder: (context, index) {
                        List l = stckeyList();
                        return l[index];
                      }),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Try again, after sometime!'),
                );
              } else {
                return Center(
                  child: Text('No Data Found'),
                );
              }
              break;
            default:
              if (snapshot.hasError) {
                return Container(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else
                return Container();
          }
        },
      ),
    );
  }

  List<Widget> stckeyList() {
    DateFormat dateFormat = new DateFormat('EEEE, MMM-dd-yyyy');
    List<Widget> widgetList = List();
    classSchedulelMap.forEach((key, value) {
      String dt = dateFormat.format(FitnessConstant.df.parse(key));
      //print(dt);
      Widget s = StickyHeader(
        header: Container(
          height: 30.0,
          color: Colors.grey[200],
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          alignment: Alignment.centerRight,
          child: Container(
            child: Text(
              '$dt',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        content: _listItem(value),
      );
      widgetList.add(s);
    });
    return widgetList;
  }
}
