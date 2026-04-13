// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:timezone/timezone.dart' as tz;
// import 'package:timezone/data/latest.dart' as tz_data;
// import 'package:flutter_timezone/flutter_timezone.dart';

// class LocalNotiService {
//   final FlutterLocalNotificationsPlugin notifications = FlutterLocalNotificationsPlugin();

//   Future<void> init() async {
//     tz_data.initializeTimeZones();
//     tz.setLocalLocation(tz.getLocation("Africa/Cairo"));

//   // try {
//   //   // الحصول على اسم الـ timezone كـ String مباشرة
//   //   final TimezoneInfo timeZoneName = await FlutterTimezone.getLocalTimezone();

//   //   // تعيين الـ timezone
//   //   tz.setLocalLocation(tz.getLocation(timeZoneName as String));

//   //   print('✅ Timezone set to: $timeZoneName');
//   // } catch (e) {
//   //   tz.setLocalLocation(tz.getLocation('UTC'));
//   //   print('❌ Error setting timezone, using UTC: $e');
//   // }
//     var status = await Permission.notification.request();
//     if (!status.isGranted) return;

//     await Permission.scheduleExactAlarm.request();

//     const AndroidInitializationSettings android = AndroidInitializationSettings('@mipmap/ic_launcher');

//     const DarwinInitializationSettings ios = DarwinInitializationSettings(
//       requestAlertPermission: true,
//       requestBadgePermission: true,
//       requestSoundPermission: true,
//     );

//     await notifications.initialize(
//       settings: const InitializationSettings(android: android, iOS: ios),
//       onDidReceiveNotificationResponse: (details) {
//         print('Notification payload: ${details.payload}');
//       },
//     );
//   }

//   static NotificationDetails get _notificationDetails => const NotificationDetails(
//         android: AndroidNotificationDetails(
//           'prayer_channel',
//           'تنبيهات الصلاة',
//           channelDescription: 'إشعارات أوقات الصلاة مع صوت الأذان',
//           importance: Importance.max,
//           priority: Priority.high,
//           playSound: true,
//           sound: RawResourceAndroidNotificationSound('azhan'),
//           enableVibration: true,
//         ),
//         iOS: DarwinNotificationDetails(sound: 'azhan.mp3'),
//       );

//   Future<void> show({int id = 0, String title = 'مرحباً!', String body = 'إشعار'}) async {
//     await notifications.show(id: id, title: title, body: body, notificationDetails: _notificationDetails);
//   }

// Future<void> schedule({
//   required int id,
//   required String title,
//   required String body,
//   required DateTime time,
// }) async {
//   // تحويل DateTime لـ TZDateTime
//   final tzDateTime = tz.TZDateTime.from(time, tz.local);

//   await notifications.zonedSchedule(
//     id: id,
//     title: title,
//     body: body,
//     scheduledDate: tzDateTime,
//     notificationDetails: _notificationDetails,
//     androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
//     matchDateTimeComponents: DateTimeComponents.time,
//   );
// }
//   Future<void> cancelAllNoti() async {
//     await notifications.cancelAll();
//   }
// }

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz_data;

class LocalNotiService {
  final FlutterLocalNotificationsPlugin notifications =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    tz_data.initializeTimeZones();
    tz.setLocalLocation(tz.local);

    print('🌍 Timezone set to ${tz.local}');

    await _requestPermissions();
    final androidPlugin = notifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();

    await androidPlugin?.requestNotificationsPermission();

    await androidPlugin?.requestExactAlarmsPermission();

    const AndroidInitializationSettings android = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    const DarwinInitializationSettings ios = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      requestCriticalPermission: true,
    );

    await notifications.initialize(
      settings: const InitializationSettings(android: android, iOS: ios),
      onDidReceiveNotificationResponse: (details) {
        print('🔔 Notification payload: ${details.payload}');
      },
    );

    print('🎉 Notifications initialized successfully!');
  }

  Future<void> _requestPermissions() async {
    var status = await Permission.notification.request();
    print('📱 Notification permission: ${status.name}');

    await Permission.scheduleExactAlarm.request();

    await Permission.manageExternalStorage.request();

    if (await Permission.notification.status != PermissionStatus.granted) {
      await Permission.notification.request();
    }
  }

  static NotificationDetails get _notificationDetails => NotificationDetails(
    android: AndroidNotificationDetails(
      'prayer_channel',
      'تنبيهات الصلاة',
      channelDescription: 'إشعارات أوقات الصلاة مع صوت الأذان',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      sound: RawResourceAndroidNotificationSound('azhan'),
      enableVibration: true,
      showWhen: true,
      ongoing: false,
      autoCancel: true,
      visibility: NotificationVisibility.public,
    ),
    iOS: const DarwinNotificationDetails(sound: 'azhan.mp3'),
  );

  Future<void> show({
    int id = 0,
    String title = 'مرحباً!',
    String body = 'إشعار',
  }) async {
    await notifications.show(
      id: id,
      title: title,
      body: body,
      notificationDetails: _notificationDetails,
    );
    print('📢 Showing notification ID: $id');
  }

  Future<void> schedule({
    required int id,
    required String title,
    required String body,
    required String time,
  }) async {
    final parts = time.split(':');
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);

    final now = DateTime.now();

    var scheduledDate = DateTime(now.year, now.month, now.day, hour, minute);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    final tzDateTime = tz.TZDateTime.from(scheduledDate, tz.local);

    print('📅 Scheduling for: ${tzDateTime.toLocal()}');

    await notifications.zonedSchedule(
      id: id,
      title: title,
      body: body,
      scheduledDate: tzDateTime,
      notificationDetails: _notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );
    print('✅ Scheduled notification ID: $id');
  }

  Future<void> cancelAllNoti() async {
    await notifications.cancelAll();
    print('🗑️ All notifications cancelled');
  }

  // ✅ دالة لإلغاء إشعار معين
  Future<void> cancel(int id) async {
    await notifications.cancel(id: id);
    print('❌ Cancelled notification ID: $id');
  }
}
