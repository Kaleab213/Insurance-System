import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static String get email => _prefs.getString('email') ?? '';

  static set email(String value) {
    _prefs.setString('email', value);
  }
  static String get firstname => _prefs.getString('firstname') ?? '';

  static set firstname(String value) {
    _prefs.setString('firstname', value);
  }

static String get lastname => _prefs.getString('lastname') ?? '';

  static set lastname(String value) {
    _prefs.setString('lastname', value);
  }


  static String get userId => _prefs.getString('userId') ?? "";

  static set userId(String value) {
    _prefs.setString('userId', value);
  }

  static String get role => _prefs.getString('role') ?? "";

  static set role(String value) {
    _prefs.setString('role', value);
  }
}
