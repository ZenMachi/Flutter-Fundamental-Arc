
import 'dart:developer';
import 'dart:isolate';
import 'dart:ui';

import 'package:news_app/data/api/api_service.dart';
import 'package:news_app/main.dart';
import 'package:news_app/utils/notification_helper.dart';

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

    var result = await ApiService().topHeadlines();
    await notificationHelper.showNotification(flutterLocalNotificationsPlugin, result);

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }
}