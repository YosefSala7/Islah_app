import 'package:equatable/equatable.dart';

sealed class AudioState extends Equatable {
  final int? currentSurah;
  final int? currentAyah;
  final String? reciter;
  final bool isPlaying;
  final bool isLoading;
  final Duration position;
  final Duration? duration;
  final String? error;

  const AudioState({
    this.currentSurah,
    this.currentAyah,
    this.reciter,
    this.isPlaying = false,
    this.isLoading = false,
    this.position = const Duration(),
    this.duration,
    this.error,
  });

  @override
  List<Object?> get props => [currentSurah, currentAyah, reciter, isPlaying, isLoading, position, duration, error];
}

class InitialState extends AudioState {
  const InitialState() : super();
}

class LoadingState extends AudioState {
  const LoadingState() : super(isLoading: true);
}

class PlayingState extends AudioState {
  const PlayingState({
    required super.currentSurah,
    required super.currentAyah,
    required super.reciter,
    required super.position,
    required super.duration,
  }) : super(isPlaying: true);
}

class PausedState extends AudioState {
  const PausedState({
    required super.currentSurah,
    required super.currentAyah,
    required super.reciter,
    required super.position,
    required super.duration,
  }) : super(isPlaying: false);
}

class StoppedState extends AudioState {
  const StoppedState() : super(isPlaying: false);
}

class ErrorState extends AudioState {
  const ErrorState({required super.error});
}
