import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:submission_restaurant_app/data/database/database_helper.dart';
import 'package:submission_restaurant_app/data/model/restaurant.dart';
import 'package:submission_restaurant_app/utils/result_state.dart';

class DatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  DatabaseProvider({required this.databaseHelper});

  late ResultState _state;

  ResultState get state => _state;

  String _message = '';

  String get message => _message;

  List<Restaurant> _favorite = [];

  List<Restaurant> get favorite => _favorite;

  Future<bool> isFavorite(String id) async {
    final favoriteRestaurant = await databaseHelper.getFavoriteById(id);
    return favoriteRestaurant.isNotEmpty;
  }

  void getFavorite() async {
    _state = ResultState.loading;
    _favorite = await databaseHelper.getFavorite();
    if (_favorite.isEmpty) {
      _state = ResultState.noData;
      _message = 'There is No Favorite Restaurant';
    } else {
      _state = ResultState.hasData;
    }
    notifyListeners();
  }

  void addFavorite(Restaurant restaurant) async {
    try {
      await databaseHelper.insertFavorite(restaurant);
      getFavorite();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Failed to Add Favorite';
      log('Error -> $e');
      notifyListeners();
    }
  }

  void removeFavorite(String id) async {
    try {
      await databaseHelper.removeFavorite(id);
      getFavorite();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Failed to Remove Bookmark';
      log('Error -> $e');
      notifyListeners();
    }
  }
}
