import 'package:flutter_test/flutter_test.dart';
import 'package:submission_restaurant_app/data/api/api_service.dart';

void main() {
  group('Api Service Test', () {
    late ApiService apiService;

    setUp(() {
      apiService = ApiService();
    });
    test('Test fetch json list restaurant from restaurant api', () async {
      bool result = await apiService.getRestaurantsList().then((value) {
        return value.error;
      });

      expect(result, false);
    });
  });
}
