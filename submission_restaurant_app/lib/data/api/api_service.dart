import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:submission_restaurant_app/data/model/post_review_body.dart';
import 'package:submission_restaurant_app/data/model/restaurant_detail.dart';
import 'package:submission_restaurant_app/data/model/restaurant_search.dart';
import 'package:submission_restaurant_app/data/model/restaurants_list.dart';
import 'package:submission_restaurant_app/data/model/review_response.dart';

class ApiService {
  static const _baseUrl = 'https://restaurant-api.dicoding.dev';
  static const _listEndpoint = 'list';
  static const _detailEndpoint = 'detail';
  static const _searchEndpoint = 'search';
  static const _postEndpoint = 'review';

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
    final response =
        await http.get(Uri.parse("$_baseUrl/$_searchEndpoint?q=$query"));

    if (response.statusCode == 200) {
      return RestaurantSearch.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Result Restaurants');
    }
  }

  Future<ReviewResponse> postReviewRestaurant(PostReviewBody reviewBody) async {
    final response = await http.post(Uri.parse("$_baseUrl/$_postEndpoint"),
        headers: {HttpHeaders.contentTypeHeader: "application/json"},
        body: jsonEncode(reviewBody.toJson()));

    if (response.statusCode == 201) {
      return ReviewResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to send Review Restaurants');
    }
  }
}
