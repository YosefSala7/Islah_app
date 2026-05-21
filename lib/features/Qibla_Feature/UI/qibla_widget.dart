import 'package:app/core/components/card.dart';
import 'package:app/features/Qibla_Feature/UI/qibla_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';

class QiblaWidget extends StatelessWidget {
  const QiblaWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context, rootNavigator: true).push(
          MaterialPageRoute(
            builder: (context) => QiblaPage(),
          ),
        );
      },
      child:
          MyCard(
                20,
                MediaQuery.heightOf(context) / 7,
                MediaQuery.widthOf(context) / 2.2,
                Theme.of(context).cardColor,
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: MediaQuery.heightOf(context) / 12,
                          child: Icon(FlutterIslamicIcons.solidQibla,size: 40,),
                        ),
                        Text(
                          "Qibla".tr(),
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ),
              )
              .animate(delay: 200.ms)
              .slideY(
                begin: 0.7,
                end: 0,
                duration: 800.ms,
                curve: Curves.easeOutBack,
              )
              .fadeIn(duration: Duration(milliseconds: 800)),
    );
  }
}
