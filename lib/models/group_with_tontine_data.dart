// To parse this JSON data, do
//
//     final groupWithTontineData = groupWithTontineDataFromJson(jsonString);

import 'dart:convert';

List<GroupWithTontineData> groupWithTontineDataFromJson(String str) =>
    List<GroupWithTontineData>.from(
        json.decode(str).map((x) => GroupWithTontineData.fromJson(x)));

String groupWithTontineDataToJson(List<GroupWithTontineData> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GroupWithTontineData {
  int id;
  String groupName;
  List<int> memberIds;
  TontineData tontineData;

  GroupWithTontineData({
    required this.id,
    required this.groupName,
    required this.memberIds,
    required this.tontineData,
  });

  factory GroupWithTontineData.fromJson(Map<String, dynamic> json) =>
      GroupWithTontineData(
        id: json["id"],
        groupName: json["groupName"],
        memberIds: List<int>.from(json["memberIds"].map((x) => x)),
        tontineData: TontineData.fromJson(json["tontine"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "groupName": groupName,
        "memberIds": List<dynamic>.from(memberIds.map((x) => x)),
        "tontine_data": tontineData.toJson(),
      };
}

class TontineData {
  int id;
  String name;
  int isActive;

  TontineData({
    required this.id,
    required this.name,
    required this.isActive,
  });

  factory TontineData.fromJson(Map<String, dynamic> json) => TontineData(
        id: json["id"],
        name: json["name"],
        isActive: json["is_active"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "is_active": isActive,
      };
}
