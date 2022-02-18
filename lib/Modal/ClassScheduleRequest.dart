import 'dart:convert';

import 'Profile.dart';

class ClassScheduleRequest {
  int id;
  String date;
  String time;
  String duration;
  String workoutType;
  Profile profile;
  int capacity;
  int slotOccupied;
  bool status;
  ClassScheduleRequest({
    this.id,
    this.date,
    this.time,
    this.duration,
    this.workoutType,
    this.profile,
    this.capacity,
    this.slotOccupied,
    this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'time': time,
      'duration': duration,
      'workoutType': workoutType,
      'profile': profile.toMap(),
      'capacity': capacity,
      'slotOccupied': slotOccupied,
      'status': status,
    };
  }

  factory ClassScheduleRequest.fromMap(Map<String, dynamic> map) {
    return ClassScheduleRequest(
      id: map['id'],
      date: map['date'],
      time: map['time'],
      duration: map['duration'],
      workoutType: map['workoutType'],
      profile: Profile.fromMap(map['profile']),
      capacity: map['capacity'],
      slotOccupied: map['slotOccupied'],
      status: map['status'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ClassScheduleRequest.fromJson(String source) =>
      ClassScheduleRequest.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ClassScheduleRequest(id: $id, date: $date, time: $time, duration: $duration, workoutType: $workoutType, profile: $profile, capacity: $capacity, slotOccupied: $slotOccupied, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ClassScheduleRequest &&
        other.id == id &&
        other.date == date &&
        other.time == time &&
        other.duration == duration &&
        other.workoutType == workoutType &&
        other.profile == profile &&
        other.capacity == capacity &&
        other.slotOccupied == slotOccupied &&
        other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        date.hashCode ^
        time.hashCode ^
        duration.hashCode ^
        workoutType.hashCode ^
        profile.hashCode ^
        capacity.hashCode ^
        slotOccupied.hashCode ^
        status.hashCode;
  }
}
