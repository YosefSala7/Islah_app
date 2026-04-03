import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

class LocalNotiService {
  static LocalNotiService? _instance;
  static LocalNotiService get instance {
    _instance ??= LocalNotiService._internal();
    return _instance!;
  }

  LocalNotiService._internal();

  final FlutterLocalNotificationsPlugin notifications =
      FlutterLocalNotificationsPlugin();

  bool _isInit = false;
  bool get isInit => _isInit;

  Future<void> init() async {
    if (isInit) return;
    // Request notification permission
    var status = await Permission.notification.request();
    if (!status.isGranted) {
      print('❌ Notification permission denied');
      return;
    }

    // Request exact alarm permission for Android 12+
    status = await Permission.scheduleExactAlarm.request();
    if (!status.isGranted) {
      print(
        '⚠️ Exact alarm permission denied - scheduled notifications may not work precisely',
      );
    } else {
      print('✅ Exact alarm permission granted');
    }

    const AndroidInitializationSettings android = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    const DarwinInitializationSettings ios = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings settings = InitializationSettings(
      android: android,
      iOS: ios,
    );

    await notifications.initialize(settings: settings);
    _isInit = true;
    print('✅ Notifications initialized');
  }

  static NotificationDetails get _notificationDetails =>
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'prayer_channel',
          'تنبيهات الصلاة',
          channelDescription: 'إشعارات أوقات الصلاة مع صوت الأذان',
          importance: Importance.max,
          priority: Priority.high,
          playSound: true,
          sound: RawResourceAndroidNotificationSound('azhan'),
          enableVibration: true,
        ),
        iOS: DarwinNotificationDetails(sound: 'azhan.mp3'),
      );

  static Future<void> showStatic({
    required int id,
    required String title,
    required String body,
  }) async {
    await instance.notifications.show(
      id: id,
      title: title,
      body: body,
      notificationDetails: _notificationDetails,
    );
  }

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

  Future<void> cancleAllNoti() async {
    await notifications.cancelAll();
  }

}