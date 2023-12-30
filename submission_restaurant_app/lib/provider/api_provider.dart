import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:submission_restaurant_app/data/api/api_service.dart';
import 'package:submission_restaurant_app/data/model/post_review_body.dart';
import 'package:submission_restaurant_app/data/model/restaurant_detail_response.dart';
import 'package:submission_restaurant_app/data/model/restaurant_search_response.dart';
import 'package:submission_restaurant_app/data/model/restaurants_list_response.dart';
import 'package:submission_restaurant_app/data/model/review_response.dart';
import 'package:submission_restaurant_app/utils/result_state.dart';

class ApiProvider extends ChangeNotifier {
  final ApiService apiService;

  ApiProvider({required this.apiService});

  late ResultState _state;

  ResultState get state => _state;

  String _message = '';

  String get message => _message;

  late RestaurantsListResponse _restaurantsList;

  RestaurantsListResponse get restaurantListResult => _restaurantsList;

  late RestaurantSearchResponse _restaurantSearchResult;

  RestaurantSearchResponse get restaurantSearchResult =>
      _restaurantSearchResult;

  late RestaurantDetailResponse _restaurantDetail;

  RestaurantDetailResponse get restaurantDetailResult => _restaurantDetail;

  late ReviewResponse _reviewResponse;

  ReviewResponse get reviewResponse => _reviewResponse;

  Future<dynamic> fetchListRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();

      final restaurants = await apiService.getRestaurantsList();

      if (restaurants.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'There is No Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantsList = restaurants;
      }
    } catch (e) {
      _state = ResultState.error;
      log('Error --> $e');
      notifyListeners();
      return _message = 'Please Check Your Internet Connection';
    }
  }

  Future<dynamic> fetchDetailRestaurant(String id) async {
    try {
      _state = ResultState.loading;
      notifyListeners();

      final detail = await apiService.getRestaurantdetail(id);

      if (detail.error == true) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'There is No Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantDetail = detail;
      }
    } catch (e) {
      _state = ResultState.error;
      log('Error --> $e');
      notifyListeners();
      return _message = 'Please Check Your Internet Connection';
    }
  }

  Future<dynamic> fetchResultRestaurant(String query) async {
    try {
      _state = ResultState.loading;
      notifyListeners();

      final result = await apiService.getRestaurantSearchResult(query);

      if (result.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        _restaurantSearchResult = result;

        return _message = 'Not Found';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantSearchResult = result;
      }
    } catch (e) {
      _state = ResultState.error;
      log('Error --> $e');
      notifyListeners();
      return _message = 'Please Check Your Internet Connection';
    }
  }

  Future<dynamic> postReviewRestaurant(PostReviewBody reviewBody) async {
    try {
      _state = ResultState.loading;
      notifyListeners();

      final result = await apiService.postReviewRestaurant(reviewBody);

      if (result.error == true) {
        _state = ResultState.noData;
        notifyListeners();

        return _message = result.message;
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        _reviewResponse = result;

        return _restaurantDetail.restaurant.customerReviews =
            result.customerReviews;
      }
    } catch (e) {
      _state = ResultState.error;
      log('Error --> $e');
      notifyListeners();
      return _message = 'Please Check Your Internet Connection';
    }
  }
}
