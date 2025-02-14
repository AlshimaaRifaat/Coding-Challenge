import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const String lastPrimeKey = "LAST_PRIME_TIME";

  Future<void> saveLastPrimeTime(DateTime time) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(lastPrimeKey, time.toIso8601String());
  }

  Future<DateTime?> getLastPrimeTime() async {
    final prefs = await SharedPreferences.getInstance();
    final storedTime = prefs.getString(lastPrimeKey);
    if (storedTime != null) {
      return DateTime.tryParse(storedTime);
    }
    return null;
  }
}
