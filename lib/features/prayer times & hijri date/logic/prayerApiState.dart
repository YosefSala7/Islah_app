import 'package:app/features/prayer%20times%20&%20hijri%20date/data/Models/dataModel.dart';
import 'package:equatable/equatable.dart';
sealed class PrayerApiState extends Equatable {}

class PrayerLoading extends PrayerApiState {
  @override
  List<Object?> get props => [];
}

class PrayerLoaded extends PrayerApiState {
  final Data apiData;

  PrayerLoaded({required this.apiData});

  @override
  List<Object?> get props => [apiData];
}

class PrayerError extends PrayerApiState {
  final String errorMessage;
  final Welcome? cachedDate ;

  PrayerError({required this.errorMessage,required this.cachedDate});

@override
  List<Object?> get props => [errorMessage, cachedDate];
}