import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
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
    var _payload = jsonEncode(postEmail);
    // http request headers
    var _headers = {
      'Content-Type': 'application/json',
    };

    var response = await client.post(url, body: _payload, headers: _headers);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 201 || response.statusCode == 200) {
      return jsonDecode(response.body);
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
    var _payload = userToJson(user);

    // http request headers
    var _headers = {
      'Content-Type': 'application/json',
    };

    //////////////// post user ////////////
    var response = await client.post(url, body: _payload, headers: _headers);

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
    var _payload = jsonEncode(resetDetails);

    // http request headers
    var _headers = {
      'Content-Type': 'application/json',
    };

    //////////////// post user ////////////
    var response = await client.post(url, body: _payload, headers: _headers);

    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 201 || response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }

  /////////
}
