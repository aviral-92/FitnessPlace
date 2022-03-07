import 'dart:convert';

import 'Profile.dart';

class ClassSchedule {
  int id;
  String date;
  String time;
  String duration;
  String workoutType;
  Profile profile;
  int capacity;
  int slotOccupied;
  bool status;
  bool scheduleStatus;
  String classStatus;
  ClassSchedule({
    this.id,
    this.date,
    this.duration,
    this.time,
    this.workoutType,
    this.profile,
    this.capacity,
    this.slotOccupied,
    this.status,
    this.classStatus,
    this.scheduleStatus,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'duration': duration,
      'time': time,
      'workoutType': workoutType,
      'profile': profile != null ? profile.toMap() : null,
      'capacity': capacity,
      'slotOccupied': slotOccupied,
      'status': status,
      'classStatus': classStatus,
      'scheduleStatus': scheduleStatus,
    };
  }

  factory ClassSchedule.fromMap(Map<String, dynamic> map) {
    return ClassSchedule(
      id: map['id'],
      date: map['date'],
      duration: map['duration'],
      time: map['time'],
      workoutType: map['workoutType'],
      profile: Profile.fromMap(map['profile']),
      capacity: map['capacity'],
      slotOccupied: map['slotOccupied'],
      status: map['status'],
      classStatus: map['classStatus'],
      scheduleStatus: map['scheduleStatus'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ClassSchedule.fromJson(String source) =>
      ClassSchedule.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ClassSchedule(id: $id, date: $date, time: $time, workoutType: $workoutType, profile: $profile, capacity: $capacity, slotOccupied: $slotOccupied, status: $status, classStatus: $classStatus)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ClassSchedule &&
        other.id == id &&
        other.date == date &&
        other.time == time &&
        other.workoutType == workoutType &&
        other.profile == profile &&
        other.capacity == capacity &&
        other.slotOccupied == slotOccupied &&
        other.status == status &&
        other.classStatus == classStatus;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        date.hashCode ^
        time.hashCode ^
        workoutType.hashCode ^
        profile.hashCode ^
        capacity.hashCode ^
        slotOccupied.hashCode ^
        status.hashCode ^
        classStatus.hashCode;
  }
}
