import 'package:app/ads/after_azkar_ad.dart';
import 'package:app/core/components/appBar.dart';
import 'package:app/features/azkar_feature/UI/category_card.dart';
import 'package:app/features/azkar_feature/UI/tasbih_page.dart';
import 'package:app/features/azkar_feature/UI/zekr_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:islamic_azkar/islamic_azkar.dart';

class AzkarPage extends StatefulWidget {
  AzkarPage({super.key});

  @override
  State<AzkarPage> createState() => _AzkarPageState();
}

class _AzkarPageState extends State<AzkarPage> {
  List azkarCategories = ZekrCategory.values;
  @override
  void initState() {
    super.initState();
    AfterAzkarAd.loadInterstitial();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: SizedBox(
                width: double.infinity,
                child: Image.asset(
                  "assets/imgs/background.webp",
                  fit: BoxFit.cover,
                  color: Theme.of(context).textTheme.bodyLarge!.color!,
                ),
              ),
            ),
            CustomScrollView(
              physics: BouncingScrollPhysics(),
              slivers: [
                MyAppBar(title: "Azkar".tr(),themeData: Theme.of(context),),
                SliverList.builder(
                  itemCount: azkarCategories.length,
                  itemBuilder: (context, index) {
                    final cat = ZekrCategory.values[index];
                    final azkarService = IslamicAzkarService();
                    final count = azkarService.getAzkarByCategory(cat).length;
                    String title = "";
                    String icon = "";

                    switch (cat) {
                      case ZekrCategory.morning:
                        title = "أذكار الصباح";
                        icon = "assets/imgs/morningAzkar.webp";
                        break;
                      case ZekrCategory.evening:
                        title = "أذكار المساء";
                        icon = "assets/imgs/eveningAzkar.webp";
                        break;
                      case ZekrCategory.eating:
                        title = "أذكار الطعام";
                        icon = "assets/imgs/foodAzkar.webp";
                        break;
                      case ZekrCategory.mosque:
                        title = "أذكار المسجد";
                        icon = "assets/imgs/mosquAzkar.webp";
                        break;
                      case ZekrCategory.house:
                        title = "أذكار المنزل";
                        icon = "assets/imgs/homeAzkar.webp";
                        break;
                      case ZekrCategory.wakingUp:
                        title = "أذكار الاستيقاظ";
                        icon = "assets/imgs/wakingupAzkar.webp";
                        break;
                      case ZekrCategory.protection:
                        title = "أذكار التحصين";
                        icon = "assets/imgs/savingAzkar.webp";
                        break;
                      case ZekrCategory.travel:
                        title = "أذكار السفر";
                        icon = "assets/imgs/travellingAzkar.webp";
                        break;
                      case ZekrCategory.prayerSupplications:
                        title = "أدعية الصلاة";
                        icon = "assets/imgs/prayerAzkar.webp";
                        break;
                      case ZekrCategory.wudu:
                        title = "أذكار الوضوء";
                        icon = "assets/imgs/wdoaAzkar.webp";
                        break;
                      case ZekrCategory.nature:
                        title = "أذكار الطبيعة";
                        icon = "assets/imgs/natureAzkar.webp";
                        break;
                      case ZekrCategory.fasting:
                        title = "أذكار الصيام";
                        icon = "assets/imgs/syamAzkar.webp";
                        break;
                      case ZekrCategory.emotions:
                        title = "أذكار الضيق والفرج";
                        icon = "assets/imgs/plessingAzkar.webp";
                        break;
                    }
                    return AzkarCategoryCard(
                      count: count.toString(),
                      title: title,
                      icon: icon,
                      onTap: () {
                        Navigator.of(context, rootNavigator: true).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return ZekrPage(
                                azkar: azkarService.getAzkarByCategory(cat),
                                category: cat,
                              );
                            },
                          ),
                        );
                      },
                    );
                  },
                ),
                SliverToBoxAdapter(
                  child: AzkarCategoryCard(
                    title: "tasbih".tr(),
                    count: "",
                    icon: "assets/imgs/tasbihIcon.webp",
                    onTap: () {
                      Navigator.of(context, rootNavigator: true).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return TasbihPage();
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
