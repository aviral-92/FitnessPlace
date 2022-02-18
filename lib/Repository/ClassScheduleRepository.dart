import 'dart:convert';

import 'package:FitnessPlace/Constant/FitnessConstant.dart';
import 'package:FitnessPlace/Modal/BookingSlot.dart';
import 'package:FitnessPlace/Modal/ClassSchedule.dart';
import 'package:FitnessPlace/Modal/User.dart';
import 'package:FitnessPlace/Networking/ApiBaseHelper.dart';
import 'package:flutter/material.dart';

class ClassScheduleRepository {
  ApiBaseHelper _helper = ApiBaseHelper();
  //static String basePath = 'http://localhost:8080';

  Future<ClassSchedule> addClassSchedule(
      ClassSchedule classSchedule, BuildContext context) async {
    final response = await _helper.post(
        '${FitnessConstant.BASE_PATH}/class_schedule/',
        json.encode(classSchedule.toMap()),
        true,
        context);
    print(response);
    if (response == null) return null;
    return ClassSchedule.fromMap(response);
  }

  Future<Object> findByDateWithProfile(
      String date, int profileId, BuildContext context) async {
    final response = await _helper.get(
        '${FitnessConstant.BASE_PATH}/class_schedule/findByDateWithProfile?date=$date&profileId=$profileId',
        context);
    print(response);
    if (response == null) return null;
    return response;
  }

  Future<Object> findByDate(String date, BuildContext context) async {
    final response = await _helper.get(
        '${FitnessConstant.BASE_PATH}/class_schedule/findByDate?date=$date',
        context);
    print(response);
    if (response == null) return null;
    return response;
  }

  Future<Object> bookClass(
      BuildContext context, ClassSchedule classSchedule) async {
    String username = await _helper.getTokenOrUsername('username');
    User user = new User();
    user.username = username;
    BookingSlot bookingSlot = new BookingSlot();
    bookingSlot.classSchedule = classSchedule;
    bookingSlot.user = user;
    final response = await _helper.post(
        '${FitnessConstant.BASE_PATH}/booking_slot/',
        json.encode(bookingSlot.toMap()),
        true,
        context);
    print(response);
    if (response == null) return null;
    return response;
  }

  Future<Object> findClassScheduleFromBookingSlot(
      String status, String date, BuildContext context) async {
    String username = await _helper.getTokenOrUsername('username');
    final response = await _helper.get(
        '${FitnessConstant.BASE_PATH}/class_schedule/findClassScheduleFromBookingSlot?username=$username&status=$status&date=$date',
        context);
    print(response);
    if (response == null) return null;
    return response;
  }

  Future<Object> findByDateAndClassBooked(
      String status, String date, BuildContext context) async {
    String username = await _helper.getTokenOrUsername('username');
    final response = await _helper.get(
        '${FitnessConstant.BASE_PATH}/class_schedule/findByDateAndClassBooked?username=$username&status=$status&date=$date',
        context);
    //print(response);
    if (response == null) return null;
    return response;
  }

  Future<Object> cancelClass(
      ClassSchedule classSchedule, BuildContext context) async {
    String username = await _helper.getTokenOrUsername('username');
    User user = new User();
    user.username = username;
    BookingSlot bookingSlot = new BookingSlot();
    bookingSlot.user = user;
    bookingSlot.classSchedule = classSchedule;
    final response = await _helper.post(
        '${FitnessConstant.BASE_PATH}/booking_slot/cancelClass',
        json.encode(bookingSlot.toMap()),
        true,
        context);
    print(response);
    if (response == null) return null;
    return response;
  }

  Future<List<Object>> findAllTrainersByRole(BuildContext context) async {
    final response = await _helper.get(
        '${FitnessConstant.BASE_PATH}/api/auth/getAllByRole?role=ROLE_TRAINER',
        context);
    print(response);
    if (response == null) return null;
    return response;
  }

  void logout(BuildContext context) {
    _helper.logout(context);
  }
}
