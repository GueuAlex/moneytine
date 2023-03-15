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
}
