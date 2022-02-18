class JwtResponse {
  String token;
  String type;
  int id;
  String username;
  List<dynamic> roles;

  JwtResponse(
    this.id,
    this.roles,
    this.token,
    this.type,
    this.username,
  );

  factory JwtResponse.fromMap(Map<String, dynamic> json) {
    return JwtResponse(
      json['id'],
      json['roles'],
      json['accessToken'],
      json['type'],
      json['username'],
    );
  }
}
