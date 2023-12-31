import 'dart:developer';
import 'dart:isolate';
import 'dart:ui';

import 'package:http/http.dart';
import 'package:submission_restaurant_app/data/api/api_service.dart';
import 'package:submission_restaurant_app/main.dart';
import 'package:submission_restaurant_app/utils/notification_helper.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService? _instance;
  static const String _isolateName = 'isolate';
  static SendPort? _uiSendPort;

  BackgroundService._internal() {
    _instance = this;
  }

  factory BackgroundService() => _instance ?? BackgroundService._internal();

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(port.sendPort, _isolateName);
  }

  static Future<void> callback() async {
    log('Alarm Fired');
    final NotificationHelper notificationHelper = NotificationHelper();

    try {
      var result = await ApiService(Client()).getRestaurantsList();
      var randomRestaurant = (result.restaurants..shuffle()).first;

      await notificationHelper.showNotification(
          flutterLocalNotificationsPlugin, randomRestaurant);
    } catch (e) {
      await notificationHelper.showNotificationError(
          flutterLocalNotificationsPlugin, e.toString());
    }

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }
}
