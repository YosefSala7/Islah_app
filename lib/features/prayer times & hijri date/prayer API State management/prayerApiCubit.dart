import 'package:app/features/prayer%20times%20&%20hijri%20date/prayer%20API%20State%20management/prayerApiState.dart';
import 'package:app/mainDataModel/dataModel.dart';
import 'package:app/repos/fetchPrayerTimesAPI.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PrayerApiCubit extends Cubit<PrayerApiState> {
  PrayerApiCubit():super(PrayerLoading());
  
Future<void> getData() async {
  try {
    Welcome? response = await getPrayerTimes();
    emit(PrayerLoaded(apiData: response!.data));
  } catch (e) {
    emit(PrayerError(errorMessage: "فشل جلب البيانات: ${e.toString()}"));
  }
}
}