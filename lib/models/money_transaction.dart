// To parse this JSON data, do
//
//     final moneyTransaction = moneyTransactionFromJson(jsonString);

import 'dart:convert';

//////////////////////////////// single //////////////////////////////////////
///
///

MoneyTransaction moneyTransactionFromJson(String str) =>
    MoneyTransaction.fromJson(json.decode(str));

String moneyTransactionToJson(MoneyTransaction data) =>
    json.encode(data.toJson());

////////////////////////////////: liste /////////////////////////////////////
///
List<MoneyTransaction> moneyTransactionListFromJson(String str) =>
    List<MoneyTransaction>.from(
        json.decode(str).map((x) => MoneyTransaction.fromJson(x)));

String moneyTransactionListToJson(List<MoneyTransaction> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MoneyTransaction {
  MoneyTransaction({
    this.id,
    required this.type,
    required this.amunt,
    required this.hours,
    required this.date,
    required this.userId,
    required this.groupeId,
    required this.tontineId,
    required this.tontineCreatorId,
  });

  int? id;
  String type;
  double amunt;
  String hours;
  DateTime date;
  int userId;
  int groupeId;
  int tontineId;
  int tontineCreatorId;

  factory MoneyTransaction.fromJson(Map<String, dynamic> json) =>
      MoneyTransaction(
        id: json["id"],
        type: json["type"],
        amunt: json["amount"]?.toDouble(),
        hours: json["time"],
        date: DateTime.parse(json["date"]),
        userId: json["user_id"],
        groupeId: json["group_id"],
        tontineId: json["tontine_id"],
        tontineCreatorId: json["tontine_creator_id"],
      );

  Map<String, dynamic> toJson() => {
        //"id": id,
        "type": type,
        "amount": amunt,
        "time": hours,
        "date": date.toIso8601String(),
        "user_id": userId,
        "group_id": groupeId,
        "tontine_id": tontineId,
        "tontine_creator_id": tontineCreatorId,
      };
}
