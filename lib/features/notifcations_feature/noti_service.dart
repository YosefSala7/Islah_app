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
      onDidReceiveNotificationResponse: (details) {},
    );
  }

  Future<void> _requestPermissions() async {
    var status = await Permission.notification.request();

    await Permission.scheduleExactAlarm.request();

    await Permission.manageExternalStorage.request();

    if (await Permission.notification.status != PermissionStatus.granted) {
      await Permission.notification.request();
    }
  }

  static NotificationDetails get _notificationDetails => NotificationDetails(
    android: AndroidNotificationDetails(
      icon: "ic_notification",
      largeIcon: DrawableResourceAndroidBitmap('app_icon'),
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

    await notifications.zonedSchedule(
      id: id,
      title: title,
      body: body,
      scheduledDate: tzDateTime,
      notificationDetails: NotificationDetails(
        android: AndroidNotificationDetails(
          icon: "ic_notification",
          largeIcon: DrawableResourceAndroidBitmap('app_icon'),
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
    await notifications.zonedSchedule(
      id: id,
      title: title,
      body: body,
      scheduledDate: tzDateTime,
      notificationDetails: NotificationDetails(
        android: AndroidNotificationDetails(
          icon: "ic_notification",
          largeIcon: DrawableResourceAndroidBitmap('app_icon'),
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
  }

  Future<void> scheduleWeeklyNoti({
    required int id,
    required String title,
    required String body,
    required String time,
    required int dayOfWeek,
  }) async {
    final parts = time.trim().split(':');
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);

    final now = DateTime.now();

    var scheduledDate = DateTime(now.year, now.month, now.day, hour, minute);

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    while (scheduledDate.weekday != dayOfWeek) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    final tz.Location location = tz.getLocation(
      'Africa/Cairo',
    ); // ← غيرها لـ منطقتك
    final tz.TZDateTime tzDateTime = tz.TZDateTime(
      location,
      scheduledDate.year,
      scheduledDate.month,
      scheduledDate.day,
      scheduledDate.hour,
      scheduledDate.minute,
    );
    await notifications.zonedSchedule(
      id: id,
      title: title,
      body: body,
      scheduledDate: tzDateTime,
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          icon: "ic_notification",
          largeIcon: DrawableResourceAndroidBitmap('app_icon'),
          'weekly_channel',
          'التنبيهات الأسبوعية',
          channelDescription: "إشعارات تتكرر في يوم محدد كل أسبوع",
          importance: Importance.max,
          priority: Priority.high,
          enableVibration: true,
        ),
        iOS: DarwinNotificationDetails(presentSound: true),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
    );
  }

  Future<void> cancelAllNoti() async {
    await notifications.cancelAll();
  }

  // ✅ دالة لإلغاء إشعار معين
  Future<void> cancel(int id) async {
    await notifications.cancel(id: id);
  }
}
