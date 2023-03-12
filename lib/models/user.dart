// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.id,
    required this.fullName,
    required this.email,
  });

  int id;
  String fullName;
  String email;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        fullName: json["fullName"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullName": fullName,
        "email": email,
      };
}
