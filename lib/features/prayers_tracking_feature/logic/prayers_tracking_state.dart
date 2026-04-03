import 'package:equatable/equatable.dart';

abstract class PrayersTrackingState extends Equatable {
  const PrayersTrackingState();

  @override
  List<Object?> get props => [];
}

class PrayersTrackingInitial extends PrayersTrackingState {
  const PrayersTrackingInitial();
}

class PrayersTrackingLoaded extends PrayersTrackingState {
  final List<Map<String, dynamic>> prayers;

  const PrayersTrackingLoaded(this.prayers);

  @override
  List<Object?> get props => [prayers];
}
