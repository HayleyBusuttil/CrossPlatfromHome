import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Notifications {
  Notifications._();
  static final Notifications instance = Notifications._();

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const settings = InitializationSettings(android: androidSettings);

    await _plugin.initialize(settings);

    // Android 13+ runtime permission request
    final androidImpl =
        _plugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();

    await androidImpl?.requestNotificationsPermission();
  }

  Future<void> showHighExpense(double amount) async {
    const androidDetails = AndroidNotificationDetails(
      'high_expense_channel',
      'High expense alerts',
      channelDescription: 'Notifies when a large expense is added',
      importance: Importance.max,
      priority: Priority.high,
    );

    const details = NotificationDetails(android: androidDetails);

    await _plugin.show(
      1,
      'High expense logged',
      'You added an expense of €${amount.toStringAsFixed(2)}',
      details,
    );
  }
}
