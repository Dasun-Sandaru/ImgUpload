import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  // store token in phone Db
  Future<void> saveToken(String token) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('Token', token);
    print('Token Store In Local Db');
  }

  // read token
  Future<String?> readToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('Token');
    print('Token ID In Local Db : ${token}');
    return token;
  }

  // remove saved token
  Future<void> removeToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getString('Token') != null) {
      pref.remove('Token');
    }
    print('Token Removed');
  }
}
