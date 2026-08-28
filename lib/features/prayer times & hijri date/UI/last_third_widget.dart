import 'package:app/core/components/card.dart';
import 'package:app/core/translation/translateClockNumbers.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class TimeWidget extends StatelessWidget {
  TimeWidget({
    super.key,
    required this.time,
    required this.clickable,
    required this.img,
  });
  String time;
  bool clickable;
  String img;

  @override
  Widget build(BuildContext context) {
    return clickable
        ? GestureDetector(
            onTap: () {
              showGeneralDialog(
                context: context,
                barrierDismissible: true,
                barrierLabel: '',
                transitionDuration: const Duration(milliseconds: 400),
                pageBuilder: (context, anim1, anim2) {
                  return const SizedBox.shrink();
                },
                transitionBuilder: (context, anim1, anim2, child) {
                  return ScaleTransition(
                    scale: Tween<double>(begin: 0.8, end: 1.0).animate(
                      CurvedAnimation(parent: anim1, curve: Curves.easeOutBack),
                    ),
                    child: FadeTransition(
                      opacity: anim1,
                      child: Center(
                        child: Material(
                          type: MaterialType.transparency,
                          child: Container(
                            width: MediaQuery.sizeOf(context).width / 1.1,
                            constraints: BoxConstraints(
                              maxHeight: MediaQuery.sizeOf(context).height / 2,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(24),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black,
                                  blurRadius: 20,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const SizedBox(width: 40),
                                      Text(
                                        "last_third".tr(),
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(
                                            context,
                                          ).textTheme.titleLarge?.color,
                                        ),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.close_rounded),
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                        splashRadius: 22,
                                      ),
                                    ],
                                  ),
                                  const Divider(height: 20, thickness: 1),
                                  const SizedBox(height: 8),
                                  Flexible(
                                    child: SingleChildScrollView(
                                      physics: const BouncingScrollPhysics(),
                                      child: Text(
                                        "ثلث الليل الآخر وقت فاضل من الأوقات التي تظن فيها استجابة الدعاء، فهو وقت التنزل لقول النبي صلى الله عليه وسلم: (ينزل ربنا تبارك وتعالى كل ليلة إلى السماء الدنيا حين يبقى ثلث الليل الآخر يقول: 'من يدعوني فأستجيب له، من يسألني فأعطيه، من يستغفرني فأغفر له' ). متفق عليه",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 15,
                                          height: 1.6,
                                          color: Theme.of(
                                            context,
                                          ).textTheme.bodyMedium?.color,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
            child:
                MyCard(
                      20,
                      MediaQuery.heightOf(context) / 7,
                      MediaQuery.widthOf(context) / 2.3,
                      Theme.of(context).cardColor,
                      Stack(
                        children: [
                          Container(
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            width: double.infinity,
                            child: Image.asset(img, fit: BoxFit.fill),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Stack(
                              children: [
                                Center(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "last_third".tr(),
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                              fontSize: 17,
                                              color: Color.fromARGB(255, 255, 249, 226),
                                              fontWeight: FontWeight.bold,
                                              shadows: [
                                                Shadow(
                                                  offset: Offset(0, 0),
                                                  blurRadius: 4.0,
                                                  color: Color(0xFF8C7355),
                                                ),
                                              ],
                                            ),
                                      ),
                                      Text(
                                        format12hours(time),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromARGB(255, 255, 249, 226),
                                              shadows: [
                                                Shadow(
                                                  offset: Offset(0, 0),
                                                  blurRadius: 4.0,
                                                  color: Color(0xFF8C7355),
                                                ),
                                              ],
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(
                                  Icons.info_outline_rounded,
                                  size: MediaQuery.widthOf(context) / 24,
                                  color: Color.fromARGB(255, 243, 232, 186),
                                ),
                              ],
                            ),
                          ),
                        ],
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
          )
        : MyCard(
                20,
                MediaQuery.heightOf(context) / 7,
                MediaQuery.widthOf(context) / 2.3,
                Theme.of(context).cardColor,
                Stack(
                  children: [
                    Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      width: double.infinity,
                      child: Image.asset(img, fit: BoxFit.fill),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "sunrise".tr(),
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyMedium!
                                  .copyWith(
                                    fontSize: 17,
                                    color: Color(0xFF2C3E50),
                                    fontWeight: FontWeight.bold,
                                    shadows: [
                                      Shadow(
                                        offset: Offset(0, 0),
                                        blurRadius: 5.0,
                                        color: Color(0xFFFFF9E6)
                                      ),
                                    ],
                                  ),
                            ),
                            Text(
                              format12hours(time),
                              style: Theme.of(context).textTheme.bodyMedium!
                                  .copyWith(
                                    fontSize: 18,
                                    color: Color(0xFF2C3E50),
                                    fontWeight: FontWeight.bold,
                                    shadows: [
                                      Shadow(
                                        offset: Offset(0, 0),
                                        blurRadius: 5.0,
                                        color: Color(0xFFFFF3CD)
                                      ),
                                    ],
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
              .animate(delay: 200.ms)
              .slideY(
                begin: 0.7,
                end: 0,
                duration: 800.ms,
                curve: Curves.easeOutBack,
              )
              .fadeIn(duration: Duration(milliseconds: 800));
  }
}
