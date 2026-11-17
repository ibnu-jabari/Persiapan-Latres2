import 'package:geolocator/geolocator.dart';

// =============================================================================
// LBS (LOCATION-BASED SERVICES) - MODUL 7 (hal. 142, 145-146)
// Syarat Android:
// - AndroidManifest.xml -> ACCESS_FINE_LOCATION & ACCESS_COARSE_LOCATION
// =============================================================================

class LbsService {
  // Cek GPS aktif + minta permission + ambil posisi terkini
  static Future<Position> getCurrentPosition() async {
    // 1. Cek apakah GPS aktif
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('GPS tidak aktif.');
    }

    // 2. Cek dan minta permission
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Permission lokasi ditolak.');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      throw Exception('Permission lokasi diblokir permanen.');
    }

    // 3. Ambil koordinat (latitude & longitude)
    return await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
    );
  }

  // Hitung jarak dalam meter antara 2 koordinat (Modul 7 hal. 145-146)
  static double distanceInMeters(
    double startLat,
    double startLng,
    double endLat,
    double endLng,
  ) {
    return Geolocator.distanceBetween(startLat, startLng, endLat, endLng);
  }
}
