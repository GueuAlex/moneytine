// To parse this JSON data, do
//
//     final paiment = paimentFromJson(jsonString);

import 'dart:convert';

import 'package:moneytine/models/tontine.dart';
import 'package:moneytine/models/user.dart';

Paiment paimentFromJson(String str) => Paiment.fromJson(json.decode(str));

String paimentToJson(Paiment data) => json.encode(data.toJson());

class Paiment {
  Paiment({
    required this.id,
    required this.note,
    required this.amount,
    required this.date,
    required this.heure,
    required this.user,
    required this.tontine,
    required this.goupe,
  });

  int id;
  String note;
  double amount;
  DateTime date;
  String heure;
  User user;
  Tontine tontine;
  Groupe goupe;

  factory Paiment.fromJson(Map<String, dynamic> json) => Paiment(
        id: json["id"],
        note: json["note"],
        amount: json["amount"]?.toDouble(),
        date: DateTime.parse(json["date"]),
        heure: json["heure"],
        user: User.fromJson(json["user"]),
        tontine: Tontine.fromJson(json["Tontine"]),
        goupe: Groupe.fromJson(json["goupe"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "note": note,
        "amount": amount,
        "date": date.toIso8601String(),
        "heure": heure,
        "user": user.toJson(),
        "Tontine": tontine.toJson(),
        "goupe": goupe.toJson(),
      };
}
