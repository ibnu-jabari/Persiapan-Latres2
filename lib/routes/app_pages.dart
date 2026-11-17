import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../controllers/detail_controller.dart';
import '../controllers/favorite_controller.dart';
import '../controllers/home_controller.dart';
import '../controllers/lbs_notif_controller.dart';
import '../controllers/root_controller.dart';
import '../views/detail_page.dart';
import '../views/login_page.dart';
import '../views/register_page.dart';
import '../views/root_page.dart';
import 'app_routes.dart';

// =============================================================================
// APP PAGES & BINDINGS (Modul 8 hal. 165-166, 178)
// =============================================================================

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    // permanent: true agar AuthController tetap hidup setelah Get.offAllNamed(root)
    Get.put<AuthController>(AuthController(), permanent: true);
  }
}

class RootBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RootController>(() => RootController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<FavoriteController>(() => FavoriteController());
    // Modul 7 (hanya di-init saat LbsNotifPage dibuka)
    Get.lazyPut<LbsNotifController>(() => LbsNotifController());
  }
}

class DetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailController>(() => DetailController());
  }
}

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.login,
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => RegisterPage(),
    ),
    GetPage(
      name: AppRoutes.root,
      page: () => RootPage(),
      binding: RootBinding(),
    ),
    GetPage(
      name: AppRoutes.detail,
      page: () => DetailPage(),
      binding: DetailBinding(),
    ),
  ];
}
