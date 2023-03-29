import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:moneytine/models/tontine.dart';
import 'package:moneytine/models/user.dart';

///////////////// base uri//////////////
const baseUri = 'http://194.163.136.227:8087/api/';
///////////////////////////////////////

class RemoteServices {
  //////////////////////////////////
  ///initialisation du client http
  var client = http.Client();
  //////////////////////////////
  ///
  ///////////////// api post base user details//////////////
  ///

  /////////////////////// post user email method //////////////////////
  ///
  Future<dynamic> postEmail(
      {required String api, required String email}) async {
    ////////// parse our url /////////////////////
    var url = Uri.parse(baseUri + api);
    var postEmail = {"email": email};
    ///////////// encode email to json objet/////////
    var payload = jsonEncode(postEmail);
    // http request headers
    var headers = {
      'Content-Type': 'application/json',
    };

    var response = await client.post(url, body: payload, headers: headers);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 201 || response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 422) {
      return '422';
    } else {
      return null;
    }
  }

  ///////////////// post user detail when otp code is verify//////////////////
  ///
  Future<dynamic> postUserDetails(
      {required String api, required User user}) async {
    ////////// parse our url /////////////////////
    var url = Uri.parse(baseUri + api);

    /////////////// encode user to jsn //////////////////////
    var payload = userToJson(user);

    // http request headers
    var headers = {
      'Content-Type': 'application/json',
    };

    //////////////// post user ////////////
    var response = await client.post(url, body: payload, headers: headers);

    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 201 || response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }

  ////////////////////////////////// post reset password details///////////////
  ///
  Future<dynamic> postEmailPassword({
    required String api,
    required String email,
    required String password,
  }) async {
    ////////// parse our url /////////////////////
    var url = Uri.parse(baseUri + api);

    //////////////////////// post objet //////////////////////

    var resetDetails = {"email": email, "password": password};
    /////////////// encode user to jsn //////////////////////
    var payload = jsonEncode(resetDetails);

    // http request headers
    var headers = {
      'Content-Type': 'application/json',
    };

    //////////////// post user ////////////
    var response = await client.post(url, body: payload, headers: headers);

    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 201 || response.statusCode == 200) {
      User logUser = userFromJson(response.body);
      return logUser;
    } else {
      return null;
    }
  }

  //////////////////////////////// get single user by id //////////////////////
  ///
  Future<User?> getSingleUser({required int id}) async {
    var uri = Uri.parse(baseUri + 'users/$id');
    var response = await client.get(uri);
    print('Dans remote : ${response.body}');
    print('Dans remote : ${response.statusCode}');
    if (response.statusCode == 200 || response.statusCode == 200) {
      var json = response.body;
      //print(response.body);
      User user = userFromJson(json);
      return user;
    }
    return null;
  }

  /////////////////////////////////// post new totine /////////////////////
  ///
  ///
  Future<dynamic> postNewTontine(
      {required String api, required Tontine tontine}) async {
    ////////// parse our url /////////////////////
    var url = Uri.parse(baseUri + api);
    //var postEmail = {"email": email};
    ///////////// encode email to json objet/////////
    var payload = tontineToJson(tontine);
    // http request headers
    var headers = {
      'Content-Type': 'application/json',
    };

    var response = await client.post(url, body: payload, headers: headers);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 201 || response.statusCode == 200) {
      //Tontine tontine = tontineFromJson(response.body);
      var jsdecod = jsonDecode(response.body);
      print('idididiidi : ${jsdecod['id']}');
      return jsdecod['id'];
    } else {
      return null;
    }
  }

