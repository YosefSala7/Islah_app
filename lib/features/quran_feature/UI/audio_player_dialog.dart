import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/features/quran_feature/logic/audio/audio_cubit.dart';
import 'package:app/features/quran_feature/logic/audio/audio_state.dart';
import 'package:quran/quran.dart' as quran;

class AudioPlayerDialog extends StatelessWidget {
  const AudioPlayerDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioCubit, AudioState>(
      builder: (context, state) {
        final surah = state.currentSurah;
        final ayah = state.currentAyah;
        final isPlaying = state.isPlaying;

        String ayahText = (surah != null && ayah != null)
            ? 'الآية $ayah - ${quran.getSurahNameArabic(surah)}'
            : 'جاري التحميل...';

        if (state.error != null) {
          Future.delayed(Duration.zero, () {
            if (context.mounted) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('حدث خطأ في تشغيل الآية...تأكد من اتصالك بالنترنت')),
              );
            }
          });
          return const SizedBox.shrink(); 
        }

        return Stack(
          children: [
            Container(
              height: 120,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    ayahText,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: () => context.read<AudioCubit>().prevAyah(),
                        icon: const Icon(Icons.skip_previous),
                      ),
                      IconButton(
                        onPressed: () => isPlaying
                            ? context.read<AudioCubit>().pause()
                            : context.read<AudioCubit>().resume(),
                        icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                        iconSize: 30,
                        color: Theme.of(context).dividerColor,
                      ),
                      IconButton(
                        onPressed: () => context.read<AudioCubit>().nextAyah(),
                        icon: const Icon(Icons.skip_next),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                onPressed: () {
                  try {
                    context.read<AudioCubit>().stop();
                  } catch (e) {
                    print('Stop error: $e');
                  }
                  try {
                    context.read<AudioCubit>().pause();
                  } catch (e) {
                    print('Pause error: $e');
                  }
                  Navigator.pop(context);
                },

                icon: Icon(
                  Icons.close,
                  color: Theme.of(context).colorScheme.primary,
                  size: 30,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  String formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  // Usage function
  void showAudioPlayerDialog(
    BuildContext context, {
    required int surah,
    required int ayah,
  }) {
    final cubit = context.read<AudioCubit>();
    cubit.playAudio(surah, ayah, "Minshawi");
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) =>
          BlocProvider.value(value: cubit, child: const AudioPlayerDialog()),
    );
  }
}
