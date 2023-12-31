import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' show Client;
import 'package:submission_restaurant_app/data/model/post_review_body.dart';
import 'package:submission_restaurant_app/data/model/restaurant_detail_response.dart';
import 'package:submission_restaurant_app/data/model/restaurant_search_response.dart';
import 'package:submission_restaurant_app/data/model/restaurants_list_response.dart';
import 'package:submission_restaurant_app/data/model/review_response.dart';

class ApiService {
  static const _baseUrl = 'https://restaurant-api.dicoding.dev';
  static const _listEndpoint = 'list';
  static const _detailEndpoint = 'detail';
  static const _searchEndpoint = 'search';
  static const _postEndpoint = 'review';
  final Client client;

  ApiService(this.client);

  Future<RestaurantsListResponse> getRestaurantsList() async {
    final response = await client.get(Uri.parse("$_baseUrl/$_listEndpoint"));

    if (response.statusCode == 200) {
      return RestaurantsListResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load List Restaurants');
    }
  }

  Future<RestaurantDetailResponse> getRestaurantdetail(String id) async {
    final response =
        await client.get(Uri.parse("$_baseUrl/$_detailEndpoint/$id"));

    if (response.statusCode == 200) {
      return RestaurantDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Detail Restaurants');
    }
  }

  Future<RestaurantSearchResponse> getRestaurantSearchResult(
      String query) async {
    final response =
        await client.get(Uri.parse("$_baseUrl/$_searchEndpoint?q=$query"));

    if (response.statusCode == 200) {
      return RestaurantSearchResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Result Restaurants');
    }
  }

  Future<ReviewResponse> postReviewRestaurant(PostReviewBody reviewBody) async {
    final response = await client.post(Uri.parse("$_baseUrl/$_postEndpoint"),
        headers: {HttpHeaders.contentTypeHeader: "application/json"},
        body: jsonEncode(reviewBody.toJson()));

    if (response.statusCode == 201) {
      return ReviewResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to send Review Restaurants');
    }
  }
}
