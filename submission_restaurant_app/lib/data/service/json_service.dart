import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../model/restaurants.dart';

class JsonService {

   Future<List<Restaurant>>getJson() async {
    final data = await rootBundle.loadString("assets/local_restaurant.json");
    
    var jsonData = jsonDecode(data);
    var dataTwo = jsonData['restaurants'] as List<dynamic>;
    var dataThree = dataTwo.map((e) => Restaurant.fromJson(e)).toList();

    return dataThree;
  }
  
}