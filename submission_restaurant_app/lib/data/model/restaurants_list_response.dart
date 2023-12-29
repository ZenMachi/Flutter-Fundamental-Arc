import 'dart:convert';

import 'package:submission_restaurant_app/data/model/restaurant.dart';

class RestaurantsListResponse {
  bool error;
  String message;
  int count;
  List<Restaurant> restaurants;

  RestaurantsListResponse({
    required this.error,
    required this.message,
    required this.count,
    required this.restaurants,
  });

  factory RestaurantsListResponse.fromRawJson(String str) =>
      RestaurantsListResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RestaurantsListResponse.fromJson(Map<String, dynamic> json) =>
      RestaurantsListResponse(
        error: json["error"],
        message: json["message"],
        count: json["count"],
        restaurants: List<Restaurant>.from(
            json["restaurants"].map((x) => Restaurant.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "count": count,
        "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
      };
}
