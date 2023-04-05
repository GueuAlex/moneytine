// To parse this JSON data, do
//
//     final tontine = tontineFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Tontine tontineFromJson(String str) => Tontine.fromJson(json.decode(str));

String tontineToJson(Tontine data) => json.encode(data.toJson());

List<Tontine> listTontineFromJson(String str) =>
    List<Tontine>.from(json.decode(str).map((x) => Tontine.fromJson(x)));

String listTontineToJson(List<Tontine> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Tontine {
  Tontine({
    required this.id,
    required this.uniqueCode,
    required this.tontineName,
    required this.type,
    required this.numberOfType,
    required this.contribution,
    required this.startDate,
    required this.firstPaiemntDate,
    required this.creatorId,
    this.membersId = const [],
    this.groupes = const [],
    this.isActive = 1,
  });

  int id;
  int uniqueCode;
  String tontineName;
  String type;
  int numberOfType;
  double contribution;
  DateTime startDate;
  DateTime firstPaiemntDate;
  int creatorId;
  List<int> membersId;
  List<Groupe> groupes;
  int isActive;

  factory Tontine.fromJson(Map<String, dynamic> json) => Tontine(
        id: json["id"],
        uniqueCode: int.parse(json["uniqueCode"]),
        tontineName: json["tontineName"],
        type: json["type"],
        numberOfType: int.parse(json["numberOfType"]),
        contribution: json["contribution"]?.toDouble(),
        startDate: DateTime.parse(json["startDate"]),
        firstPaiemntDate: DateTime.parse(json["firstPaymentDate"]),
        creatorId: json["creatorId"],
        isActive: json["is_active"],
        membersId: List<int>.from(json["membersId"].map((x) => x)),
        groupes:
            List<Groupe>.from(json["groups"].map((x) => Groupe.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "unique_code": uniqueCode,
        "name": tontineName,
        "contribution_type": type,
        "duration": numberOfType,
        "amount": contribution,
        "start_date": startDate.toIso8601String(),
        "first_payment_deadline": firstPaiemntDate.toIso8601String(),
        "user_id": creatorId,
        "is_active": isActive,
        "membersId": List<dynamic>.from(membersId.map((x) => x)),
        "groupes": List<dynamic>.from(groupes.map((x) => x.toJson())),
      };
}

class Groupe {
  Groupe({
    this.id = 0,
    required this.nom,
    this.membrsId = const [],
    //required this.cretat,
  });

  int id;
  String nom;
  List<int> membrsId;
  //DateTime cretat;

  static List<Color> colorList = [
    const Color.fromARGB(255, 92, 174, 117),
    const Color.fromARGB(255, 77, 67, 130),
    const Color.fromARGB(255, 44, 157, 153),
    const Color.fromARGB(255, 77, 67, 130),
    const Color.fromARGB(255, 42, 88, 103),
    const Color.fromARGB(255, 162, 26, 16),
    const Color.fromARGB(255, 14, 92, 138),
    const Color.fromARGB(255, 77, 67, 130),
    const Color.fromARGB(255, 203, 30, 154),
  ];

  factory Groupe.fromJson(Map<String, dynamic> json) => Groupe(
        id: json["id"],
        nom: json["groupName"],
        membrsId: List<int>.from(json["memberIds"].map((x) => x)),
        //cretat: DateTime.parse(json["cretat"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nom": nom,
        "membrsId": List<dynamic>.from(membrsId.map((x) => x)),
        //"cretat": cretat.toIso8601String(),
      };
}

List<Tontine> tontineList = [
  Tontine(
    id: 1,
    uniqueCode: 234565,
    tontineName: 'Super mega tontine',
    type: 'Mensuel',
    numberOfType: 8,
    contribution: 170000,
    startDate: DateTime.now().add(const Duration(days: 30)),
    firstPaiemntDate: DateTime.now(),
    creatorId: 1,
    membersId: [
      1,
      44,
      7,
    ],
    groupes: [
      Groupe(
        id: 1,
        nom: 'Groupe_1',
        membrsId: [1, 2, 3],
        //cretat: DateTime.now(),
      ),
      Groupe(
        id: 2,
        nom: 'Groupe_2',
        membrsId: [1],
        //cretat: DateTime.now(),
      ),
      Groupe(
        id: 3,
        nom: 'Groupe_3',
        membrsId: [1, 2],
        //cretat: DateTime.now(),
      ),
      Groupe(
        id: 4,
        nom: 'Groupe_4',
        membrsId: [1, 2, 3],
        //cretat: DateTime.now(),
      )
    ],
  ),
  Tontine(
    id: 1,
    uniqueCode: 234565,
    tontineName: 'La tontine',
    type: 'Mensuel',
    numberOfType: 8,
    contribution: 1500000,
    startDate: DateTime.now().add(const Duration(days: 30)),
    firstPaiemntDate: DateTime.now(),
    creatorId: 1,
    membersId: [
      1,
      11,
      4,
      66,
      77,
      89,
      75,
    ],
    groupes: [
      Groupe(
        id: 5,
        nom: 'Groupe_1',
        membrsId: [1, 2, 3, 5],
        //cretat: DateTime.now(),
      )
    ],
  ),
  Tontine(
    id: 1,
    uniqueCode: 234565,
    tontineName: 'super tontine',
    type: 'Mensuel',
    numberOfType: 8,
    contribution: 550000,
    startDate: DateTime.now().add(const Duration(days: 30)),
    firstPaiemntDate: DateTime.now(),
    creatorId: 1,
    membersId: [
      1,
      7,
      9,
      8,
      88,
      4,
      1,
    ],
    groupes: [],
  ),
  Tontine(
    id: 1,
    uniqueCode: 234565,
    tontineName: 'Jolie tontine',
    type: 'Mensuel',
    numberOfType: 8,
    contribution: 5000,
    startDate: DateTime.now().add(const Duration(days: 30)),
    firstPaiemntDate: DateTime.now(),
    creatorId: 1,
    membersId: [1, 5, 7, 3, 7, 90, 1],
    groupes: [],
  ),
  Tontine(
    id: 1,
    uniqueCode: 234565,
    tontineName: 'Ok tontine',
    type: 'Mensuel',
    numberOfType: 8,
    contribution: 20000,
    startDate: DateTime.now().add(const Duration(days: 30)),
    firstPaiemntDate: DateTime.now(),
    creatorId: 1,
    membersId: [1, 9, 12, 5],
    groupes: [],
  ),
  Tontine(
    id: 1,
    uniqueCode: 234565,
    tontineName: 'super tontine',
    type: 'Mensuel',
    numberOfType: 8,
    contribution: 10000,
    startDate: DateTime.now().add(const Duration(days: 30)),
    firstPaiemntDate: DateTime.now(),
    creatorId: 1,
    membersId: [
      1,
      7,
      6,
    ],
    groupes: [],
  ),
  Tontine(
    id: 1,
    uniqueCode: 234565,
    tontineName: 'super tontine',
    type: 'Mensuel',
    numberOfType: 8,
    contribution: 60000,
    startDate: DateTime.now().add(const Duration(days: 30)),
    firstPaiemntDate: DateTime.now(),
    creatorId: 1,
    membersId: [
      1,
      4,
      2,
    ],
    groupes: [],
  ),
];

List<Tontine> currentUSerTontineList = [];
List<Tontine> allTontineWhereCurrentUserParticipe = [];
