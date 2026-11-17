import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
// [ENABLE REGISTER] Uncomment import app_routes.dart jika pakai Register:
// import '../routes/app_routes.dart';

// =============================================================================
// LOGIN PAGE (Modul 3 hal. 57, Modul 6 hal. 110-111, Modul 8 hal. 157, 179)
// =============================================================================

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final AuthController controller = Get.find<AuthController>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // const Icon(Icons.movie, size: 64, color: Colors.redAccent),
              // [GANTI GAMBAR] Comment Icon di atas, lalu uncomment salah satu:
              // 1) Gambar lokal: buat folder `assets/images/`, taruh file, lalu daftarkan di pubspec.yaml:
              //    flutter:
              //      assets:
              //        - assets/images/logo.png
              //    Setelah itu `flutter pub get`, lalu pakai:
              Image.asset('assets/images/logo.png', height: 80),
              // 2) Gambar dari URL:
              // Image.network('https://example.com/logo.png', height: 80),
              const SizedBox(height: 12),
              const Text(
                'Hydra Games',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              Obx(() => TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      prefixIcon: const Icon(Icons.person_outline),
                      border: const OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: controller.isLoginFailed
                              ? Colors.red
                              : Colors.grey,
                        ),
                      ),
                    ),
                  )),
              const SizedBox(height: 16),
              Obx(() => TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: const Icon(Icons.lock_outline),
                      border: const OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: controller.isLoginFailed
                              ? Colors.red
                              : Colors.grey,
                        ),
                      ),
                    ),
                  )),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 82, 154, 255),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () {
                    controller.login(
                      _usernameController.text,
                      _passwordController.text,
                    );
                  },
                  child: const Text('Login'),
                ),
              ),
              // [ENABLE REGISTER] Uncomment tombol di bawah untuk menuju RegisterPage:
              // TextButton(
              //   onPressed: () => Get.toNamed(AppRoutes.register),
              //   child: const Text('Belum punya akun? Daftar'),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
