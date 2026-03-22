import 'package:app/mainDataModel/dataModel.dart';
import 'package:app/repos/getLocation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<Welcome>getPrayerTimes()async{
  final location = await getLocation();
  String apiUrl = dotenv.env['API_KEY']!;
  double lat = location!['latitude']!;
  double lon = location['longitude']!;

  var url = Uri.https(
    'islamicapi.com',
    '/api/v1/prayer-time',
    {
      "lat": lat.toString(),
      "lon": lon.toString(),
      "method": "5",
      "school": "1",
      "api_key": apiUrl,
    },
  );

  var response = await http.get(url);

  return welcomeFromJson(response.body);
}
