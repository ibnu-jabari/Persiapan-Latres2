import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

// =============================================================================
// NOTIFICATION SERVICE - MODUL 7 (hal. 133-135)
// Syarat Android:
// - android/app/build.gradle.kts -> isCoreLibraryDesugaringEnabled = true + dependency desugar_jdk_libs
// - android/app/src/main/AndroidManifest.xml -> permission & 3 <receiver>
// - main.dart -> await NotificationService().init();
// =============================================================================

class NotificationService {
  // Singleton pattern (Modul 7 hal. 133)
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin notificationPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    // 1. Inisialisasi timezone
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Jakarta'));

    // 2. Konfigurasi Android
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initSettings =
        InitializationSettings(android: androidSettings);
    await notificationPlugin.initialize(initSettings);

    // 3. Request permission & buat notification channel
    final androidPlatform =
        notificationPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
    await androidPlatform?.requestNotificationsPermission();

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'reminder_channel',
      'Reminder Notifications',
      description: 'Channel untuk reminder notifikasi',
      importance: Importance.high,
    );
    await androidPlatform?.createNotificationChannel(channel);
  }

  // Immediate notification: muncul langsung saat dipanggil (Modul 7 hal. 134)
  Future<void> showInstantNotification({
    required String title,
    required String body,
  }) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'reminder_channel',
      'Reminder Notifications',
      importance: Importance.high,
      priority: Priority.high,
    );
    const NotificationDetails notifDetails =
        NotificationDetails(android: androidDetails);

    await notificationPlugin.show(0, title, body, notifDetails);
  }

  // Scheduled notification: muncul di waktu tertentu (Modul 7 hal. 134-135)
  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledTime,
  }) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'reminder_channel',
      'Reminder Notifications',
      importance: Importance.high,
      priority: Priority.high,
    );
    const NotificationDetails notifDetails =
        NotificationDetails(android: androidDetails);

    await notificationPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime(
        tz.local,
        scheduledTime.year,
        scheduledTime.month,
        scheduledTime.day,
        scheduledTime.hour,
        scheduledTime.minute,
      ),
      notifDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }
}
