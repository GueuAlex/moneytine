// To parse this JSON data, do
//
//     final status = statusFromJson(jsonString);

import 'dart:convert';

import 'user.dart';

TontineMembersStatus statusFromJson(String str) =>
    TontineMembersStatus.fromJson(json.decode(str));

String statusToJson(TontineMembersStatus data) => json.encode(data.toJson());

class TontineMembersStatus {
  List<MyUser> update;
  List<MyUser> outdated;

  TontineMembersStatus({
    required this.update,
    required this.outdated,
  });

  factory TontineMembersStatus.fromJson(Map<String, dynamic> json) =>
      TontineMembersStatus(
        update:
            List<MyUser>.from(json["update"].map((x) => MyUser.fromJson(x))),
        outdated:
            List<MyUser>.from(json["outdated"].map((x) => MyUser.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "update": List<dynamic>.from(update.map((x) => x.toJson())),
        "outdated": List<dynamic>.from(outdated.map((x) => x.toJson())),
      };
}
