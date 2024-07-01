import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveisLockedToPrefs(bool value) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setBool('isLocked', value);
}

// Fungsi untuk mengambil nilai boolean dari SharedPreferences
Future<bool> loadIsLockedFromPrefs() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool('isLocked') ?? true;
}
