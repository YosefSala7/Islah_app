import 'package:app/ads/ad_helper.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AppOpenAdService {
  AppOpenAd? _appOpenAd;

  void loadAd() {
    AppOpenAd.load(
      adUnitId: AdHelper.appOpenAdUnitId, 
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          _appOpenAd = ad;
          print("تم تحميل الإعلان بنجاح!");
          showAd(); 
        },
        onAdFailedToLoad: (error) {
          print("فشل تحميل الإعلان: $error");
        },
      ),
    );
  }

  void showAd() {
    if (_appOpenAd != null) {
      _appOpenAd!.show();
    }
  }
}