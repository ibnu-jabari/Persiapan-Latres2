import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/item_model.dart';
import '../services/api_service.dart';

// =============================================================================
// DETAIL CONTROLLER (Modul 8 hal. 179-180 & Modul 5 hal. 93-94, 100)
// Mengambil id dari Get.arguments, lalu fetch detail dari API.
// =============================================================================

class DetailController extends GetxController {
  final Rx<ItemModel?> _item = Rx<ItemModel?>(null);
  final RxBool _isLoading = true.obs;

  ItemModel? get item => _item.value;
  bool get isLoading => _isLoading.value;

  @override
  void onInit() {
    super.onInit();
    final int id = Get.arguments as int;
    // [ENABLE MULTI-ARGUMENTS] Jika kirim Map (Modul 8 hal. 164):
    // Get.toNamed(AppRoutes.detail, arguments: {'id': item.id, 'fromFav': true});
    // final args = Get.arguments as Map<String, dynamic>;
    // final int id = args['id'] as int;
    fetchDetail(id);
  }

  Future<void> fetchDetail(int id) async {
    try {
      _isLoading.value = true;
      _item.value = await ApiService.fetchItemDetail(id);
    } catch (e) {
      Get.snackbar('Error', e.toString(), backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      _isLoading.value = false;
    }
  }
}
