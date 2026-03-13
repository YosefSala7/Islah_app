class HijriModel {
  final String date;
  final String day;
  final String month;
  final String year;

  HijriModel({
    required this.date,
    required this.day,
    required this.month,
    required this.year,
  });

  factory HijriModel.fromJson(Map<String, dynamic> json) {
    return HijriModel(
      date: json['date'],
      day: json['day'],
      month: json['month']['ar'],
      year: json['year'],
    );
  }
}