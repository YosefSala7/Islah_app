import 'package:app/features/prayer%20times%20&%20hijri%20date/logic/prayerApiState.dart';
import 'package:app/features/prayer%20times%20&%20hijri%20date/data/Models/dataModel.dart';
import 'package:app/features/prayer%20times%20&%20hijri%20date/data/repos/fetchPrayerTimesAPI.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PrayerApiCubit extends Cubit<PrayerApiState> {
  PrayerApiCubit():super(PrayerLoading());
  
Future<void> getData() async {
  try {
    Welcome? response = await getPrayerTimes();
    emit(PrayerLoaded(apiData: response!.data));
  } catch (e) {
    final offlineData = await getCachedBody();
    emit(PrayerError(errorMessage: "فشل جلب البيانات: ${e.toString()}",cachedDate: welcomeFromJson(offlineData!)));
  }
}
}