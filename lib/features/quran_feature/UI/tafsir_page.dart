import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:qcf_quran_lite/qcf_quran_lite.dart' as quran;
import 'package:tafsir_library/tafsir_library.dart';

class TafsirPage extends StatelessWidget {
  TafsirPage({
    super.key,
    required this.currentPage,
    required this.surahNumber,
    required this.verseNumber,
  });
  int surahNumber;
  int verseNumber;
  int currentPage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: ShowTafsir(
          context: context,
          surahNumber: surahNumber,
          ayahNumber: verseNumber,
          ayahUQNumber: getAyahUQNumber(
            surahNumber: surahNumber,
            ayahNumber: verseNumber,
          ),
          tafsirStyle: TafsirStyle(
            tafsirIsEmptyNote: "لا يوجد محتوى متاح لهذا التفسير حالياً.",
            tajweedSurahNumberErrorText: "خطأ في تحديد رقم السورة.",
            tajweedUnavailableText: "خدمة التجويد غير متوفرة لهذا النص.",
            tajweedDownloadText: "تحميل بيانات التجويد",
            tajweedDownloadingText: "جاري تحميل بيانات التجويد...",
            tajweedLoadErrorText: "حدث خطأ أثناء تحميل بيانات التجويد.",
            tajweedNoDataText: "لا توجد بيانات تجويد متاحة.",
            footnotesName: "الحواشي والهوامش",
            tafsirName: "كتاب التفسير",
            tajweedName: "أحكام التجويد",
            fontSizeSemanticsLabel: "شريط التحكم في حجم خط التفسير",

            changeTafsirSemanticsLabel: "زر تغيير كتاب التفسير الحالي",
            dialogHeaderTitle: "اختر كتاب التفسير",
            dialogHeaderTitleColor: Colors.white,
            dialogCloseIconColor: Colors.white,
            dialogCloseTooltipText: "إغلاق القائمة",
            dialogHeaderBackgroundGradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.secondary,
              ],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
            changeTafsirDialogHeight: 400.0,
            changeTafsirDialogWidth: 320.0,
            widthOfBottomSheet: double.infinity,

            fontSizeIconWidget: const Icon(Icons.format_size),
            fontSizeIconSize: 24.0,
            backButtonWidget: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back),
            ),
            withBackButton: true,

            ayahNameText: "verse".tr(),
            translateName: "tr".tr(),
            horizontalMargin: 16.0,
            verticalMargin: 1.0,

            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            tafsirBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
            accentColor: Theme.of(context).colorScheme.primary,
            dividerColor: Theme.of(context).colorScheme.primary,
            textTitleColor: Theme.of(context).textTheme.bodyMedium!.color,
            downloadIconColor: Theme.of(context).iconTheme.color,
            textColor: Theme.of(context).textTheme.bodyMedium!.color,
            controlsBackgroundColor: Theme.of(context).colorScheme.secondary,
            controlsBorderColor: Theme.of(context).colorScheme.secondary,
            fontSizeBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
            fontSizeActiveTrackColor: Theme.of(context).colorScheme.primary,
            fontSizeInactiveTrackColor: Theme.of(context).colorScheme.secondary,
            fontSizeThumbColor: Theme.of(context).iconTheme.color,
            fontSizeIconColor: Theme.of(context).iconTheme.color,

            tabBarBackgroundColor: Theme.of(context).colorScheme.secondary.withAlpha(60),
            tabBarIndicatorColor: Theme.of(context).colorScheme.secondary,
            tabBarLabelColor: Theme.of(context).textTheme.bodyMedium!.color,
            tabBarUnselectedLabelColor: Theme.of(
              context,
            ).colorScheme.primary,
            tabBarLabelStyle: Theme.of(context).textTheme.bodyMedium,

            currentTafsirColor: Theme.of(context).textTheme.bodyMedium!.color,
            backgroundTitleColor: Theme.of(context).colorScheme.secondary,
            selectedTafsirBorderColor: Theme.of(context).colorScheme.primary,
            selectedTafsirColor: Theme.of(context).colorScheme.primary,
            selectedTafsirTextColor: Theme.of(
              context,
            ).textTheme.bodyMedium!.color,
            unSelectedTafsirBorderColor: Theme.of(
              context,
            ).colorScheme.secondary,
            unSelectedTafsirColor: Theme.of(context).colorScheme.primary,
            unSelectedTafsirTextColor: Theme.of(context).textTheme.bodyLarge!.color!.withAlpha(180),

            tajweedAyahTextStyle: Theme.of(
              context,
            ).textTheme.bodyLarge!.copyWith(fontFamily: "Hafs", fontSize: 25),
            tajweedMarkedTextStyle: TextStyle(
              fontFamily: "Hafs",
              fontSize: 22,
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
            tajweedStatusTextStyle: Theme.of(context).textTheme.bodySmall,
            tajweedButtonTextStyle: Theme.of(context).textTheme.labelLarge,
            tajweedProgressTextStyle: Theme.of(context).textTheme.bodyMedium,
            tajweedContentTextStyle: Theme.of(context).textTheme.bodyMedium,
          ),
          pageIndex: currentPage,
          isDark: Theme.of(context).brightness == Brightness.dark,
        ),
      ),
    );
  }
}

int getAyahUQNumber({required int surahNumber, required int ayahNumber}) {
  int totalPreviousAyahs = 0;
  for (int i = 1; i < surahNumber; i++) {
    totalPreviousAyahs += quran.getVerseCount(i);
  }
  return totalPreviousAyahs + ayahNumber;
}
