import 'package:flutter_test/flutter_test.dart';
import 'package:submission_restaurant_app/data/api/api_service.dart';
import 'package:submission_restaurant_app/data/model/post_review_body.dart';
import 'package:submission_restaurant_app/provider/api_provider.dart';
import 'package:submission_restaurant_app/utils/result_state.dart';

void main() {
  group('Api Provider Test', () {
    late ApiProvider apiProvider;

    setUp(() {
      apiProvider = ApiProvider(apiService: ApiService());
    });

    test('check restaurant list are not empty when fetch list endpoint',
        () async {
      await apiProvider.fetchListRestaurant();

      var result = apiProvider.restaurantListResult.restaurants.isNotEmpty;
      expect(result, true);
    });

    test('check id detail restaurant is same when fetch detail endpoint',
        () async {
      const id = 'rqdv5juczeskfw1e867';

      await apiProvider.fetchDetailRestaurant(id);

      var result = apiProvider.restaurantDetailResult.restaurant.id;
      expect(result, id);
    });

    test('check item is empty when querying with random false query', () async {
      const query = 'sirupefsdfdsf';

      await apiProvider.fetchResultRestaurant(query);

      var result = apiProvider.restaurantSearchResult.restaurants.isEmpty;
      expect(result, true);
    });

    test('check response when post review with correct id', () async {
      const id = 'rqdv5juczeskfw1e867';
      const name = 'jason';
      const review = 'this is unit test';
      final reviewBody = PostReviewBody(id: id, name: name, review: review);

      await apiProvider.postReviewRestaurant(reviewBody);

      var result = apiProvider.reviewResponse.error;
      expect(result, false);
    });

    test('check response when post review with incorrect id', () async {
      const id = 'rqdv5juczeskfw1e867 sdsdsd';
      const name = 'jason';
      const review = 'this is unit test';
      final reviewBody = PostReviewBody(id: id, name: name, review: review);

      await apiProvider.postReviewRestaurant(reviewBody);

      var result = apiProvider.state;
      expect(result, ResultState.error);
    });
  });
}
