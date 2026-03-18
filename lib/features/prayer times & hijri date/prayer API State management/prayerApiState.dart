import 'package:app/mainDataModel/dataModel.dart';
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

  PrayerError({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}