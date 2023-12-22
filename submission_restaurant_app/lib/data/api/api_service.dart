import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:submission_restaurant_app/data/model/restaurant_detail.dart';
import 'package:submission_restaurant_app/data/model/restaurant_search.dart';
import 'package:submission_restaurant_app/data/model/restaurants_list.dart';

class ApiService {
  static const _baseUrl = 'https://restaurant-api.dicoding.dev';
  static const _listEndpoint = 'list';
  static const _detailEndpoint = 'detail';
  static const _searchEndpoint = 'search';

  Future<RestaurantsList> getRestaurantsList() async {
    final response = await http.get(Uri.parse("$_baseUrl/$_listEndpoint"));

    if (response.statusCode == 200) {
      return RestaurantsList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load List Restaurants');
    }
  }

  Future<RestaurantDetail> getRestaurantdetail(String id) async {
    final response =
        await http.get(Uri.parse("$_baseUrl/$_detailEndpoint/$id"));

    if (response.statusCode == 200) {
      return RestaurantDetail.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Detail Restaurants');
    }
  }

  Future<RestaurantSearch> getRestaurantSearchResult(String query) async {
    final response = await http.get(Uri.parse("$_baseUrl/$_searchEndpoint?q=$query"));

    if (response.statusCode == 200) {
      return RestaurantSearch.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Result Restaurants');
    }
  }
}
