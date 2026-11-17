import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/lbs_notif_controller.dart';
import '../services/lbs_service.dart';

// =============================================================================
// LBS & NOTIFICATION PAGE - MODUL 7 (hal. 138-140, 146-149)
// Siap pakai untuk Immediate Notification, Scheduled Notification, & GPS LBS.
// =============================================================================

class LbsNotifPage extends StatelessWidget {
  LbsNotifPage({super.key});

  final LbsNotifController controller = Get.find<LbsNotifController>();

  // Contoh koordinat target dummy (Kampus UPNYK dari Modul 7 hal. 142)
  static const double _targetLat = -7.7823;
  static const double _targetLng = 110.4157;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notif & LBS (Modul 7)')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              '1. Immediate Notification',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              icon: const Icon(Icons.notifications_active),
              label: const Text('Kirim Notifikasi Sekarang'),
              onPressed: () => controller.sendInstantNotif(
                'Halo!',
                'Ini immediate notification.',
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              '2. Scheduled Notification (+1 Menit)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              icon: const Icon(Icons.alarm),
              label: const Text('Set Reminder 1 Menit Lagi'),
              onPressed: () {
                final targetTime =
                    DateTime.now().add(const Duration(minutes: 1));
                controller.scheduleNotif(
                  id: 1,
                  title: 'Reminder!',
                  body: 'Sudah waktunya cek aplikasi.',
                  scheduledTime: targetTime,
                );
              },
            ),
            const SizedBox(height: 24),
            const Text(
              '3. Location-Based Services (GPS)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Obx(() => ElevatedButton.icon(
                  icon: const Icon(Icons.my_location),
                  label: const Text('Cek Lokasi Saya'),
                  onPressed: controller.isLoadingLocation.value
                      ? null
                      : controller.fetchLocation,
                )),
            const SizedBox(height: 12),
            Obx(() {
              if (controller.isLoadingLocation.value) {
                return const Center(child: CircularProgressIndicator());
              }
              final pos = controller.currentPosition.value;
              if (pos == null) {
                return const Text('Lokasi belum diambil.');
              }
              final meters = LbsService.distanceInMeters(
                pos.latitude,
                pos.longitude,
                _targetLat,
                _targetLng,
              );
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Lat: ${pos.latitude.toStringAsFixed(5)}'),
                      Text('Lng: ${pos.longitude.toStringAsFixed(5)}'),
                      const SizedBox(height: 4),
                      Text(
                        'Jarak ke Kampus: ${meters.toStringAsFixed(0)} m',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
