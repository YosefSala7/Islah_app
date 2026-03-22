import 'package:easy_localization/easy_localization.dart';

extension ArabicConversion on String {
  String get toAr => replaceAll('0', '٠')
      .replaceAll('1', '١')
      .replaceAll('2', '٢')
      .replaceAll('3', '٣')
      .replaceAll('4', '٤')
      .replaceAll('5', '٥')
      .replaceAll('6', '٦')
      .replaceAll('7', '٧')
      .replaceAll('8', '٨')
      .replaceAll('9', '٩')
      .replaceAll('AM', "ص")
      .replaceAll("PM", "م");
}

String format12hours(String t) {
  List<String> time = t.split(':');
  int hour = int.parse(time[0]);
  String period = hour >= 12 ? "prayer_times.pm".tr() : "prayer_times.am".tr();
  int h12 = hour % 12;
  if (h12 == 0) h12 = 12;
  String hourStr = h12.toString().padLeft(2, '0');
  return "$hourStr:${time[1]} $period";
}
