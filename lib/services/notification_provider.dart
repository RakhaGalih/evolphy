import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationProvider with ChangeNotifier {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  NotificationProvider() {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    _checkLastOpened();
  }

  Future<void> _saveCurrentTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('last_opened', DateTime.now().millisecondsSinceEpoch);
  }

  Future<void> _checkLastOpened() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int lastOpened = prefs.getInt('last_opened') ?? 0;
    int currentTime = DateTime.now().millisecondsSinceEpoch;

    if (currentTime - lastOpened >= 2 * 1000) {
      _showNotification();
    }

    _saveCurrentTime();
  }

  Future<void> _showNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('your_channel_id', 'your_channel_name',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'Hey there!',
      'You have not opened the app for 2 days.',
      platformChannelSpecifics,
      payload: 'item x',
    );
  }
}
