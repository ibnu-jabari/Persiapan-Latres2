import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/item_model.dart';
import '../services/api_service.dart';

// =============================================================================
// HOME CONTROLLER (Modul 8 hal. 170 & Modul 5 hal. 91)
// Sudah siap Search lokal (tidak aktif sampai [ENABLE SEARCH] di-uncomment di HomePage).
// =============================================================================

class HomeController extends GetxController {
  final RxList<ItemModel> _items = <ItemModel>[].obs;
  final RxBool _isLoading = false.obs;
  final RxString _searchQuery = ''.obs;
  // [ENABLE FILTER] Uncomment baris di bawah jika soal butuh filter pill/kategori:
  // final RxString selectedCategory = 'All'.obs;
  // void filterCategory(String cat) => selectedCategory.value = cat;

  bool get isLoading => _isLoading.value;

  // Otomatis filter berdasarkan _searchQuery (kalau kosong, kembalikan semua)
  List<ItemModel> get items {
    // [ENABLE FILTER] Uncomment & sesuaikan field (mis. e.newsSite == selectedCategory.value):
    // if (selectedCategory.value != 'All') {
    //   return _items.where((e) => e.genres.contains(selectedCategory.value)).toList();
    // }
    if (_searchQuery.value.isEmpty) return _items;
    return _items
        .where((e) =>
            e.title.toLowerCase().contains(_searchQuery.value.toLowerCase()))
        .toList();
  }

  void search(String query) {
    _searchQuery.value = query.trim();
  }

  @override
  void onInit() {
    _retrieveData();
    super.onInit();
  }

  Future<void> _retrieveData() async {
    try {
      _isLoading.value = true;
      final data = await ApiService.fetchItems();
      _items.assignAll(data);
    } catch (e) {
      Get.snackbar('Error', e.toString(), backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      _isLoading.value = false;
    }
  }
}
