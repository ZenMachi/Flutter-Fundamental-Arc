import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:integration_test/integration_test.dart';
import 'package:submission_restaurant_app/data/api/api_service.dart';
import 'package:submission_restaurant_app/provider/api_provider.dart';
import 'package:submission_restaurant_app/ui/restaurant_list_page.dart';
import 'package:submission_restaurant_app/widgets/card_restaurant_item.dart';

Widget createHomeScreen() => ChangeNotifierProvider<ApiProvider>(
      create: (context) =>
          ApiProvider(apiService: ApiService())..fetchListRestaurant(),
      child: Sizer(builder: (context, orientation, deviceType) {
        return const MaterialApp(
          home: RestaurantListPage(),
        );
      }),
    );

void main() {
  group('Restaurant List Page Widget Test', () {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();
    testWidgets('Testing if Card Restaurant Item shows up',
        (widgetTester) async {
      WidgetsFlutterBinding.ensureInitialized();

      await widgetTester.pumpWidget(createHomeScreen());
      await widgetTester.pumpAndSettle();

      expect(find.byType(CardRestaurant), findsWidgets);
    });
  });
}
