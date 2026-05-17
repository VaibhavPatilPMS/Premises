import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsInstance {
  static final SharedPrefsInstance _sharedPrefsInstance =
      SharedPrefsInstance._internal();
  static SharedPreferences? instance;

  factory SharedPrefsInstance() {
    return _sharedPrefsInstance;
  }

  createSharePrefsInstance() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    instance = sharedPreferences;
  }

  SharedPrefsInstance._internal();
}
