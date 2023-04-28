// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

List<NotificationModel> notificationModelFromJson(String str) =>
    List<NotificationModel>.from(
        json.decode(str).map((x) => NotificationModel.fromJson(x)));

String notificationModelToJson(List<NotificationModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
///////
///single
String singleNotificationModelToJson(NotificationModel data) =>
    json.encode(data.toJson());

class NotificationModel {
  NotificationModel({
    this.id,
    required this.type,
    required this.recipientId,
    this.tontineId,
    this.tontineName,
    required this.amount,
    required this.hour,
    required this.date,
  });

  int? id;
  String type;
  int recipientId;
  int? tontineId;
  String? tontineName;
  double amount;
  String hour;
  DateTime date;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        id: json["id"],
        type: json["type"],
        recipientId: json["recipient_id"],
        //tontineId: json["tontine_id"],
        tontineName: json["tontine_name"],
        amount: json["amount"].toDouble(),
        hour: json["hour"],
        date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "recipient_id": recipientId,
        "tontine_id": tontineId,
        "amount": amount,
        "hour": hour,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
      };
}
