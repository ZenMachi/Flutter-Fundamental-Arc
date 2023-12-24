import 'dart:convert';

import 'package:submission_restaurant_app/data/model/restaurant.dart';

class RestaurantSearch {
  bool error;
  int founded;
  List<Restaurant> restaurants;

  RestaurantSearch({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  factory RestaurantSearch.fromRawJson(String str) => RestaurantSearch.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RestaurantSearch.fromJson(Map<String, dynamic> json) => RestaurantSearch(
    error: json["error"],
    founded: json["founded"],
    restaurants: List<Restaurant>.from(json["restaurants"].map((x) => Restaurant.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "founded": founded,
    "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
  };
}

