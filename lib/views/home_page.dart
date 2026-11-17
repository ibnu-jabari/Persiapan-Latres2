import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
// [ENABLE APPBAR BADGE] Uncomment import di bawah jika mau tampilkan badge jumlah favorit di AppBar:
// import '../controllers/favorite_controller.dart';
import '../routes/app_routes.dart';

// =============================================================================
// HOME PAGE - GRID / LIST DATA API (Modul 8 hal. 171-173, 179)
// =============================================================================

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final HomeController controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Browse Games'),
        // [ENABLE APPBAR BADGE] Uncomment actions di bawah untuk badge angka di AppBar (Modul 8 hal. 180):
        // actions: [
        //   IconButton(
        //     onPressed: () {},
        //     icon: Obx(() => Badge(
        //           label: Text('${Get.find<FavoriteController>().favorites.length}'),
        //           child: const Icon(Icons.favorite),
        //         )),
        //   ),
        // ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            // [ENABLE SEARCH] Uncomment blok TextField di bawah jika soal butuh Search bar:
            // TextField(
            //   onChanged: controller.search,
            //   decoration: const InputDecoration(
            //     hintText: 'Cari...',
            //     prefixIcon: Icon(Icons.search),
            //     border: OutlineInputBorder(),
            //   ),
            // ),
            // const SizedBox(height: 12),
            // [ENABLE FILTER PILL] Uncomment blok di bawah (+ [ENABLE FILTER] di HomeController) untuk pill ChoiceChip horizontal:
            // Obx(() => SingleChildScrollView(
            //       scrollDirection: Axis.horizontal,
            //       child: Row(
            //         children: ['All', 'NASA', 'SpaceNews', 'Arstechnica']
            //             .map((cat) => Padding(
            //                   padding: const EdgeInsets.only(right: 8),
            //                   child: ChoiceChip(
            //                     label: Text(cat),
            //                     selected: controller.selectedCategory.value == cat,
            //                     onSelected: (_) => controller.filterCategory(cat),
            //                   ),
            //                 ))
            //             .toList(),
            //       ),
            //     )),
            // const SizedBox(height: 12),
            Expanded(
              child: Obx(() {
                if (controller.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                // [ENABLE REFRESH] Bungkus GridView/ListView dengan RefreshIndicator(onRefresh: () async => controller.onInit(), child: ...)
                // return GridView.builder(
                //   itemCount: controller.items.length,
                //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                //     crossAxisCount: 2,
                //     crossAxisSpacing: 8,
                //     mainAxisSpacing: 8,
                //     childAspectRatio: 0.65,
                //   ),
                //   itemBuilder: (context, index) {
                //     final item = controller.items[index];
                //     return GestureDetector(
                //       onTap: () =>
                //           Get.toNamed(AppRoutes.detail, arguments: item.id),
                //       child: Card(
                //         clipBehavior: Clip.antiAlias,
                //         child: Column(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             Expanded(
                //               child: item.screenshots.isNotEmpty
                //                   ? Image.network(
                //                       item.screenshots[0],
                //                       width: double.infinity,
                //                       fit: BoxFit.cover,
                //                       errorBuilder: (_, __, ___) => const Center(
                //                           child: Icon(Icons.broken_image, size: 48)),
                //                     )
                //                   : const Center(
                //                       child: Icon(Icons.image, size: 48)),
                //             ),
                //             Padding(
                //               padding: const EdgeInsets.all(8),
                //               child: Column(
                //                 crossAxisAlignment: CrossAxisAlignment.start,
                //                 children: [
                //                   Text(
                //                     item.title,
                //                     maxLines: 1,
                //                     overflow: TextOverflow.ellipsis,
                //                     style: const TextStyle(
                //                       fontWeight: FontWeight.bold,
                //                     ),
                //                   ),
                //                   const SizedBox(height: 4),
                //                   Text('⭐ ${item.genre}'),
                //                 ],
                //               ),
                //             ),
                //           ],
                //         ),
                //       ),
                //     );
                //   },
                // );
                // [ENABLE LIST VIEW] Comment GridView.builder di atas, lalu uncomment ListView.builder di bawah untuk tampilan list memanjang (Card + ListTile):
                return ListView.builder(
                  itemCount: controller.items.length,
                  itemBuilder: (context, index) {
                    final item = controller.items[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        onTap: () => Get.toNamed(AppRoutes.detail, arguments: item.id),
                        leading: item.thumbnail.isNotEmpty
                            ? Image.network(
                                item.thumbnail,
                                width: 100,
                                height: 72,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
                              )
                            : const Icon(Icons.image),
                        title: Text(item.title, maxLines: 2, overflow: TextOverflow.ellipsis),
                        subtitle: Text('${item.genre} | ${item.platform}'),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
