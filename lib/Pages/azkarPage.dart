import 'package:app/ads/after_azkar_ad.dart';
import 'package:app/core/components/appBar.dart';
import 'package:app/features/azkar_feature/UI/category_card.dart';
import 'package:app/features/azkar_feature/UI/tasbih_page.dart';
import 'package:app/features/azkar_feature/UI/zekr_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
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
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            MyAppBar(title: "Azkar".tr()),
            SliverList.builder(
              itemCount: azkarCategories.length,
              itemBuilder: (context, index) {
                final cat = ZekrCategory.values[index];
                final azkarService = IslamicAzkarService();
                final count = azkarService.getAzkarByCategory(cat).length;
                String title = "";
                IconData icon = Icons.book;

                switch (cat) {
                  case ZekrCategory.morning:
                    title = "أذكار الصباح";
                    icon = CupertinoIcons.sun_max_fill;
                    break;
                  case ZekrCategory.evening:
                    title = "أذكار المساء";
                    icon = CupertinoIcons.moon_stars_fill;
                    break;
                  case ZekrCategory.eating:
                    title = "أذكار الطعام";
                    icon = Icons.restaurant_menu;
                    break;
                  case ZekrCategory.mosque:
                    title = "أذكار المسجد";
                    icon = Icons.mosque;
                    break;
                  case ZekrCategory.house:
                    title = "أذكار المنزل";
                    icon = CupertinoIcons.house_fill;
                    break;
                  case ZekrCategory.wakingUp:
                    title = "أذكار الاستيقاظ";
                    icon = CupertinoIcons.alarm_fill;
                    break;
                  case ZekrCategory.protection:
                    title = "أذكار التحصين";
                    icon = CupertinoIcons.shield_fill;
                    break;
                  case ZekrCategory.travel:
                    title = "أذكار السفر";
                    icon = CupertinoIcons.airplane;
                    break;
                  case ZekrCategory.prayerSupplications:
                    title = "أدعية الصلاة";
                    icon = CupertinoIcons.book_fill;
                    break;
                  case ZekrCategory.wudu:
                    title = "أذكار الوضوء";
                    icon = CupertinoIcons.drop_fill;
                    break;
                  case ZekrCategory.nature:
                    title = "أذكار الطبيعة";
                    icon = CupertinoIcons.cloud_sun_fill;
                    break;
                  case ZekrCategory.fasting:
                    title = "أذكار الصيام";
                    icon = Icons.nights_stay;
                    break;
                  case ZekrCategory.emotions:
                    title = "أذكار الضيق والفرج";
                    icon = CupertinoIcons.heart_fill;
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
                icon: FlutterIslamicIcons.solidTasbih,
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
      ),
    );
  }
}
