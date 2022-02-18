import 'package:FitnessPlace/Constant/ConstantWidgets.dart';
import 'package:FitnessPlace/Constant/FitnessConstant.dart';
import 'package:FitnessPlace/Modal/ClassSchedule.dart';
import 'package:FitnessPlace/Service/ClassScheduleService.dart';
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
    //print('-------FUTURE CALLED------');
    //print('DONE');
    return classScheduleService.findByDateAndClassBooked(context).then((value) {
      return value;
    }).catchError((onError) {
      //ConstantWidgets.showMaterialDialog(context, 'txt!!', 'title!! $onError');
      return Future.error(onError.toString());
    });
    //return classSchedulelMap;
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
                bool isEnabled = classScheduleService.isEnabled(
                    classScheduleList[index].date,
                    classScheduleList[index].time);
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
                          CircleAvatar(
                            radius: 30,
                            backgroundImage:
                                AssetImage('assets/avatar/img.png'),
                            /*NetworkImage(
                                '${classScheduleList[index].profile.picturePath}'),*/
                          ),
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
                          SizedBox(
                              //width: 70,
                              ),
                          MaterialButton(
                            disabledColor:
                                classScheduleList[index].classStatus != null &&
                                        isEnabled
                                    ? Colors.deepPurple[900]
                                    : Colors.grey,
                            disabledElevation: isEnabled ? 6 : 0,
                            elevation: 6,
                            color:
                                classScheduleList[index].classStatus != null &&
                                        isEnabled
                                    ? Colors.deepPurple[900]
                                    : Colors.white,
                            //hoverColor: Colors.green,
                            onPressed: buttonClick(
                                isEnabled, classScheduleList[index]),
                            child: getIcon(isEnabled,
                                classScheduleList[index].classStatus),
                            shape: CircleBorder(),
                          ),
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

  Widget getIcon(bool isEnable, String classStatus) {
    if (isEnable && classStatus != null)
      return Icon(Icons.check, color: Colors.white);
    else if (isEnable)
      return Icon(Icons.add, color: Colors.deepPurple[900]);
    else if (classStatus != null)
      return Icon(Icons.done_outline, color: Colors.white);
    else
      return Icon(Icons.alarm, color: Colors.deepPurple[900]);
  }

  Function buttonClick(bool isEnabled, ClassSchedule classSchedule) {
    ClassScheduleService classScheduleService = new ClassScheduleService();
    if (isEnabled && classSchedule.classStatus == null)
      return () {
        /*BOOK CLASS*/
        classScheduleService.bookClass(context, classSchedule).then((_) {
          setState(() {
            initState();
          });
        });
      };
    else if (isEnabled && classSchedule.classStatus != null) {
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
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      //top: false,
      left: false,
      right: false,
      child: FutureBuilder(
        future: futureState(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return CircularProgressIndicator();
            case ConnectionState.done:
              if (snapshot.hasData && snapshot.data != null) {
                classSchedulelMap = snapshot.data;
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
