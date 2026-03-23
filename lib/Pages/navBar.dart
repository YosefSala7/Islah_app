import 'package:app/Pages/azkarPage.dart';
import 'package:app/Pages/home.dart';
import 'package:app/Pages/quranPage.dart';
import 'package:app/colorsManager.dart';
import 'package:app/features/prayer%20times%20&%20hijri%20date/prayer%20API%20State%20management/prayerApiCubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
        backgroundColor: LightColors.navBar,
        tabs: [
          PersistentTabConfig(
            screen: BlocProvider.value(
              value: context.read<PrayerApiCubit>(),
              child: const Home(),
            ),
            item: ItemConfig(
              icon: FaIcon(FontAwesomeIcons.houseChimney,color: LightColors.iconActive,),
              inactiveIcon: FaIcon(FontAwesomeIcons.house,color: LightColors.iconInactive,),
              title: "Home".tr(),
            ),
          ),
          PersistentTabConfig(
            screen: BlocProvider.value(
              value: context.read<PrayerApiCubit>(),
              child: const AzkarPage(),
            ),
            item: ItemConfig(
              icon: Icon(FlutterIslamicIcons.solidTasbih3),
              inactiveIcon: Icon(FlutterIslamicIcons.tasbih3),
              title: "Azkar".tr(),
            ),
          ),
          PersistentTabConfig(
            screen: BlocProvider.value(
              value: context.read<PrayerApiCubit>(),
              child: const QuranPage(),
            ),
            item: ItemConfig(icon: Icon(Icons.settings), title: "Settings"),
          ),
        ],
        navBarBuilder: (navBarConfig) =>
            Style1BottomNavBar(navBarConfig: navBarConfig),
      ),
    );
  }
}
