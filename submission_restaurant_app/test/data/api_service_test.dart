import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/testing.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:submission_restaurant_app/data/api/api_service.dart';
import 'package:submission_restaurant_app/data/model/restaurants_list_response.dart';

@GenerateMocks([http.Client])
void main() {
  group('Api Service Test', () {
    test('return a RestaurantListResponse if http call complete successfully',
        () async {
      final mockClient = MockClient((request) async {
        final response = {
          "error": false,
          "message": "success",
          "count": 20,
          "restaurants": []
        };
        return http.Response(json.encode(response), 200);
      });

      final result = await ApiService(mockClient).getRestaurantsList();

      expect(result, isA<RestaurantsListResponse>());
    });

    test('Throws Exception on Bad Request', () async {
      final mockClient = MockClient((request) async {
        return http.Response('Bad Request', 404);
      });

      final result = ApiService(mockClient).getRestaurantsList();

      expect(result, throwsException);
    });
  });
}
