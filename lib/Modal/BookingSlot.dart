import 'dart:convert';
import 'ClassSchedule.dart';
import 'User.dart';

class BookingSlot {
  int id;
  User user;
  ClassSchedule classSchedule;
  String classStatus;
  BookingSlot({
    this.id,
    this.user,
    this.classSchedule,
    this.classStatus,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user': user.toMap(),
      'classScheduleRequest': classSchedule.toMap(),
      'classStatus': classStatus,
    };
  }

  factory BookingSlot.fromMap(Map<String, dynamic> map) {
    return BookingSlot(
      id: map['id'],
      user: User.fromMap(map['user']),
      classSchedule: ClassSchedule.fromMap(map['classSchedule']),
      classStatus: map['classStatus'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BookingSlot.fromJson(String source) =>
      BookingSlot.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BookingSlot(id: $id, user: $user, classSchedule: $classSchedule, classStatus: $classStatus)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BookingSlot &&
        other.id == id &&
        other.user == user &&
        other.classSchedule == classSchedule &&
        other.classStatus == classStatus;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        user.hashCode ^
        classSchedule.hashCode ^
        classStatus.hashCode;
  }
}
