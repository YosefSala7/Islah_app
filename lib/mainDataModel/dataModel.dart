import 'package:app/features/prayer%20times%20&%20hijri%20date/models/hijriDateModel.dart';
import 'package:app/features/prayer%20times%20&%20hijri%20date/models/prayerTimesModel.dart';

class DataModel {
  final int code;
  final String status;
  final PrayerTimesModel times;
  final HijriModel hijri;

  DataModel({
    required this.times,
    required this.hijri, required this.code, required this.status,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      times: PrayerTimesModel.fromJson(json['times']),
      hijri: HijriModel.fromJson(json['date']['hijri']),
      code: 0,
      status: '',
    );
  }
}