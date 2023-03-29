import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moneytine/models/user.dart';

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

  static Future<dynamic> postUser(User? user) async {
    var response =
        await RemoteServices().postUserDetails(api: 'users', user: user!);

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
}
