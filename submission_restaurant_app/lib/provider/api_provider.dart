import 'package:flutter/foundation.dart';
import 'package:submission_restaurant_app/data/api/api_service.dart';
import 'package:submission_restaurant_app/data/model/post_review_body.dart';
import 'package:submission_restaurant_app/data/model/restaurant_detail.dart';
import 'package:submission_restaurant_app/data/model/restaurant_search.dart';
import 'package:submission_restaurant_app/data/model/restaurants_list.dart';

enum ResultState { loading, noData, hasData, error }

class ApiProvider extends ChangeNotifier {
  final ApiService apiService;

  ApiProvider({required this.apiService});

  late ResultState _state;

  ResultState get state => _state;

  String _message = '';

  String get message => _message;

  late RestaurantsList _restaurantsList;

  RestaurantsList get restaurantListResult => _restaurantsList;

  late RestaurantSearch _restaurantSearchResult;

  RestaurantSearch get restaurantSearchResult => _restaurantSearchResult;

  late RestaurantDetail _restaurantDetail;

  RestaurantDetail get restaurantDetailResult => _restaurantDetail;

  Future<dynamic> fetchListRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();

      final restaurants = await apiService.getRestaurantsList();

      if (restaurants.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'empty data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantsList = restaurants;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
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
        return _message = 'empty data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantDetail = detail;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
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
        return _message = 'Not Found';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantSearchResult = result;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }

  Future<dynamic> postReviewResturant(PostReviewBody reviewBody) async {
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
        return _restaurantDetail.restaurant.customerReviews = result.customerReviews;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
