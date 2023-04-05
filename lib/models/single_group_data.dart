// To parse this JSON data, do
//
//     final singleGroupData = singleGroupDataFromJson(jsonString);

import 'dart:convert';

List<SingleGroupData> singleGroupDataFromJson(String str) =>
    List<SingleGroupData>.from(
        json.decode(str).map((x) => SingleGroupData.fromJson(x)));

String singleGroupDataToJson(List<SingleGroupData> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SingleGroupData {
  SingleGroupData({
    required this.id,
    required this.name,
    required this.email,
    required this.part,
    required this.transactions,
  });

  int id;
  String name;
  String email;
  double part;
  List<dynamic> transactions;

  factory SingleGroupData.fromJson(Map<String, dynamic> json) =>
      SingleGroupData(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        part: json["part"].toDouble(),
        transactions: List<dynamic>.from(json["transactions"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "part": part,
        "transactions": List<dynamic>.from(transactions.map((x) => x)),
      };
}
