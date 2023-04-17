import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:moneytine/models/money_transaction.dart';
import 'package:moneytine/models/tontine.dart';
import 'package:moneytine/models/user.dart';

import '../models/single_group_data.dart';

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
    //print(response.statusCode);
    //print(response.body);
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
      {required String api, required MyUser user}) async {
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
    } else if (response.statusCode == 422) {
      var result = jsonDecode(response.body);
      if (result.containsKey("email")) {
        return 'emailError';
      }
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

    //print(response.statusCode);
    //print(response.body);
    if (response.statusCode == 201 || response.statusCode == 200) {
      MyUser logUser = userFromJson(response.body);
      return logUser;
    } else {
      return null;
    }
  }

  //////////////////////////////// get single user by id //////////////////////
  ///
  Future<MyUser?> getSingleUser({required int id}) async {
    var uri = Uri.parse(baseUri + 'users/$id');
    var response = await client.get(uri);
    //print('Dans remote : ${response.body}');
    //print('Dans remote : ${response.statusCode}');
    if (response.statusCode == 200 || response.statusCode == 201) {
      var json = response.body;
      //print(response.body);
      MyUser user = userFromJson(json);
      return user;
    }
    return null;
  }

  //////////////////////////////// get single user by id //////////////////////
  ///
  Future<List<MyUser>> getTontineUserList({required int id}) async {
    var uri = Uri.parse('${baseUri}tontines/$id/users');
    var response = await client.get(uri);
    //print('Dans remote user liste : ${response.body}');
    //print('Dans remote : ${response.statusCode}');
    if (response.statusCode == 200 || response.statusCode == 201) {
      var json = response.body;
      //print(response.body);
      List<MyUser> userList = userListFromJson(json);
      //print(userList);

      return userList;
    }
    return [];
  }

  //////////////////////////////// get group part by id //////////////////////
  ///
  Future<double?> getGroupPart({required int groupeId}) async {
    var uri = Uri.parse('${baseUri}groups/$groupeId/part_remaining');
    var response = await client.get(uri);
    //print('Dans remote user liste : ${response.body}');
    //print('Dans remote : ${response.statusCode}');
    if (response.statusCode == 200 || response.statusCode == 201) {
      var json = jsonDecode(response.body);
      //print(json["Part_remaining"]);
      double part = double.parse(json["Part_remaining"].toString());

      return part;
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
    //print(response.statusCode);
    //print(response.body);
    if (response.statusCode == 201 || response.statusCode == 200) {
      //Tontine tontine = tontineFromJson(response.body);
      var jsdecod = jsonDecode(response.body);
      // print('idididiidi : ${jsdecod['id']}');
      return jsdecod['id'];
    } else {
      return null;
    }
  }

  /////////////////////////////////// post new totine /////////////////////
  ///
  ///
  Future<dynamic> postNewTransaction(
      {required String api, required MoneyTransaction mtransaction}) async {
    ////////// parse our url /////////////////////
    var url = Uri.parse(baseUri + api);
    //var postEmail = {"email": email};
    ///////////// encode email to json objet/////////
    var payload = moneyTransactionToJson(mtransaction);
    // http request headers
    var headers = {
      'Content-Type': 'application/json',
    };

    var response = await client.post(url, body: payload, headers: headers);
    //print(response.statusCode);
    //print(response.body);
    if (response.statusCode == 201 || response.statusCode == 200) {
      //Tontine tontine = tontineFromJson(response.body);
      var jsdecod = jsonDecode(response.body);
      //print('transactions id : ${jsdecod['id']}');
      return jsdecod['id'];
    } else {
      return null;
    }
  }

/////////////////////////////////// add user to group /////////////////////
  ///
  ///
  Future<bool> addUserToGroup(
      {required String api,
      required String part,
      required int userId,
      required int groupId}) async {
    ////////// parse our url /////////////////////
    var url = Uri.parse(baseUri + api);
    Object joinGroupDetails = {
      "member_id": userId,
      "group_id": groupId,
      "part": part,
    };
    ///////////// encode email to json objet/////////

    var payload = jsonEncode(joinGroupDetails);
    // http request headers
    var headers = {
      'Content-Type': 'application/json',
    };

    var response = await client.post(url, body: payload, headers: headers);
    //print(response.statusCode);
    //print(response.body);
    if (response.statusCode == 201 || response.statusCode == 200) {
      //Tontine tontine = tontineFromJson(response.body);
      //var jsdecod = jsonDecode(response.body);
      var json = jsonDecode(response.body);
      if (json.containsKey("error")) {
        return false;
      } else {
        //print('when add user to group if sucess ${response.body}');
        return true;
      }
    } else {
      //print('when add user to group if faild ${response.body}');

      return false;
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
    // print(response.statusCode);
    //print(response.body);
    if (response.statusCode == 201 || response.statusCode == 200) {
      //Tontine tontine = tontineFromJson(response.body);
      var jsdecod = jsonDecode(response.body);
      //print('puuuuut : ${jsdecod['id']}');
      return jsdecod['id'];
    } else {
      return null;
    }
  }

  /////////////////////////////////////////////////////////////////////
  /// enable tontine ////////////////////////////
  Future<int> enableTontine({required int tontineId}) async {
    ////////// parse our url /////////////////////
    var url = Uri.parse('${baseUri}tontines/$tontineId/activate');

    var headers = {
      'Content-Type': 'application/json',
    };

    var response = await client.put(url, headers: headers);
    //print(response.statusCode);
    //print('Dans remote body on enable : ${response.body}');
    //print('Dans remote code on enable : ${response.statusCode}');

    return response.statusCode;
  }

  /////////////////////////////////////////////////////////////////////
  /// enable tontine ////////////////////////////
  Future<int> desableTontine({required int tontineId}) async {
    ////////// parse our url /////////////////////
    var url = Uri.parse('${baseUri}tontines/$tontineId/desactivate');

    var headers = {
      'Content-Type': 'application/json',
    };

    var response = await client.put(url, headers: headers);
    //print(response.statusCode);
    //print('Dans remote body on desable : ${response.body}');
    //print('Dans remote code on desable : ${response.statusCode}');

    return response.statusCode;
  }

  //////////////////////////////// get single user by id //////////////////////
  ///
  Future<Tontine?> getSingleTontine({required int id}) async {
    var uri = Uri.parse('${baseUri}tontines/$id');
    var response = await client.get(uri);
    // print('Dans remote : ${response.body}');
    /// print('Dans remote : ${response.statusCode}');
    if (response.statusCode == 200 || response.statusCode == 201) {
      var json = response.body;
      //print(response.body);
      Tontine tontine = tontineFromJson(response.body);
      return tontine;
    }
    return null;
  }

  //////////////////////////////// delete tontine //////////////////////
  ///
  Future<int> deletSingleTontine({required int id}) async {
    var uri = Uri.parse('${baseUri}tontines/$id');
    var response = await client.delete(uri);
    //print('Dans remote delete body : ${response.body}');
    //print('ans remote delete code : ${response.statusCode}');
    //if (response.statusCode == 200 || response.statusCode == 200) {
    //var json = jsonDecode(response.body);

    return response.statusCode;
    //}
    //return 0;
  }

  //////////////////////////////// remove user to group //////////////////////
  ///
  Future<int> deleteUserToGroup(
      {required int groupId, required int userId}) async {
    var uri = Uri.parse('${baseUri}groups/$groupId/users/$userId');
    var response = await client.delete(uri);
    //print('Dans remote delete user body : ${response.body}');
    //print('dans remote delete user code : ${response.statusCode}');
    //if (response.statusCode == 200 || response.statusCode == 200) {
    //var json = jsonDecode(response.body);

    return response.statusCode;
    //}
    //return 0;
  }

  //////////////////////////////// get all transactions list //////////////////////
  ///
  Future<List<MoneyTransaction>> getTransactionsList() async {
    var uri = Uri.parse('${baseUri}transactions');
    var response = await client.get(uri);
    //print('list transactions Dans remote : ${response.body}');
    //print('code Dans remote : ${response.statusCode}');
    if (response.statusCode == 200 || response.statusCode == 201) {
      var json = response.body;
      //print(response.body);
      List<MoneyTransaction> mTransactions =
          moneyTransactionListFromJson(response.body);
      return mTransactions;
    }
    return [];
  }

  //////////////////////////////// get single user by id //////////////////////
  ///
  Future<List<Tontine?>> getCurrentUserTontineList({required int id}) async {
    var uri = Uri.parse('${baseUri}users/$id/tontines');
    var response = await client.get(uri);
    //print('Dans remote : ${response.body}');
    //print('Dans remote : ${response.statusCode}');
    if (response.statusCode == 200 || response.statusCode == 201) {
      var json = response.body;
      //print(response.body);
      List<Tontine> tontineList = listTontineFromJson(response.body);
      return tontineList;
    }
    return [];
  }

  //////////////////////////////// get single user by id //////////////////////
  ///
  Future<List<SingleGroupData>> getSingleGroupData(
      {required int seletedGroupId}) async {
    var uri = Uri.parse('${baseUri}groups/$seletedGroupId/users');
    var response = await client.get(uri);
    //print('Dans remote i1 : ${response.body}');
    //print('Dans remote : ${response.statusCode}');
    if (response.statusCode == 200 || response.statusCode == 201) {
      var json = response.body;
      //print(response.body);
      List<SingleGroupData> seletedGroupData =
          singleGroupDataFromJson(response.body);
      return seletedGroupData;
    }
    return [];
  }

  Future<List<Tontine?>> getAllTontineList() async {
    var uri = Uri.parse('${baseUri}tontines');
    var response = await client.get(uri);
    //print('toutes les tontines dans remote : ${response.body}');
    // print(
    //'status code de toutes les tontines dans remote : ${response.statusCode}');
    if (response.statusCode == 200 || response.statusCode == 201) {
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
      //print('idididiidi : ${jsdecod['id']}');
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
    ///////////// encode email to json objet////////////
    var payload = jsonEncode(postDetail);
    // http request headers
    var headers = {
      'Content-Type': 'application/json',
    };

    var response = await client.post(url, body: payload, headers: headers);
    //print(response.statusCode);
    //print('gouuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu : ${response.body}');
    if (response.statusCode == 201 || response.statusCode == 200) {
      //Tontine tontine = tontineFromJson(response.body);
      var jsdecod = jsonDecode(response.body);
      // print('idididiidi : ${jsdecod['id']}');
      return jsdecod['id'].toString();
    } else {
      //print('nonononoononnonon');
      return null;
    }
  }
}
