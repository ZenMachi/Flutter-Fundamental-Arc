import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:submission_restaurant_app/common/navigation.dart';
import 'package:submission_restaurant_app/data/api/api_service.dart';
import 'package:submission_restaurant_app/data/database/database_helper.dart';
import 'package:submission_restaurant_app/provider/api_provider.dart';
import 'package:submission_restaurant_app/provider/database_provider.dart';
import 'package:submission_restaurant_app/provider/scheduling_provider.dart';
import 'package:submission_restaurant_app/provider/theme_provider.dart';
import 'package:submission_restaurant_app/ui/home_page.dart';
import 'package:submission_restaurant_app/ui/restaurant_detail_page.dart';
import 'package:submission_restaurant_app/ui/restaurant_favorite_page.dart';
import 'package:submission_restaurant_app/ui/restaurant_list_page.dart';
import 'package:submission_restaurant_app/common/styles.dart';
import 'package:submission_restaurant_app/ui/restaurant_search_page.dart';
import 'package:submission_restaurant_app/ui/settings_page.dart';
import 'package:submission_restaurant_app/utils/background_service.dart';
import 'package:submission_restaurant_app/utils/notification_helper.dart';
import 'package:submission_restaurant_app/utils/preferences_helper.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  widgetsBinding;
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  final NotificationHelper notificationHelper = NotificationHelper();
  final BackgroundService service = BackgroundService();

  service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) =>
      Sizer(builder: (context, orientation, deviceType) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
                create: (context) =>
                    ApiProvider(apiService: ApiService(Client()))
                      ..fetchListRestaurant()),
            ChangeNotifierProvider(
                create: (context) =>
                    DatabaseProvider(databaseHelper: DatabaseHelper())
                      ..getFavorite()),
            ChangeNotifierProvider(
                create: (context) => ThemeProvider(
                    preferencesHelper: PreferencesHelper(
                        sharedPreferences: SharedPreferences.getInstance()))),
            ChangeNotifierProvider(
                create: (context) => SchedulingProvider(
                    preferencesHelper: PreferencesHelper(
                        sharedPreferences: SharedPreferences.getInstance()))),
          ],
          child: Consumer<ThemeProvider>(builder: (context, state, child) {
            return MaterialApp(
              navigatorKey: navigatorKey,
              title: 'Flutter Demo',
              theme: ThemeData(
                textTheme: myTextTheme,
                colorScheme: lightColorScheme,
                useMaterial3: true,
              ),
              darkTheme: ThemeData(
                  textTheme: myTextTheme,
                  colorScheme: darkColorScheme,
                  useMaterial3: true),
              debugShowCheckedModeBanner: false,
              themeMode: state.themeMode,
              initialRoute: RestaurantHomePage.routeName,
              routes: {
                RestaurantHomePage.routeName: (context) =>
                    const RestaurantHomePage(),
                RestaurantListPage.routeName: (context) =>
                    const RestaurantListPage(),
                RestaurantFavoritePage.routeName: (context) =>
                    const RestaurantFavoritePage(),
                RestaurantSearchPage.routeName: (context) =>
                    const RestaurantSearchPage(),
                SettingsPage.routeName: (context) => const SettingsPage(),
                RestaurantDetailPage.routeName: (context) =>
                    RestaurantDetailPage(
                      id: ModalRoute.of(context)?.settings.arguments as String,
                    ),
              },
            );
          }),
        );
      });
}
