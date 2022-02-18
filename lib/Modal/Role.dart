import 'dart:convert';

class Role {
  int id;
  String role;
  bool status;

  Role({
    this.id,
    this.role,
    this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'role': role,
      'status': status,
    };
  }

  factory Role.fromMap(Map<String, dynamic> map) {
    return Role(
      id: map['id'],
      role: map['role'],
      status: map['status'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Role.fromJson(String source) => Role.fromMap(json.decode(source));

  @override
  String toString() => 'Role(id: $id, role: $role, status: $status)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Role && other.id == id && other.role == role;
  }

  @override
  int get hashCode => id.hashCode ^ role.hashCode;
}
