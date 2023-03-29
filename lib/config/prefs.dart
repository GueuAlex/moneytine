import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> setId(int? id) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setInt('userId', (id) as int);
  }

  Future<void> setIntroIsView({required bool? isView}) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setBool('introIsView', (isView) as bool);
  }

  Future<void> setCurrentStateId(int? id) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setInt('currentSateId', (id) as int);
  }

  Future<void> setEmailAndPassword(String? email, String? password) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString('email', (email) as String);
    prefs.setString('password', (password) as String);
  }

  Future<void> setBithDate({required String? birthdate}) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString('birthdate', (birthdate) as String);
  }

  Future<void> setGender({required String? gender}) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString('gender', (gender) as String);
  }

  get id async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getInt('userId');
  }

  get introIsView async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getBool('introIsView');
  }

  get currentStateId async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getInt('currentSateId');
  }

  get email async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString('email');
  }

  get gender async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString('gender');
  }

  get birthdate async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString('birthdate');
  }

  get password async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString('password');
  }

  removeId() async {
    final SharedPreferences prefs = await _prefs;
    bool isRemove = await prefs.remove('userId');
    return isRemove;
  }
}
