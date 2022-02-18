import 'package:FitnessPlace/Modal/ClassSchedule.dart';

class ClassScheduleList {
  List<ClassSchedule> classSchedulelList;
  Map<String, List<ClassSchedule>> classSchedulelMap;

  ClassScheduleList({this.classSchedulelList});
  ClassScheduleList.map(this.classSchedulelMap);

  ClassScheduleList.fromJson(List<dynamic> parsedJson) {
    classSchedulelList = new List<ClassSchedule>();
    parsedJson.forEach((element) {
      classSchedulelList.add(ClassSchedule.fromMap(element));
    });
  }

  ClassScheduleList.fromMap(Map<String, dynamic> parsedJson) {
    classSchedulelMap = new Map();
    parsedJson.forEach((key, value) {
      classSchedulelMap.putIfAbsent(key, () => fromJsonToList(value));
    });
  }

  List<ClassSchedule> fromJsonToList(dynamic parsedJson) {
    List<ClassSchedule> classScheduledlList = new List<ClassSchedule>();
    parsedJson.forEach((element) {
      classScheduledlList.add(ClassSchedule.fromMap(element));
    });
    return classScheduledlList;
  }
}
