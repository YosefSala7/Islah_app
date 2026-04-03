import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
class PrayerTimeState extends Equatable {
  final String currentTime;
  final Map nextPrayer;

  const PrayerTimeState(this.currentTime, this.nextPrayer);

  @override
  List<Object?> get props => [currentTime, nextPrayer];
}

class PrayerTimeInit extends PrayerTimeState {
  PrayerTimeInit() : super(DateFormat('hh:mm:ss a').format(DateTime.now()), {});
}

class PrayerTimeUpdate extends PrayerTimeState {
  const PrayerTimeUpdate(super.time, super.next);
}