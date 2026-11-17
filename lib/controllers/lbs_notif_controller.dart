import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import '../services/lbs_service.dart';
import '../services/notification_service.dart';

// =============================================================================
// LBS & NOTIF CONTROLLER - MODUL 7 (Plug-and-Play dengan GetX)
// Pakai jika soal responsi meminta fitur Notifikasi (Immediate/Scheduled) atau GPS.
// =============================================================================

class LbsNotifController extends GetxController {
  final Rx<Position?> currentPosition = Rx<Position?>(null);
  final RxBool isLoadingLocation = false.obs;

  Future<void> sendInstantNotif(String title, String body) async {
    await NotificationService().showInstantNotification(
      title: title,
      body: body,
    );
    Get.snackbar('Notifikasi', 'Notifikasi langsung dikirim!');
  }

  Future<void> scheduleNotif({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledTime,
  }) async {
    await NotificationService().scheduleNotification(
      id: id,
      title: title,
      body: body,
      scheduledTime: scheduledTime,
    );
    Get.snackbar('Reminder', 'Notifikasi dijadwalkan!');
  }

  Future<void> fetchLocation() async {
    try {
      isLoadingLocation.value = true;
      currentPosition.value = await LbsService.getCurrentPosition();
    } catch (e) {
      Get.snackbar('Lokasi Error', e.toString());
    } finally {
      isLoadingLocation.value = false;
    }
  }
}
