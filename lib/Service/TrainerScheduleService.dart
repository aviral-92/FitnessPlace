import 'package:FitnessPlace/Constant/ConstantWidgets.dart';
import 'package:FitnessPlace/Modal/ClassSchedule.dart';
import 'package:FitnessPlace/Provider/ClassScheduleList.dart';
import 'package:FitnessPlace/Repository/ClassScheduleRepository.dart';
import 'package:FitnessPlace/Repository/ProfileRepository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TrainerScheduleService {
  ClassScheduleRepository classScheduleRepository =
      new ClassScheduleRepository();
  ProfileRepository profileRepository = new ProfileRepository();
  Future<ClassSchedule> addClassSchedule(
      String date,
      String time,
      String duration,
      String workoutType,
      int capacity,
      String username,
      BuildContext context) async {
    if (date.isEmpty) {
      ConstantWidgets.showMaterialDialog(
          context, 'Please add date', 'Date Empty!');
      return null;
    }
    ClassSchedule classSchedule = new ClassSchedule();
    final profile =
        await profileRepository.getProfileByUsername(username, context);
    print('Profile ===>>>> $profile');
    classSchedule.date = date;
    classSchedule.time = time;
    classSchedule.duration = duration;
    classSchedule.workoutType = workoutType;
    classSchedule.capacity = capacity;
    classSchedule.profile = profile;

    final response =
        await classScheduleRepository.addClassSchedule(classSchedule, context);
    print('RESPONSE====> $response');
    return response;
  }

  Future<List<ClassSchedule>> findByDateWithProfile(
      BuildContext context) async {
    DateFormat dateFormat = new DateFormat('MMM-dd-yyyy');
    //DateTime now = DateTime.now();
    String date = dateFormat.format(DateTime.now());
    print('=========>>>>>>>>>DATE $date');
    final profile = await profileRepository.getProfileByUsername(null, context);
    final response = await classScheduleRepository.findByDateWithProfile(
        date, profile.id, context);
    print('RESPONSE====>>>>>\n$response');
    ClassScheduleList classScheduleList = ClassScheduleList.fromJson(response);
    return classScheduleList.classSchedulelList;
  }

  Future<Object> findTrainersByRole(BuildContext context) async {
    final response =
        await classScheduleRepository.findAllTrainersByRole(context);
    print('123123123------>>>> $response');
    return response;
  }

  Future<ClassSchedule> updateClassSchedule(
      BuildContext context, ClassSchedule classSchedule) async {
    return await classScheduleRepository.updateClassSchedule(
        context, classSchedule);
  }
}
