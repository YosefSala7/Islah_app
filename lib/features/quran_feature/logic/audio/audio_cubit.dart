import 'package:app/features/quran_feature/logic/audio/audio_state.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/quran.dart' as quran;

class AudioCubit extends Cubit<AudioState> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  int? _currentSurah;
  int? _currentAyah;
  String _reciter = 'Husary';
  Duration? _duration;
  Duration _position = Duration.zero;
  PlayerState? _playerState;

  AudioCubit() : super(const InitialState()) {
    _initListeners();
  }

  void _initListeners() {
    _audioPlayer.onPositionChanged.listen((position) {
      _position = position;
      _updateState();
    });

    _audioPlayer.onDurationChanged.listen((duration) {
      _duration = duration;
      _updateState();
    });

    _audioPlayer.onPlayerStateChanged.listen((state) {
      _playerState = state;
      if (state == PlayerState.completed) {
        _nextAyah();
      }
      _updateState();
    });
  }

  void _updateState() {
    final isPlaying = _playerState == PlayerState.playing;
    if (_currentSurah != null && _currentAyah != null && _duration != null) {
      emit(isPlaying
          ? PlayingState(
              currentSurah: _currentSurah!,
              currentAyah: _currentAyah!,
              reciter: _reciter,
              position: _position,
              duration: _duration!,
            )
          : PausedState(
              currentSurah: _currentSurah!,
              currentAyah: _currentAyah!,
              reciter: _reciter,
              position: _position,
              duration: _duration!,
            ));
    }
  }

  void _nextAyah() {
    nextAyah();
  }

  Future<void> playAudio(int surah, int verse, [String reciter = 'Husary']) async {
    try {
      emit(const LoadingState());
      _reciter = reciter.isEmpty ? 'Husary' : reciter;
      _currentSurah = surah;
      _currentAyah = verse;

      quran.Reciter? qReciter;
      switch (_reciter) {
        case 'Husary':
          qReciter = quran.Reciter.arHusary;
          break;
        case 'Minshawi':
          qReciter = quran.Reciter.arMinshawi;
          break;
        // Add more reciters as needed e.g. 'Minshawy': quran.Reciter.arMinshawyMujawwad
        default:
          qReciter = quran.Reciter.arHusary;
      }

      String url = quran.getAudioURLByVerse(surah, verse, reciter: qReciter);


      await _audioPlayer.stop(); // Stop previous
      await _audioPlayer.play(UrlSource(url));
    } catch (e) {
      await _audioPlayer.stop(); // Stop previous
      emit(ErrorState(error: 'خطأ في تشغيل الصوت: $e'));
    }
  }

  Future<void> pause() async {
    try {
      await _audioPlayer.pause();
    } catch (e) {
      return;
    }
  }



  Future<void> resume() async {
    await _audioPlayer.resume();
  }

  Future<void> stop() async {
    await _audioPlayer.stop();
    _currentSurah = null;
    _currentAyah = null;
    emit(const StoppedState());
  }

  Future<void> seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  Future<void> nextAyah() async {
    if (_currentSurah != null && _currentAyah != null) {
      final nextVerse = _currentAyah! + 1;
      // Simple: next ayah in same surah; handle end of surah later
      await playAudio(_currentSurah!, nextVerse, _reciter);
    }
  }

  Future<void> prevAyah() async {
    if (_currentSurah != null && _currentAyah != null && _currentAyah! > 1) {
      final prevVerse = _currentAyah! - 1;
      await playAudio(_currentSurah!, prevVerse, _reciter);
    }
  }

  @override
  Future<void> close() {
    _audioPlayer.dispose();
    return super.close();
  }
}