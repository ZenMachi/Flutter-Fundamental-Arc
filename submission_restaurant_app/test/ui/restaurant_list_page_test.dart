import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:integration_test/integration_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:submission_restaurant_app/data/api/api_service.dart';
import 'package:submission_restaurant_app/data/database/database_helper.dart';
import 'package:submission_restaurant_app/provider/api_provider.dart';
import 'package:submission_restaurant_app/provider/database_provider.dart';
import 'package:submission_restaurant_app/ui/restaurant_favorite_page.dart';
import 'package:submission_restaurant_app/ui/restaurant_list_page.dart';
import 'package:submission_restaurant_app/widgets/card_restaurant_item.dart';

Widget createHomeScreen() => MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => ApiProvider(apiService: ApiService(Client()))
              ..fetchListRestaurant()),
        ChangeNotifierProvider(
            create: (context) =>
                DatabaseProvider(databaseHelper: DatabaseHelper())
                  ..getFavorite()),
      ],
      child: Sizer(builder: (context, orientation, deviceType) {
        return const MaterialApp(
          home: RestaurantListPage(),
        );
      }),
    );

Widget createFavoriteScreen() => MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => ApiProvider(apiService: ApiService(Client()))
              ..fetchListRestaurant()),
        ChangeNotifierProvider(
            create: (context) =>
                DatabaseProvider(databaseHelper: DatabaseHelper())
                  ..getFavorite()),
      ],
      child: Sizer(builder: (context, orientation, deviceType) {
        return const MaterialApp(
          home: RestaurantFavoritePage(),
        );
      }),
    );

void main() {
  group('Restaurant List Page Widget Test', () {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();
    testWidgets('Test if Card Restaurant Item shows up', (widgetTester) async {
      WidgetsFlutterBinding.ensureInitialized();

      await widgetTester.pumpWidget(createHomeScreen());
      await widgetTester.pumpAndSettle();

      expect(find.byType(CardRestaurant), findsWidgets);
    });

    testWidgets(
        'Test if Favorite Page contain title "Favorite" from Restaurant List Page',
        (widgetTester) async {
      WidgetsFlutterBinding.ensureInitialized();

      await widgetTester.pumpWidget(createHomeScreen());
      await widgetTester.pumpAndSettle();

      await widgetTester.tap(find.byType(IconButton).first);
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
      await widgetTester.pumpWidget(createFavoriteScreen());
      await widgetTester.pumpAndSettle();

      expect(find.text('Favorite'), findsOneWidget);
    });
  });
}
