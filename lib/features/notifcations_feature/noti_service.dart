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

  Future<void> schedulePrayerNoti({
    required int id,
    required String title,
    required String body,
    required String time,
  }) async {
    final parts = time.trim().split(':');
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
      notificationDetails: NotificationDetails(
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
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );
    print('✅ Scheduled notification ID: $id');
  }

  Future<void> scheduleAzkarNoti({
    required int id,
    required String title,
    required String body,
    required String time,
  }) async {
    final parts = time.trim().split(':');
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
      notificationDetails: NotificationDetails(
        android: AndroidNotificationDetails(
          'azkar_channel',
          'تنبيهات الأذكار',
          channelDescription: "اشعارات يومية لتذكرك بالاذكار",
          importance: Importance.max,
          priority: Priority.high,
          playSound: true,
          sound: null,
          enableVibration: true,
          showWhen: true,
          ongoing: false,
          autoCancel: true,
          visibility: NotificationVisibility.public,
        ),
        iOS: const DarwinNotificationDetails(presentSound: true, sound: null),
      ),
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
