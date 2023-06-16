import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

class FirebaseFCM {
  static storeNotificationToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set(
      {"token": token},
      SetOptions(merge: true),
    );
  }

  static Future<bool?> getIsNotif() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return null;
    }

    final documentSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    if (!documentSnapshot.exists) {
      return null;
    }

    final data = documentSnapshot.data()!;
    return data['isNotif'] as bool?;
  }
/////////////////:
  ///
  ///

  static Future<void> updateUserIsNotifField(
      {required String email, required bool isNotif}) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    final QuerySnapshot querySnapshot = await firestore
        .collection('users')
        .where('email', isEqualTo: email)
        .get();

    final DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
    final String documentId = documentSnapshot.id;
    final Map<String, dynamic> data =
        documentSnapshot.data()! as Map<String, dynamic>;

    // Ajoutez un nouveau champ "isNotif" à la carte de données de l'utilisateur spécifié
    data['isNotif'] = isNotif;

    // Mettez à jour le document dans Firestore
    await firestore.collection('users').doc(documentId).update(data);
  }

  static Future<String?> getTokenNotificationByEmail(
      {required String userEmail}) async {
    // Récupérer la référence à la collection "utilisateurs" dans Firestore
    final utilisateursRef = FirebaseFirestore.instance.collection('users');

    // Effectuer une requête pour récupérer le document utilisateur correspondant à l'e-mail spécifié
    final querySnapshot =
        await utilisateursRef.where('email', isEqualTo: userEmail).get();

    if (!querySnapshot.docs.isEmpty) {
      // Si le document est trouvé, récupérer le token de notification à partir du champ "token_notification"
      final userData = querySnapshot.docs[0].data();
      final userToken = userData['token'];

      // Retourner le token de notification
      //print("trouvvvvvvvvvvv");
      //print(userToken);
      return userToken;
    } else {
      // Si le document n'est pas trouvé, renvoyer null
      //print('L\'utilisateur n\'a pas été trouvé dans Firestore');
      return null;
    }
  }

  static sendNotification({
    required String title,
    required String token,
    required String message,
  }) async {
    final data = {
      "click_action": "FLUTTER_NOTIFICATION_CLICK",
      "id": "1",
      "status": "done",
      "message": title,
    };

    var _header = <String, String>{
      'Content-Type': 'application/json',
      'Authorization':
          'key=AAAAjN52YGs:APA91bHmGjtv8VNtVySnqNMYlZsTBDy0GUYOK7CdTe5oD3SH1s6OyzBMvXhonwVHTvUfX38RHgkoZ5rZfAEl8CgI-iuLsBrmpZKqcNHm-3x7Zc_IqGgKmBjCzHlb_k7a7232ycXdrVSZ'
    };

    var body = jsonEncode(<String, dynamic>{
      'notification': <String, dynamic>{'title': title, 'body': message},
      'priority': 'high',
      'data': data,
      'to': '$token',
    });

    try {
      //
      http.Response response = await http.post(
          Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: _header,
          body: body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        // print("It send");
      } else {
        //print("Not send");
      }
    } catch (e) {
      //
    }
  }
}
