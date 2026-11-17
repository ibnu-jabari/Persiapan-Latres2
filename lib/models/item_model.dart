import 'package:hive/hive.dart';

part 'item_model.g.dart';

@HiveType(typeId: 0)
class ItemModel extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String thumbnail;

  @HiveField(3)
  final String genre;

  @HiveField(4)
  final String platform;

  @HiveField(5)
  final String releaseDate;

  @HiveField(6)
  final String publisher;

  @HiveField(7)
  final String developer;

  @HiveField(8)
  final String description;




  ItemModel({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.genre,
    required this.platform,
    required this.releaseDate,
    required this.publisher,
    required this.developer,
    required this.description,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    final rawDesc =
        (json['description'] ?? json['short_description'] ?? '') as String;
    return ItemModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? 'No Title',
      thumbnail: json['thumbnail'] ?? '',
      genre: json['genre'] ?? '',
      platform: json['platform'] ?? '',
      releaseDate: json['release_date'] ?? '',
      publisher: json['publisher'] ?? '',
      developer: json['developer'] ?? '',
      description: rawDesc.replaceAll(RegExp(r'<[^>]*>'), ''),
    );
  }
}