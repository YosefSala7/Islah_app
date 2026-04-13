import 'package:app/features/azkar_feature/UI/category_card.dart';
import 'package:app/features/azkar_feature/UI/tasbih_page.dart';
import 'package:app/features/azkar_feature/UI/zekr_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:islamic_azkar/islamic_azkar.dart';

class AzkarPage extends StatelessWidget {
  AzkarPage({super.key});
  List azkarCategories = ZekrCategory.values;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
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
                    icon = Icons.wb_sunny_outlined;
                    break;
                  case ZekrCategory.evening:
                    title = "أذكار المساء";
                    icon = Icons.dark_mode_outlined;
                    break;
                  case ZekrCategory.eating:
                    title = "أذكار الطعام";
                    icon = Icons.restaurant_menu;
                    break;
                  case ZekrCategory.mosque:
                    title = "أذكار المسجد";
                    icon = Icons.mosque_outlined;
                    break;
                  case ZekrCategory.house:
                    title = "أذكار المنزل";
                    icon = Icons.home_outlined;
                    break;
                  case ZekrCategory.wakingUp:
                    title = "أذكار الاستيقاظ";
                    icon = Icons.alarm_on;
                    break;
                  case ZekrCategory.protection:
                    title = "أذكار التحصين";
                    icon = Icons.verified_user_outlined;
                    break;
                  case ZekrCategory.travel:
                    title = "أذكار السفر";
                    icon = Icons.flight_takeoff;
                    break;
                  case ZekrCategory.prayerSupplications:
                    title = "أدعية الصلاة";
                    icon = Icons.menu_book_outlined;
                    break;
                  case ZekrCategory.wudu:
                    title = "أذكار الوضوء";
                    icon = Icons.water_drop_outlined;
                    break;
                  case ZekrCategory.nature:
                    title = "أذكار الطبيعة";
                    icon = Icons.wb_cloudy_outlined;
                    break;
                  case ZekrCategory.fasting:
                    title = "أذكار الصيام";
                    icon = Icons.nights_stay_outlined;
                    break;
                  case ZekrCategory.emotions:
                    title = "أذكار الضيق والفرج";
                    icon = Icons.volunteer_activism_outlined;
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
