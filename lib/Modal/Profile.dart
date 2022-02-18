import 'dart:convert';

class Profile {
  int id;
  String name;
  String mobile;
  String dob;
  String speciality;
  String gender;
  String picturePath;
  bool status;
  Profile({
    this.id,
    this.name,
    this.mobile,
    this.dob,
    this.speciality,
    this.gender,
    this.picturePath,
    this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'mobile': mobile,
      'dob': dob,
      'speciality': speciality,
      'gender': gender,
      'picturePath': picturePath,
      'status': status,
    };
  }

  factory Profile.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    return Profile(
      id: map['id'],
      name: map['name'],
      mobile: map['mobile'],
      dob: map['dob'],
      speciality: map['speciality'],
      gender: map['gender'],
      picturePath: map['picturePath'],
      status: map['status'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Profile.fromJson(String source) =>
      Profile.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Profile(id: $id, name: $name, mobile: $mobile, dob: $dob, speciality: $speciality, gender: $gender, picturePath: $picturePath, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Profile &&
        other.id == id &&
        other.name == name &&
        other.mobile == mobile &&
        other.dob == dob &&
        other.speciality == speciality &&
        other.gender == gender &&
        other.picturePath == picturePath &&
        other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        mobile.hashCode ^
        dob.hashCode ^
        speciality.hashCode ^
        gender.hashCode ^
        picturePath.hashCode ^
        status.hashCode;
  }
}
