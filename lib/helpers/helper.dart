import 'package:shared_preferences/shared_preferences.dart';

class Helper {
  static String sharedPreferenceUserLoggedInKey = "ISLOGGEDIN";
  static String sharedPreferenceUserNameKey = "USERNAMEKEY";
  static String sharedPreferenceUserEmailKey = "USEREMAILKEY";

  static Future<bool> saveUserLoggedInSharedPreference(
    bool isUserLoggedIn) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(sharedPreferenceUserLoggedInKey, isUserLoggedIn);
  }

  static Future<bool> getUserLoggedInSharedPreference() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(sharedPreferenceUserLoggedInKey) ?? false;
  }
}
