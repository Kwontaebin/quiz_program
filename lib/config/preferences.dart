import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static late SharedPreferences _prefs;

  static const String _keyQuizNum = 'quizNum';

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static String? get quizNum => _prefs.getString(_keyQuizNum);

  static Future<void> setQuizNum(String? value) async {
    if (value == null) {
      await _prefs.remove(_keyQuizNum);
    } else {
      await _prefs.setString(_keyQuizNum, value);
    }
  }

  static Future<void> clear() async {
    await _prefs.clear();
  }
}