/////////////////////////////////// edit totine /////////////////////
  ///
  ///
  Future<dynamic> putTontine(
      {required String api, required Tontine tontine}) async {
    ////////// parse our url /////////////////////
    var url = Uri.parse(baseUri + api);
    //var postEmail = {"email": email};
    ///////////// encode email to json objet/////////
    var payload = tontineToJson(tontine);
    // http request headers
    var headers = {
      'Content-Type': 'application/json',
    };

    var response = await client.put(url, body: payload, headers: headers);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 201 || response.statusCode == 200) {
      //Tontine tontine = tontineFromJson(response.body);
      var jsdecod = jsonDecode(response.body);
      print('puuuuut : ${jsdecod['id']}');
      return jsdecod['id'];
    } else {
      return null;
    }
  }

  //////////////////////////////// get single user by id //////////////////////
  ///
  Future<Tontine?> getSingleTontine({required int id}) async {
    var uri = Uri.parse('${baseUri}tontines/$id');
    var response = await client.get(uri);
    print('Dans remote : ${response.body}');
    print('Dans remote : ${response.statusCode}');
    if (response.statusCode == 200 || response.statusCode == 200) {
      var json = response.body;
      //print(response.body);
      Tontine tontine = tontineFromJson(response.body);
      return tontine;
    }
    return null;
  }

  //////////////////////////////// get single user by id //////////////////////
  ///
  Future<List<Tontine?>> getCurrentUserTontineList({required int id}) async {
    var uri = Uri.parse('${baseUri}users/$id/tontines');
    var response = await client.get(uri);
    print('Dans remote : ${response.body}');
    print('Dans remote : ${response.statusCode}');
    if (response.statusCode == 200 || response.statusCode == 200) {
      var json = response.body;
      //print(response.body);
      List<Tontine> tontineList = listTontineFromJson(response.body);
      return tontineList;
    }
    return [];
  }

  Future<List<Tontine?>> getAllTontineList() async {
    var uri = Uri.parse('${baseUri}tontines');
    var response = await client.get(uri);
    print('toutes les tontines dans remote : ${response.body}');
    print(
        'status code de toutes les tontines dans remote : ${response.statusCode}');
    if (response.statusCode == 200 || response.statusCode == 200) {
      var json = response.body;
      //print(response.body);
      List<Tontine> tontineList = listTontineFromJson(response.body);
      return tontineList;
    }
    return [];
  }

  /////////////////////////////////// post new totine /////////////////////
  ///
  ///
  Future<dynamic> postJoinCode({
    required String api,
    required String code,
    required String userID,
  }) async {
    ////////// parse our url /////////////////////
    var url = Uri.parse(baseUri + api);
    Object postDetail = {
      "unique_code": code,
      "member_id": userID,
    };
    ///////////// encode email to json objet/////////
    var payload = jsonEncode(postDetail);
    // http request headers
    var headers = {
      'Content-Type': 'application/json',
    };

    var response = await client.post(url, body: payload, headers: headers);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 201 || response.statusCode == 200) {
      //Tontine tontine = tontineFromJson(response.body);
      var jsdecod = jsonDecode(response.body);
      print('idididiidi : ${jsdecod['id']}');
      return jsdecod['tontine_id'];
    } else {
      return null;
    }
  }

  /////////////////////////////////// generat new groupe /////////////////////
  ///
  ///
  Future<dynamic> postGeneratGroupeDetails({
    required String api,
    required int tontineId,
    required String groupeName,
  }) async {
    ////////// parse our url /////////////////////
    var url = Uri.parse(baseUri + api);
    Object postDetail = {
      "tontine_id": tontineId,
      "name": groupeName,
    };
    ///////////// encode email to json objet/////////
    var payload = jsonEncode(postDetail);
    // http request headers
    var headers = {
      'Content-Type': 'application/json',
    };

    var response = await client.post(url, body: payload, headers: headers);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 201 || response.statusCode == 200) {
      //Tontine tontine = tontineFromJson(response.body);
      var jsdecod = jsonDecode(response.body);
      print('idididiidi : ${jsdecod['id']}');
      return jsdecod['tontine_id'];
    } else {
      return null;
    }
  }
}
