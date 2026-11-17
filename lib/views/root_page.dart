import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/root_controller.dart';
import 'favorite_page.dart';
import 'home_page.dart';
import 'profile_page.dart';
// [ENABLE MODUL 7] Uncomment import + tab LbsNotifPage di bawah jika soal pakai Notif/LBS:
import 'lbs_notif_page.dart';

// =============================================================================
// ROOT PAGE - BOTTOM NAVIGATION BAR (Modul 4 hal. 66-67, Modul 8 hal. 179)
// =============================================================================

class RootPage extends StatelessWidget {
  RootPage({super.key});

  final RootController controller = Get.find<RootController>();

  final List<Widget> _pages = [
    HomePage(),
    FavoritePage(),
    // [ENABLE MODUL 7] Uncomment baris ini:
    LbsNotifPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          body: _pages[controller.selectedIndex.value],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: controller.selectedIndex.value,
            // Warna NavBar diatur di main.dart (bottomNavigationBarTheme), atau override di sini:
            // backgroundColor: Colors.black87,
            // selectedItemColor: Colors.redAccent,
            // unselectedItemColor: Colors.grey,
            onTap: controller.changeTab,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Beranda',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.library_books),
                label: 'Library',
              ),
              // [ENABLE MODUL 7] Uncomment item tab ini:
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications_active),
                label: 'Notif/LBS',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profil',
              ),
            ],
          ),
        ));
  }
}
