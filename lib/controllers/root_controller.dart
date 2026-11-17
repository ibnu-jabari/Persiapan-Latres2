import 'package:get/get.dart';

// =============================================================================
// ROOT CONTROLLER (Modul 4 hal. 66 + Modul 8 hal. 156)
// Mengatur index tab aktif pada BottomNavigationBar.
// =============================================================================

class RootController extends GetxController {
  final RxInt selectedIndex = 0.obs;

  void changeTab(int index) {
    selectedIndex.value = index;
  }
}
