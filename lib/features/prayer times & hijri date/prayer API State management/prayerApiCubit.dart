import 'package:app/features/prayer%20times%20&%20hijri%20date/prayer%20API%20State%20management/prayerApiState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PrayerApiCubit extends Cubit<PrayerApiState> {
  PrayerApiCubit():super(PrayerLoading());
  void getData(){
    
  }

}