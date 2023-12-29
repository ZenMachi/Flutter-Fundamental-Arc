import 'dart:developer';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:submission_restaurant_app/utils/background_service.dart';
import 'package:submission_restaurant_app/utils/date_time_helper.dart';
import 'package:submission_restaurant_app/utils/preferences_helper.dart';

class SchedulingProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;

  SchedulingProvider({required this.preferencesHelper}) {
    _getDailyNewsPreferences();
  }

  bool _isScheduled = false;

  bool get isScheduled => _isScheduled;

  Future<bool> scheduledRestaurant(bool value) async {
    preferencesHelper.setNotification(value);
    _getDailyNewsPreferences();

    if (_isScheduled) {
      log('Scheduling Restaurant Cancelled');
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    } else {
      log('Scheduling Restaurant Activated');
      notifyListeners();
      return await AndroidAlarmManager.periodic(
          const Duration(hours: 24), 1, BackgroundService.callback,
          startAt: DateTimeHelper.format(), exact: true, wakeup: true);
    }
  }

  void _getDailyNewsPreferences() async {
    _isScheduled = await preferencesHelper.isNotificationActive;
    notifyListeners();
  }
}
