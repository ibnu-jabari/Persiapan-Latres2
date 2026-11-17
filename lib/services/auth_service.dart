import 'package:shared_preferences/shared_preferences.dart';

// =============================================================================
// AUTH SERVICE / SHARED PREFERENCES (Modul 6 hal. 106, 112-113, 119)
// Tugas: Simpan session login, username, & data register secara lokal.
// =============================================================================

class AuthService {
  static const String _keyLogin = 'isLoggedIn';
  static const String _keyUsername = 'username';
  static const String _keyRegUser = 'reg_username';
  static const String _keyRegPass = 'reg_password';

  static Future<void> saveLogin(String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyLogin, true);
    await prefs.setString(_keyUsername, username);
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyLogin) ?? false;
  }

  static Future<String> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUsername) ?? '';
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyLogin, false);
    await prefs.remove(_keyUsername);
  }

  // [REGISTER FEATURE] Simpan & validasi akun hasil register
  static Future<void> registerUser(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyRegUser, username);
    await prefs.setString(_keyRegPass, password);
  }

  static Future<bool> validateRegistered(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final savedUser = prefs.getString(_keyRegUser);
    final savedPass = prefs.getString(_keyRegPass);
    return savedUser != null && username == savedUser && password == savedPass;
  }
}
