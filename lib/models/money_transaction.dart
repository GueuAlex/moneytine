// To parse this JSON data, do
//
//     final moneyTransaction = moneyTransactionFromJson(jsonString);

import 'dart:convert';

import 'package:moneytine/models/user.dart';

import 'tontine.dart';

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
    required this.id,
    required this.type,
    required this.amunt,
    required this.hours,
    required this.transactionDate,
    required this.user,
    required this.groupe,
  });

  int id;
  String type;
  double amunt;
  String hours;
  DateTime transactionDate;
  User user;
  Groupe groupe;

  factory MoneyTransaction.fromJson(Map<String, dynamic> json) =>
      MoneyTransaction(
        id: json["id"],
        type: json["type"],
        amunt: json["amunt"]?.toDouble(),
        hours: json["hours"],
        transactionDate: DateTime.parse(json["transactionDate"]),
        user: User.fromJson(json["user"]),
        groupe: Groupe.fromJson(json["groupe"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "amunt": amunt,
        "hours": hours,
        "transactionDate": transactionDate.toIso8601String(),
        "user": user.toJson(),
        "groupe": groupe.toJson(),
      };
}
