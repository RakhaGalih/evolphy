import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationProvider {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('evolphylogo');
    var initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {});
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) async {},
    );

    // Initialize timezone data
    tz.initializeTimeZones();
  }

  notificationDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails('channelId', 'channelNsme',
            importance: Importance.max),
        iOS: DarwinNotificationDetails());
  }

  Future showNotification(
      {int id = 0, String? title, String? body, String? payLoad}) async {
    return flutterLocalNotificationsPlugin.show(
        id, title, body, notificationDetails());
  }

  Future<void> saveLastOpenedTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('lastOpenedTime', DateTime.now().millisecondsSinceEpoch);
  }

  Future<void> scheduleTwoDayReminder() async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      0, // Notification ID
      'Kami merindukanmu!',
      'Buka aku, ini sudah 2 hari sejak terakhir kali kamu buka aplikasi.',
      tz.TZDateTime.now(tz.local).add(const Duration(seconds: 12)),
      notificationDetails(),
      payload: 'TwoDayReminder',
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.wallClockTime,
    );
  }

  Future<void> checkLastOpenedTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? lastOpenedTime = prefs.getInt('lastOpenedTime');
    if (lastOpenedTime != null) {
      DateTime lastOpenedDateTime =
          DateTime.fromMillisecondsSinceEpoch(lastOpenedTime);
      if (DateTime.now().difference(lastOpenedDateTime).inDays >= 2) {
        await showNotification(
            id: 1,
            title: 'We miss you!',
            body: 'It\'s been 2 days since you last opened the app.');
      }
    }
  }
}
