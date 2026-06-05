import 'package:google_mobile_ads/google_mobile_ads.dart';

class AfterAzkarAd {
  static InterstitialAd? _interstitialAd;

  static void loadInterstitial() {
    InterstitialAd.load(
      ///real unitID "ca-app-pub-2328935650503813/8196646253"
      adUnitId: 'ca-app-pub-2328935650503813/8196646253',
      /// testID ca-app-pub-3940256099942544/1033173712
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          print("الإعلان اتحمل وجاهز ✅");
        },
        onAdFailedToLoad: (error) {
          _interstitialAd = null;
          print("فشل التحميل: $error");
        },
      ),
    );
  }

  static void showInterstitial(Function nextStep) {
    if (_interstitialAd != null) {
      _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          ad.dispose();
          _interstitialAd = null;
          loadInterstitial();
          nextStep();
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          ad.dispose();
          _interstitialAd = null;
          loadInterstitial();
          nextStep();
        },
      );
      _interstitialAd!.show();
    } else {
      nextStep();
      loadInterstitial();
    }
  }

  static void dispose() {
    _interstitialAd?.dispose();
    _interstitialAd = null;
    print("تم تنظيف ذاكرة الإعلانات بنجاح 🧹");
  }
}
