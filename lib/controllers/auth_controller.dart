import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/app_routes.dart';
import '../services/auth_service.dart';

// =============================================================================
// AUTH CONTROLLER (Modul 8 hal. 159, 162 & Modul 6 hal. 112-113, 119)
// CARA SWAP SAAT RESPONSI:
// - Default: login hardcode ('124240018' / '123').
// - Jika soal pakai Register: cari [ENABLE REGISTER] dan uncomment di bawah.
// =============================================================================

class AuthController extends GetxController {
  final RxString _username = ''.obs;
  final RxBool _isLoginFailed = false.obs;

  String get username => _username.value;
  bool get isLoginFailed => _isLoginFailed.value;

  @override
  void onInit() {
    super.onInit();
    checkLogin();
  }

  Future<void> checkLogin() async {
    final loggedIn = await AuthService.isLoggedIn();
    if (loggedIn) {
      _username.value = await AuthService.getUsername();
      Get.offAllNamed(AppRoutes.root);
    }
  }

  Future<void> login(String inputUser, String inputPass) async {
    final user = inputUser.trim();
    final pass = inputPass.trim();

    // [DEFAULT] Login hardcode sesuai NIM & password soal:
    final bool isValid = (user == 'admin@gmail.com' && pass == '123');

    // [ENABLE REGISTER] Comment baris `isValid` di atas, lalu uncomment baris ini:
    // final bool isValid = await AuthService.validateRegistered(user, pass);

    if (isValid) {
      _isLoginFailed.value = false;
      _username.value = user;
      await AuthService.saveLogin(user);
      Get.offAllNamed(AppRoutes.root);
      Get.snackbar('Berhasil', 'Login berhasil', backgroundColor: Colors.green, colorText: Colors.white);
    } else {
      _isLoginFailed.value = true;
      Get.snackbar('Login Gagal', 'Username atau password salah', backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  // [REGISTER FEATURE] Dipanggil dari RegisterPage
  Future<void> register(String inputUser, String inputPass) async {
    final user = inputUser.trim();
    final pass = inputPass.trim();
    if (user.isEmpty || pass.isEmpty) {
      Get.snackbar('Gagal', 'Username dan password wajib diisi', backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }
    await AuthService.registerUser(user, pass);
    Get.back(); // Kembali ke LoginPage
    Get.snackbar('Berhasil', 'Akun terdaftar, silakan login', backgroundColor: Colors.green, colorText: Colors.white);
  }

  Future<void> logout() async {
    await AuthService.logout();
    _username.value = '';
    Get.offAllNamed(AppRoutes.login);
    Get.snackbar('Logout', 'Berhasil keluar', backgroundColor: Colors.orange, colorText: Colors.white);
  }
}
