import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/money_transaction.dart';
import '../models/user.dart';
import '../remote_services/remote_services.dart';

class Functions {
  static Future<int> postEmail(
      {required String api, required String email}) async {
    var response = await RemoteServices().postEmail(api: api, email: email);
    if (response != null) {
      int code = int.parse(response);
      //print(' result : $code');
      return code;
    }
    return 0;
  }

  static Future<dynamic> postUser(
      {required MyUser? user, bool isSingin = true}) async {
    var response = await RemoteServices().postUserDetails(
      api: isSingin ? 'users' : 'users/create_by_admin',
      user: user!,
    );

    return response;
  }

  static Future<dynamic> resetPassword(
      {required String email, required String password}) async {
    var response = await RemoteServices().postEmailPassword(
      api: 'users/update/password',
      email: email,
      password: password,
    );
    if (response != null) {
      return response;
    } else {
      return null;
    }
    //return response;
  }

  static Future<dynamic> postLoginDetails(
      {required String email, required String password}) async {
    var response = await RemoteServices().postEmailPassword(
      api: 'users/login',
      email: email,
      password: password,
    );
    if (response != null) {
      return response;
    } else {
      return null;
    }
    //return response;
  }

  //////////////////////////// permet de copier une chaine de carrecter dans le press-papier///////
  ///
  static void copyToClipboard({required String text}) async {
    await Clipboard.setData(ClipboardData(text: text));
  }

  static Future<String> joinResponse(
      {required String code, required String userId}) async {
    var tontineId = await RemoteServices().postJoinCode(
      api: 'tontines/membership',
      code: code,
      userID: userId,
    );

    if (tontineId != null) {
      return tontineId.toString();
    } else {
      return 'err';
    }
  }

  static showLoadingSheet({required BuildContext ctxt}) {
    return showModalBottomSheet(
        context: ctxt,
        backgroundColor: Colors.transparent,
        builder: (ctxt) {
          return Container(
            width: double.infinity,
            height: MediaQuery.of(ctxt).size.height,
            color: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(30.0),
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Image.asset('assets/icons/loading.gif'),
                ),
                const SizedBox(
                  height: 230,
                )
              ],
            ),
          );
        });
  }

  static bool isAdmin({required int creatorId, required int currentUserId}) {
    if (creatorId == currentUserId) {
      return true;
    } else {
      return false;
    }
  }

  /* static String numberFormat({ required double number}){
    final formatter = NumberFormat('#,##0');
  
  formatter.symbols = SymbolSet(
    decimalSeparator: ',',
    groupSeparator: ' ',
  );
  final formattedNumber = formatter.format(number);
  } */

  /* static String numberFormat(String numberString) {
    //final number = int.tryParse(numberString.replaceAll(RegExp(r'\D'), ''));
    final number = int.parse(numberString);
    if (number != null) {
      final formatter = NumberFormat('#,###');
      return formatter.format(number);
    }
    return numberString;
  } */

  static String generatePassword() {
    // Liste des caractères possibles pour chaque type de caractère
    final letters = 'abcdefghijklmnopqrstuvwxyz';
    final numbers = '0123456789';
    final uppercaseLetters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    final specialCharacters = '@\$!%*?&';

    // Générer un caractère aléatoire pour chaque type de caractère
    final random = Random();
    final letter = letters[random.nextInt(letters.length)];
    final number = numbers[random.nextInt(numbers.length)];
    final uppercaseLetter =
        uppercaseLetters[random.nextInt(uppercaseLetters.length)];
    final specialCharacter =
        specialCharacters[random.nextInt(specialCharacters.length)];

    // Concaténer les caractères aléatoires pour former le mot de passe
    String password = '$letter$number$uppercaseLetter$specialCharacter';

    // Générer des caractères aléatoires supplémentaires pour atteindre une longueur de 8 caractères
    while (password.length < 8) {
      final type = random.nextInt(4);
      switch (type) {
        case 0:
          password += letters[random.nextInt(letters.length)];
          break;
        case 1:
          password += numbers[random.nextInt(numbers.length)];
          break;
        case 2:
          password += uppercaseLetters[random.nextInt(uppercaseLetters.length)];
          break;
        case 3:
          password +=
              specialCharacters[random.nextInt(specialCharacters.length)];
          break;
      }
    }

    return password;
  }

  static String nameFormater(
      {required String fullName, required bool isFirstname}) {
    List<String> parts = fullName.split(' ');
    String firstName = parts[0];
    String lastName = parts.sublist(1).join(' ');
    if (isFirstname) {
      return firstName;
    } else {
      return lastName;
    }
  }

  static postDetailToFiresotre(
      {required String email,
      required String fullName,
      required String password,
      required}) async {
    //calling our firestore
    //calling our UserModel
    //sending these values
    final _auth = FirebaseAuth.instance;
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    MyUser userModel = MyUser(
        fullName: fullName, email: email, password: password, uid: user!.uid);

    //wrtting all the values

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toJson());
  }

  static Future<List<MoneyTransaction>> getThisUSerTransactionsListByGroupId(
      {required int groupId, required int userId}) async {
    final List<MoneyTransaction> thisUserTransactionList = [];
    List<MoneyTransaction> allTransactions =
        await RemoteServices().getTransactionsList();

    if (allTransactions.isNotEmpty) {
      // _allTransactions.clear();
      for (MoneyTransaction element in allTransactions) {
        if (element.userId == userId && element.groupeId == groupId) {
          thisUserTransactionList.add(element);
        }
      }
      return thisUserTransactionList;

      // Créer une liste de TransactionsByDate à partir de la liste triée
    }
    return [];
  }

  static Future<bool> postTransatcionDetails(
      {required MoneyTransaction moneyTransaction}) async {
    var response = await RemoteServices().postNewTransaction(
        api: 'transactions', mtransaction: moneyTransaction);

    if (response != null) {
      return true;
    }
    return false;
  }

  static DateTime calculerDateFin(
      {required DateTime dateDebut, required int nombreMois}) {
    // Ajouter le nombre de mois à la date de début
    DateTime dateFin = dateDebut.add(Duration(days: (30 * nombreMois)));
    //dateDebut.add(duration)

    // Vérifier si la date de fin est valide
    if (dateFin.month > (dateDebut.month + nombreMois) % 12) {
      dateFin = DateTime(dateDebut.year, dateDebut.month + nombreMois + 1, 0);
    }

    return dateFin;
  }

  static String addSpaceAfterThreeDigits(String input) {
    // Supprimer les espaces de la chaîne
    String stringWithoutSpaces = input.replaceAll(' ', '');

    // Supprimer le ".0" à la fin de la chaîne si présent
    if (stringWithoutSpaces.endsWith('.0')) {
      stringWithoutSpaces =
          stringWithoutSpaces.substring(0, stringWithoutSpaces.length - 2);
    }

    // Ajouter un espace après chaque groupe de 3 chiffres
    StringBuffer result = StringBuffer();
    int digitCount = 0;
    for (int i = stringWithoutSpaces.length - 1; i >= 0; i--) {
      result.write(stringWithoutSpaces[i]);
      digitCount++;
      if (digitCount % 3 == 0 && i != 0) {
        result.write(' ');
      }
    }

    // Inverser la chaîne résultante pour obtenir l'ordre correct
    String reversedResult = result.toString().split('').reversed.join();

    return reversedResult;
  }
}
