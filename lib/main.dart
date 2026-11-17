import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/item_model.dart';
import 'routes/app_pages.dart';
import 'routes/app_routes.dart';
// [ENABLE MODUL 7] Uncomment import + NotificationService().init() di bawah jika soal pakai Notifikasi:
import 'services/notification_service.dart';

// =============================================================================
// MAIN.DART (Modul 6 hal. 107, Modul 7 hal. 136, Modul 8 hal. 179)
// =============================================================================

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Inisialisasi Hive (Modul 6 hal. 107)
  await Hive.initFlutter();
  Hive.registerAdapter(ItemModelAdapter());
  await Hive.openBox<ItemModel>('favorites');

  // 2. [ENABLE MODUL 7] Uncomment baris ini untuk aktifkan Local Notification (Android/Emulator):
  await NotificationService().init();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Responsi Template',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        // [THEME] Ubah warna AppBar & BottomNavBar global di sini:
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 29, 30, 30),
          foregroundColor: Colors.white,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.black87,
          selectedItemColor: Color.fromARGB(255, 100, 150, 235),
          unselectedItemColor: Colors.grey,
        ),
      ),
      initialRoute: AppRoutes.login,
      getPages: AppPages.routes,
    );
  }
}
