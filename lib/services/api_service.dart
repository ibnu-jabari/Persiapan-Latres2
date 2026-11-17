import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/item_model.dart';

class ApiService {
  static const String baseUrl = 'https://www.freetogame.com/api';

  static Future<List<ItemModel>> fetchItems() async {
    final response = await http.get(Uri.parse('$baseUrl/games'));
    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      final List<dynamic> list =
        decoded is List ? decoded : (decoded['products'] ?? []);
        
      return list.map((e) => ItemModel.fromJson(e)).toList();
    } else {
      throw Exception('Gagal memuat data (${response.statusCode})');
    }
  }

  static Future<ItemModel> fetchItemDetail(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/game?id=$id'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return ItemModel.fromJson(data);
    } else {
      throw Exception('Gagal memuat detail (${response.statusCode})');
    }
  }
}