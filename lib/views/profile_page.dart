import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsi_mobile_124240018/controllers/favorite_controller.dart';
import '../controllers/auth_controller.dart';

// =============================================================================
// PROFILE PAGE (Modul 4 hal. 75-76 + Modul 8 hal. 179)
// =============================================================================

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final AuthController controller = Get.find<AuthController>();
  // [ENABLE GIMMICK WARNA] Uncomment untuk state warna reaktif tanpa controller baru:
  // final Rx<Color> _accentColor = Colors.redAccent.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profil')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.account_circle, size: 100, color: Colors.grey),
              const SizedBox(height: 2),
              Obx(() => Text(
                    "email: ${controller.username}",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
              const SizedBox(height: 4),
              // const Text(
              //   'Kesan: Praktikum mobile sangat seru.\n'
              //   'Pesan: Sukses selalu!',
              //   textAlign: TextAlign.center,
              //   style: TextStyle(color: Colors.grey),
              // ),
              const SizedBox(height: 2),
              // [ENABLE JUMLAH FAVORIT] Tambah import favorite_controller.dart, lalu uncomment:
              Obx(() => Text('Games dimiliki: ${Get.find<FavoriteController>().favorites.length}')),
              // [ENABLE THEME TOGGLE] Uncomment tombol ganti Dark/Light mode:
              // IconButton(
              //   icon: const Icon(Icons.brightness_6),
              //   onPressed: () => Get.changeThemeMode(Get.isDarkMode ? ThemeMode.light : ThemeMode.dark),
              // ),
              // [ENABLE GIMMICK WARNA] Uncomment 3 lingkaran warna + bungkus ElevatedButton di bawah dengan Obx(() => ...):
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [Colors.redAccent, Colors.blue, Colors.green]
              //       .map((c) => GestureDetector(
              //             onTap: () => _accentColor.value = c,
              //             child: Padding(
              //               padding: const EdgeInsets.symmetric(horizontal: 6),
              //               child: CircleAvatar(radius: 16, backgroundColor: c),
              //             ),
              //           ))
              //       .toList(),
              // ),
              // const SizedBox(height: 16),
              // Ganti backgroundColor ElevatedButton dengan `_accentColor.value` di dalam Obx()
              SizedBox(
                width: 200,
                height: 45,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 82, 180, 255),
                    foregroundColor: Colors.white,
                  ),
                  onPressed: controller.logout,
                  // [ENABLE LOGOUT DIALOG] Ganti onPressed di atas dengan:
                  // onPressed: () => Get.defaultDialog(
                  //   title: 'Logout',
                  //   middleText: 'Yakin ingin keluar?',
                  //   textConfirm: 'Ya',
                  //   textCancel: 'Batal',
                  //   onConfirm: () { Get.back(); controller.logout(); },
                  // ),
                  child: const Text('Logout'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
