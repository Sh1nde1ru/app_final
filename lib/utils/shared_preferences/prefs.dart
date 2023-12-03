import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static SharedPreferences? prefs;

  static Future ensureInitialized() async {
    prefs ??= await SharedPreferences.getInstance();
    Prefs.startValue = 0;
  }

  static double? get startValue {
    return prefs?.getDouble('startValue');
  }

  static set startValue(double? value) {
    value == null
        ? prefs?.remove('startValue')
        : prefs?.setDouble('startValue', value);
  }
}
