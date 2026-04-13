import 'package:app/features/prayer%20times%20&%20hijri%20date/data/repos/getLocation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<List<Placemark>> getGeoLocation() async {
  Map<String, double>? location = await getLocation();
  if (location != null) {
    List<Placemark> placemarks = await placemarkFromCoordinates(
      location["latitude"]!,
      location["longitude"]!,
    );
    saveGeolocation(placemarks);
    return placemarks;
  } else {
    return [];
  }
}

Future<void> saveGeolocation(List<Placemark> placemarks) async {
  if (placemarks.isEmpty) return;

  final prefs = await SharedPreferences.getInstance();
  final place = placemarks[0];

  await prefs.setString('city_name', place.locality ?? "");
  await prefs.setString('sub_city', place.subLocality ?? "");
  await prefs.setString('governorate', place.administrativeArea ?? "");
}

Future<Map<String, String>?> getGeolocationFromCache() async {
  final prefs = await SharedPreferences.getInstance();

  final cityName = prefs.getString('city_name') ?? "";
  final subCity = prefs.getString('sub_city') ?? "";
  final governorate = prefs.getString('governorate') ?? "";

  if (cityName.isEmpty && governorate.isEmpty) return null;

  return {'cityName': cityName, 'subCity': subCity, 'governorate': governorate};
}
