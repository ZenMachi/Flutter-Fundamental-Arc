import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:sizer/sizer.dart';
import 'package:submission_restaurant_app/data/model/restaurants.dart';
import 'package:submission_restaurant_app/ui/restaurant_detail.dart';
import 'package:submission_restaurant_app/ui/restaurant_list.dart';
import 'package:submission_restaurant_app/common/styles.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => Sizer(builder: (context, orientation, deviceType) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: myTextTheme,
        colorScheme: lightColorScheme,
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: RestaurantList.routeName,
      routes: {
        RestaurantList.routeName: (context) => const RestaurantList(),
        RestaurantDetailPage.routeName: (context) => RestaurantDetailPage(
            restaurant: ModalRoute.of(context)?.settings.arguments as Restaurant)
      },
    );
  });
}

