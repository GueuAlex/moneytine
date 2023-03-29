// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.id,
    required this.fullName,
    required this.email,
    this.password,
    this.gender,
    this.birthDate,
  });

  int? id;
  String fullName;
  String email;
  String? password;
  String? gender;
  DateTime? birthDate;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        fullName: json["name"],
        email: json["email"],
        password: json["password"],
        gender: json["gender"],
        // birthDate: DateTime.parse(json["birthDate"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": fullName,
        "email": email,
        "password": password,
        "gender": gender,
        "birthDate": birthDate?.toIso8601String(),
      };
}

List<User> creatorList = [];

List<User> groupMembres = [
  User(fullName: 'Johon Doe', email: 'johondoe@gmail.com'),
  User(fullName: 'Johon Doe', email: 'johondoe@gmail.com'),
  User(fullName: 'Johon Doe', email: 'johondoe@gmail.com'),
  User(fullName: 'Johon Doe', email: 'johondoe@gmail.com'),
  User(fullName: 'Johon Doe', email: 'johondoe@gmail.com'),
];
