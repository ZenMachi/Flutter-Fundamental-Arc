import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:submission_restaurant_app/data/api/api_service.dart';
import 'package:submission_restaurant_app/provider/api_provider.dart';
import 'package:submission_restaurant_app/provider/theme_provider.dart';
import 'package:submission_restaurant_app/ui/home_page.dart';
import 'package:submission_restaurant_app/ui/restaurant_detail_page.dart';
import 'package:submission_restaurant_app/ui/restaurant_list_page.dart';
import 'package:submission_restaurant_app/common/styles.dart';
import 'package:submission_restaurant_app/ui/restaurant_search_page.dart';
import 'package:submission_restaurant_app/ui/settings_page.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

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
                create: (context) => ApiProvider(apiService: ApiService())
                  ..fetchListRestaurant()),
            ChangeNotifierProvider(create: (context) => ThemeProvider()),
          ],
          child: Consumer<ThemeProvider>(builder: (context, state, child) {
            return MaterialApp(
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
