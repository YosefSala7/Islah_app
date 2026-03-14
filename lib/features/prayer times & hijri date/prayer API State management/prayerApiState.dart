import 'package:app/features/prayer%20times%20&%20hijri%20date/models/prayerTimesModel.dart';
import 'package:equatable/equatable.dart';
sealed class PrayerApiState extends Equatable {}

class PrayerLoading extends PrayerApiState {
  @override
  List<Object?> get props => [];
}

class PrayerLoaded extends PrayerApiState {
  final PrayerTimesModel times;

  PrayerLoaded({required this.times});

  @override
  List<Object?> get props => [times];
}

class PrayerError extends PrayerApiState {
  final String errorMessage;

  PrayerError({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}