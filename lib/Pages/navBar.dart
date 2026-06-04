import 'package:app/Pages/azkarPage.dart';
import 'package:app/Pages/home.dart';
import 'package:app/features/Qibla_Feature/UI/qibla_page.dart';
import 'package:app/Pages/quranPage.dart';
import 'package:app/Pages/settingPages.dart';
import 'package:app/features/prayer%20times%20&%20hijri%20date/logic/prayerApiCubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        tabs: [
          PersistentTabConfig(
            screen: BlocProvider.value(
              value: context.read<PrayerApiCubit>(),
              child: const Home(),
            ),
            item: ItemConfig(
              icon: Icon(FlutterIslamicIcons.solidMosque),
              activeForegroundColor: Theme.of(
                context,
              ).bottomNavigationBarTheme.selectedItemColor!,
              inactiveForegroundColor: Theme.of(
                context,
              ).bottomNavigationBarTheme.unselectedItemColor!,
              inactiveIcon: Icon(FlutterIslamicIcons.mosque),
              title: "Home".tr(),
            ),
          ),
          PersistentTabConfig(
            screen: BlocProvider.value(
              value: context.read<PrayerApiCubit>(),
              child: AzkarPage(),
            ),
            item: ItemConfig(
              icon: Icon(FlutterIslamicIcons.solidTasbih3),
              inactiveIcon: Icon(FlutterIslamicIcons.tasbih3),
              activeForegroundColor: Theme.of(
                context,
              ).bottomNavigationBarTheme.selectedItemColor!,
              inactiveForegroundColor: Theme.of(
                context,
              ).bottomNavigationBarTheme.unselectedItemColor!,
              title: "Azkar".tr(),
            ),
          ),
          PersistentTabConfig(
            screen: QuranPage(),
            item: ItemConfig(
              icon: Icon(FlutterIslamicIcons.solidQuran),
              inactiveIcon: Icon(FlutterIslamicIcons.quran),
              activeForegroundColor: Theme.of(
                context,
              ).bottomNavigationBarTheme.selectedItemColor!,
              inactiveForegroundColor: Theme.of(
                context,
              ).bottomNavigationBarTheme.unselectedItemColor!,
              title: "Quran".tr(),
            ),
          ),
          PersistentTabConfig(
            screen: const SettingPage(),
            item: ItemConfig(
              icon: Icon(CupertinoIcons.gear_solid),
              inactiveIcon: Icon(CupertinoIcons.gear),
              activeForegroundColor: Theme.of(
                context,
              ).bottomNavigationBarTheme.selectedItemColor!,
              inactiveForegroundColor: Theme.of(
                context,
              ).bottomNavigationBarTheme.unselectedItemColor!,
              title: "Settings".tr(),
            ),
          ),
        ],

        navBarBuilder: (navBarConfig) => Style2BottomNavBar(
          navBarConfig: navBarConfig,
          navBarDecoration: NavBarDecoration(
            color: Theme.of(context).bottomNavigationBarTheme.backgroundColor!,
          ),
        ),
      ),
    );
  }
}
