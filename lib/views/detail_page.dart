import 'package:flutter/material.dart';
// [ENABLE BUKA WEB] Jalankan `flutter pub add url_launcher`, lalu uncomment:
// import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';
import '../controllers/detail_controller.dart';
import '../controllers/favorite_controller.dart';

// =============================================================================
// DETAIL PAGE (Modul 5 hal. 94-95, Modul 8 hal. 174-176, 179)
// =============================================================================

class DetailPage extends StatelessWidget {
  DetailPage({super.key});

  final DetailController controller = Get.find<DetailController>();
  final FavoriteController favController = Get.find<FavoriteController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail')),
      body: Obx(() {
        if (controller.isLoading || controller.item == null) {
          return const Center(child: CircularProgressIndicator());
        }
        final item = controller.item!;
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              item.thumbnail.isNotEmpty
                  ? Image.network(
                      item.thumbnail,
                      width: double.infinity,
                      height: 300,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const SizedBox(
                        height: 300,
                        child: Center(child: Icon(Icons.broken_image, size: 64)),
                      ),
                    )
                  : const SizedBox(
                      height: 200,
                      child: Center(child: Icon(Icons.image, size: 64)),
                    ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            item.title,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Obx(() {
                          final isFav = favController.isFavorite(item.id);
                          return IconButton(
                            icon: Icon(
                              isFav ? Icons.delete : Icons.library_add,
                              color: isFav ? const Color.fromARGB(255, 43, 141, 233) : Colors.grey,
                              size: 28,
                            ),
                            onPressed: () => favController.toggleFavorite(item),
                          );
                        }),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text('${item.genre} | ${item.platform}', style: const TextStyle(fontSize: 16)),
                    const SizedBox(height: 8),
                    Text("Release date: ${item.releaseDate}\nPublisher: ${item.publisher}\nDeveloper: ${item.developer}", style: const TextStyle(fontSize: 16)),
                    const SizedBox(height: 8),
                    // Image.network(
                    //   item.thumbnail.isNotEmpty ? item.thumbnail : '-',
                    //   width: double.infinity,
                    //   height: 200,
                    //   fit: BoxFit.cover,
                    //   errorBuilder: (_, __, ___) => const Center(child: Icon(Icons.broken_image, size: 48)),
                    // ),
                    const SizedBox(height: 16),
                    const Text(
                      'Overview',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item.description.isNotEmpty
                          ? item.description
                          : 'Tidak ada deskripsi.',
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
      // [ENABLE BUKA WEB] Uncomment FloatingActionButton di bawah (pastikan ItemModel punya field `url`):
      // floatingActionButton: Obx(() {
      //   final item = controller.item;
      //   if (item == null || item.url.isEmpty) return const SizedBox.shrink();
      //   return FloatingActionButton(
      //     tooltip: 'Buka Web',
      //     onPressed: () => launchUrl(
      //       Uri.parse(item.url),
      //       mode: LaunchMode.externalApplication,
      //     ),
      //     child: const Icon(Icons.open_in_new),
      //   );
      // }),
    );
  }
}
