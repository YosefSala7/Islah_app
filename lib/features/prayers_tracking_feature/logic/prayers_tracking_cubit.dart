import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'prayers_tracking_state.dart';

class PrayersTrackingCubit extends Cubit<PrayersTrackingState> {
  static const String _prefsKey = 'prayers_tracking_data';
  
  PrayersTrackingCubit() : super(const PrayersTrackingInitial());

  Future<void> loadPrayers(List<Map<String, dynamic>> basePrayers) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? storedJson = prefs.getString(_prefsKey);
      
      List<Map<String, dynamic>> prayers = List<Map<String, dynamic>>.from(basePrayers.map((p) => Map<String, dynamic>.from(p)));
      
      if (storedJson != null) {
        final Map<String, dynamic> storedData = json.decode(storedJson);
        final String? lastResetDate = storedData['lastResetDate'];
        final List<dynamic>? storedStatuses = storedData['statuses']; // Changed to statuses
        
        if (storedStatuses != null && lastResetDate != null) {
          final today = DateTime.now().toIso8601String().split('T')[0]; // YYYY-MM-DD
          
          if (today == lastResetDate && storedStatuses.length == prayers.length) {
            // Same day, restore statuses
            for (int i = 0; i < prayers.length; i++) {
              prayers[i]['isDoneToday'] = storedStatuses[i]['isDoneToday'] ?? false;
            }
          } else {
            // New day, reset
            _resetStatuses(prayers);
          }
        } else {
          _resetStatuses(prayers);
        }
      } else {
        _resetStatuses(prayers);
      }
      
      emit(PrayersTrackingLoaded(prayers));
    } catch (e) {
      // Fallback to base with all false
      final prayers = List<Map<String, dynamic>>.from(basePrayers.map((p) => Map<String, dynamic>.from(p)));
      _resetStatuses(prayers);
      emit(PrayersTrackingLoaded(prayers));
    }
  }

  Future<void> togglePrayer(int index, String prayerTimeStr) async {
    final currentState = state;
    if (currentState is! PrayersTrackingLoaded) return;

    final prayers = List<Map<String, dynamic>>.from(currentState.prayers.map((p) => Map<String, dynamic>.from(p)));
    
    if (index < 0 || index >= prayers.length) return;
    
    // Check if prayer time has passed
    final now = DateTime.now();
    final timeParts = prayerTimeStr.split(':');
    if (timeParts.length != 2) return;
    
    final hour = int.tryParse(timeParts[0]) ?? 0;
    final minute = int.tryParse(timeParts[1]) ?? 0;
    final prayerDt = DateTime(now.year, now.month, now.day, hour, minute);
    
    if (now.isBefore(prayerDt)) {
      return;
    }
    
    prayers[index]['isDoneToday'] = !(prayers[index]['isDoneToday'] ?? false);
    
    await _saveData(prayers);
    emit(PrayersTrackingLoaded(prayers));
  }

  void _resetStatuses(List<Map<String, dynamic>> prayers) {
    for (var prayer in prayers) {
      prayer['isDoneToday'] = false;
    }
  }

  Future<void> _saveData(List<Map<String, dynamic>> prayers) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final today = DateTime.now().toIso8601String().split('T')[0];
      final saveStatuses = prayers.map((p) => {'isDoneToday': p['isDoneToday'] ?? false}).toList();
      final data = {
        'lastResetDate': today,
        'statuses': saveStatuses, // Save only statuses, not full prayers (avoid IconData serialization)
      };
      await prefs.setString(_prefsKey, json.encode(data));
    } catch (e) {
      // Log error for debug
    }
  }
}
