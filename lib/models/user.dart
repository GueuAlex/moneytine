// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

MyUser userFromJson(String str) => MyUser.fromJson(json.decode(str));

String userToJson(MyUser data) => json.encode(data.toJson());

///////////////////// user list ///////////////////////////////////////////
///
List<MyUser> userListFromJson(String str) =>
    List<MyUser>.from(json.decode(str).map((x) => MyUser.fromJson(x)));

String userListToJson(List<MyUser> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MyUser {
  MyUser({
    this.id,
    required this.fullName,
    required this.email,
    this.password,
    this.gender,
    this.birthDate,
    this.uid,
  });

  int? id;
  String fullName;
  String email;
  String? password;
  String? gender;
  DateTime? birthDate;
  String? uid;

  factory MyUser.fromJson(Map<String, dynamic> json) => MyUser(
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
        "uid": uid,
      };
}

List<MyUser> creatorList = [];

List<MyUser> groupMembres = [
  MyUser(fullName: 'Johon Doe', email: 'johondoe@gmail.com'),
  MyUser(fullName: 'Johon Doe', email: 'johondoe@gmail.com'),
  MyUser(fullName: 'Johon Doe', email: 'johondoe@gmail.com'),
  MyUser(fullName: 'Johon Doe', email: 'johondoe@gmail.com'),
  MyUser(fullName: 'Johon Doe', email: 'johondoe@gmail.com'),
];
