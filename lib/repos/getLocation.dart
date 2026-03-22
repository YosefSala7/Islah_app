import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Position> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }
  
  if (permission == LocationPermission.deniedForever) {
    return Future.error(
      'Location permissions are permanently denied, we cannot request permissions.');
  } 

  Position position = await Geolocator.getCurrentPosition();
  
  await saveLocation(position.latitude, position.longitude);
  
  return position;
}


Future<void> saveLocation(double latitude, double longitude) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setDouble('latitude', latitude);
  await prefs.setDouble('longitude', longitude);
}

Future<Map<String, double>?> getLocation() async {
  final prefs = await SharedPreferences.getInstance();
  final lat = prefs.getDouble('latitude');
  final lon = prefs.getDouble('longitude');
  if (lat == null || lon == null) return null;
  return {'latitude': lat, 'longitude': lon};
}