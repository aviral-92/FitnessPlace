import 'package:FitnessPlace/Constant/ConstantWidgets.dart';
import 'package:FitnessPlace/Constant/FitnessConstant.dart';
import 'package:FitnessPlace/Modal/ClassSchedule.dart';
//import 'package:FitnessPlace/Modal/User.dart';
import 'package:FitnessPlace/Provider/ClassScheduleList.dart';
import 'package:FitnessPlace/Repository/ClassScheduleRepository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ClassScheduleService {
  ClassScheduleRepository classScheduleRepository =
      new ClassScheduleRepository();

  Future<Map<String, List<ClassSchedule>>> findByDate(
      BuildContext context) async {
    DateFormat dateFormat = new DateFormat('yyyy-MM-dd');
    DateTime date = dateFormat.parse(DateTime.now().toString());
    final response =
        await classScheduleRepository.findByDate(date.toString(), context);
    if (response != null) {
      ClassScheduleList classScheduleList = ClassScheduleList.fromMap(response);
      return classScheduleList.classSchedulelMap;
    }
    return null;
  }

  Future<Map<String, List<ClassSchedule>>> findByGivenDate(
      BuildContext context, String date) async {
    DateFormat dateFormat = new DateFormat('yyyy-MM-dd');
    print('---->$date');
    DateTime parseDate = dateFormat.parse(date);
    final response =
        await classScheduleRepository.findByDate(parseDate.toString(), context);
    if (response != null) {
      ClassScheduleList classScheduleList = ClassScheduleList.fromMap(response);
      return classScheduleList.classSchedulelMap;
    }
    return null;
  }

  Future<void> bookClass(
      BuildContext context, ClassSchedule classSchedule) async {
    final response =
        await classScheduleRepository.bookClass(context, classSchedule);
    if (response == null) {
      ConstantWidgets.showMaterialDialog(
          context, 'unable to book your class', 'oh no!');
    } else {
      ConstantWidgets.showMaterialDialog(
          context, 'Successfully booked your class', 'Class Booked!');
    }
  }

  Future<List<ClassSchedule>> findClassScheduleFromBookingSlot(
      String date, BuildContext context) async {
    final response = await classScheduleRepository
        .findClassScheduleFromBookingSlot('BOOKED', date, context);
    if (response == null) return null;
    ClassScheduleList classScheduleList = ClassScheduleList.fromJson(response);
    return classScheduleList.classSchedulelList;
  }

  Future<Map<String, List<ClassSchedule>>> findByDateAndClassBooked(
      BuildContext context) async {
    DateFormat dateFormat = new DateFormat('yyyy-MM-dd');
    DateFormat timeformat = new DateFormat('hh:mm a');
    String time = timeformat.format(DateTime.now());
    print('formattedTime = $time');
    String date = dateFormat.format(DateTime.now());
    print('date--->$date');
    final response = await classScheduleRepository.findByDateAndClassBooked(
        'BOOKED', date, time, context);
    if (response != null) {
      ClassScheduleList classScheduleList = ClassScheduleList.fromMap(response);
      return classScheduleList.classSchedulelMap;
    }
    return null;
  }

  Future<Object> cancelClass(
      ClassSchedule classSchedule, BuildContext context) async {
    final response =
        await classScheduleRepository.cancelClass(classSchedule, context);
    print(response);
    if (response != null) {
      ConstantWidgets.showMaterialDialog(
          context, 'Successfully Cancelled your class', 'Class Cancelled!!');
    }
    return response;
  }

  Future<Object> deleteSchedule(BuildContext context, int id) async {
    return await classScheduleRepository.deleteSchedule(context, id);
  }

  bool isEnabled(String date, String time) {
    bool isEnabled = true;
    //String date = classScheduleList[index].date;
    //print('========================');
    print('DATE===> $date');
    DateTime dbDate = FitnessConstant.dateFormat.parse(date);
    if (dbDate.isAtSameMomentAs(
        FitnessConstant.df.parse(FitnessConstant.df.format(DateTime.now())))) {
      //String time = classScheduleList[index].time;
      DateTime dbTime = FitnessConstant.dfz.parse(time);
      DateTime now =
          FitnessConstant.dfz.parse(FitnessConstant.dfz.format(DateTime.now()));
      if (dbTime.isBefore(now)) {
        isEnabled = false;
      }
    }
    return isEnabled;
  }

  Future<Object> checkClassBookedForSpecificUser(
      BuildContext context, ClassSchedule classSchedule) async {
    return await classScheduleRepository.checkClassBookedForSpecificUser(
        context, classSchedule);
  }
}
