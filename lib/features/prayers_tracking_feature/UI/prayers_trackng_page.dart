import 'package:app/features/prayer times & hijri date/logic/prayerTimeCubit.dart';
import 'package:app/features/prayers_tracking_feature/UI/current_prayer_container.dart';
import 'package:app/features/prayers_tracking_feature/UI/prayer_card.dart';
import 'package:app/features/prayers_tracking_feature/logic/prayers_tracking_cubit.dart';
import 'package:app/features/prayers_tracking_feature/logic/prayers_tracking_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PrayersTrackngPage extends StatelessWidget {
  const PrayersTrackngPage({super.key, required this.prayers});
  final List<Map<String, dynamic>> prayers;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => PrayerTimeCubit(prayers)),
        BlocProvider(
          create: (context) => PrayersTrackingCubit()..loadPrayers(prayers),
        ),
      ],
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: SafeArea(
                child: Stack(
                  children: [
                    CurrentPrayerContainer(),
                    Positioned(
                      top: MediaQuery.of(context).size.height / 3,
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.all(16.0),
                        child:
                            BlocBuilder<
                              PrayersTrackingCubit,
                              PrayersTrackingState
                            >(
                              builder: (context, state) {
                                if (state is PrayersTrackingInitial) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                final trackingPrayers =
                                    (state as PrayersTrackingLoaded).prayers;
                                return ListView.separated(
                                  itemCount: trackingPrayers.length,
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(height: 12),
                                  itemBuilder: (context, index) {
                                    final prayer = trackingPrayers[index];
                                    int delay = index * 180;
                                    return PrayerCard(
                                          prayer: prayer['name'],
                                          prayerTime: prayer['time'],
                                          prayerIcon: prayer['icon'],
                                          prayerImg: prayer['img'],
                                          prayerState:
                                              prayer['isDoneToday'] ?? false,
                                          onToggle: () => context
                                              .read<PrayersTrackingCubit>()
                                              .togglePrayer(
                                                index,
                                                prayer['time'],
                                              ),
                                        )
                                        .animate(delay: delay.ms)
                                        .slideY(
                                          begin: 1.0,
                                          end: 0.0,
                                          duration: 1000.ms,
                                          curve: Curves.easeInOut,
                                        )
                                        .fadeIn(duration: 1000.ms);
                                  },
                                );
                              },
                            ),
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
