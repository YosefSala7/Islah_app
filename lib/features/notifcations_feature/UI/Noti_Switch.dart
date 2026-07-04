import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide BoxShadow, BoxDecoration;
import 'package:flutter/widgets.dart';

class NotiToggleSwitch extends StatefulWidget {
  const NotiToggleSwitch({
    super.key,
    this.initiallyDark = false,
    this.duration = const Duration(milliseconds: 400), // تم تسريع الوقت ليكون تفاعلياً أكثر
    this.size = 30,
    this.onChange,
  });

  final double size;
  final bool initiallyDark;
  final Duration duration;
  final ValueChanged<bool>? onChange;

  @override
  State createState() => _ToggleSwitchState();
}

class _ToggleSwitchState extends State<NotiToggleSwitch>
    with TickerProviderStateMixin { // تم تعديلها لدعم أكثر من أنيميشن
  late AnimationController animationController;
  late AnimationController shakeController; // وحدة تحكم خاصة بهزة الجرس
  late Animation<Offset> slideAnim;
  late double height;
  late double width;

  bool dark = true;

  @override
  void dispose() {
    animationController.dispose();
    shakeController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    setWidget();
    animate(updateWidget: true);
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant NotiToggleSwitch oldWidget) {
    if (oldWidget.initiallyDark == widget.initiallyDark) return;
    setWidget();
    animate(updateWidget: true);
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    // إنشأ متحكم حركة الهزة (تشتغل في نصف ثانية)
    shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    slideAnim = Tween<Offset>(
      begin: const Offset(-0.05, 0),
      end: const Offset(1.35, 0),
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.elasticOut,
        reverseCurve: Curves.elasticIn,
      ),
    );

    setWidget();
    // لو فتح والاشعارات شغالة، يعمل هزة خفيفة ترحيبية
    if (widget.initiallyDark) {
      shakeController.forward();
    }
    super.initState();
  }

  void setWidget() {
    dark = widget.initiallyDark;
    height = widget.size;
    width = widget.size * (7 / 3);

    if (dark) {
      animationController.value = animationController.upperBound;
    } else {
      animationController.value = animationController.lowerBound;
    }
  }

  void animate({bool updateWidget = false}) {
    if (animationController.value == animationController.upperBound) {
      animationController.reverse();
    } else {
      animationController.forward();
    }
    
    if (!updateWidget) {
      setState(() {
        dark = !dark;
        widget.onChange?.call(dark);
      });
      
      // لو الزرار اتقلب لـ "مفتوح" (منور)، شغل أنيميشن الهزة فوراً 
      if (dark) {
        shakeController.forward(from: 0.0);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // تحديد الألوان بناءً على حالة الإشعارات (منور باللون الأخضر/الأزرق أو مطفي بالرمادي)
    final activeColor = Theme.of(context).colorScheme.primary; 
    final baseColor = dark ? activeColor : Colors.grey.shade400;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onPanUpdate: (_) {
          if (!animationController.isAnimating) {
            animate();
          }
        },
        onTap: animate,
        child: AnimatedContainer(
          duration: widget.duration,
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: baseColor.withAlpha(dark ? 51 : 26), // خلفية الزرار الشفافة
            borderRadius: BorderRadius.circular(height / 2),
            border: Border.all(color: baseColor.withAlpha(102), width: 1.5),
          ),
          clipBehavior: Clip.hardEdge,
          child: Stack(
            children: [
              // الدائرة المتحركة (الزرار الداخلي)
              Align(
                alignment: Alignment.centerLeft,
                child: SlideTransition(
                  position: slideAnim,
                  child: AnimatedBuilder(
                    animation: shakeController,
                    builder: (context, child) {
                      // معادلة الهزة الرياضية للجرس (يمين ويسار بسلاسة)
                      double angle = 0.0;
                      if (shakeController.value > 0 && shakeController.value < 1) {
                        angle = sin(shakeController.value * pi * 4) * 0.20;
                      }

                      return Transform.rotate(
                        angle: angle,
                        child: AnimatedContainer(
                          duration: widget.duration,
                          alignment: Alignment.center,
                          height: height - 4, // ترك مسافة داخلية صغيرة للبوردر
                          width: height - 4,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: baseColor, // لون الدائرة يتغير حسب الحالة
                            boxShadow: [
                              if (dark)
                                BoxShadow(
                                  color: activeColor.withAlpha(128),
                                  blurRadius: 8,
                                  spreadRadius: 1,
                                )
                            ],
                          ),
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 250),
                            transitionBuilder: (child, animation) => 
                                ScaleTransition(scale: animation, child: child),
                            child: Icon(
                              // تبديل شكل الأيقونة جرس مفتوح أو جرس مقفول
                              dark ? CupertinoIcons.bell_fill : CupertinoIcons.bell_slash_fill,
                              key: ValueKey<bool>(dark),
                              size: height * 0.55, // حجم الأيقونة متناسق مع حجم الزرار
                              color: Colors.white, // لون الجرس دايماً أبيض بداخل الدائرة
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}