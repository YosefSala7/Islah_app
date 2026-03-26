import 'package:app/features/prayer%20times%20&%20hijri%20date/data/Models/dataModel.dart';
import 'package:app/features/prayer%20times%20&%20hijri%20date/data/repos/getLocation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<Welcome?> getPrayerTimes() async {
  try {
    final location = await getLocation();
    
    if (location == null || location['latitude'] == null || location['longitude'] == null) {
      throw Exception("location_denied");
    }

    String? apiUrl = dotenv.env['API_KEY'];
    if (apiUrl == null) {
      return await _getFallbackData();
    }

    double lat = location['latitude']!;
    double lon = location['longitude']!;

    var url = Uri.https('islamicapi.com', '/api/v1/prayer-time', {
      "lat": lat.toString(),
      "lon": lon.toString(),
      "method": "5",
      "school": "1",
      "api_key": apiUrl,
    });

    var response = await http.get(url).timeout(const Duration(seconds: 10));

    if (response.statusCode == 200) {
      await saveApiData(response.body);
      return welcomeFromJson(response.body);
    } else {
      return await _getFallbackData();
    }
  } catch (e) {
    return await _getFallbackData();
  }
}

Future<Welcome?> _getFallbackData() async {
  final offlineData = await getCachedBody();
  if (offlineData != null) {
    return welcomeFromJson(offlineData);
  }
  return null;
}

Future<void> saveApiData(String responseBody) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('cached_body', responseBody);
}

Future<String?> getCachedBody() async {
  final prefs = await SharedPreferences.getInstance();
  String? savedBody = prefs.getString('cached_body');
  if (savedBody != null) {
    return savedBody;
  }
  return null;
}
