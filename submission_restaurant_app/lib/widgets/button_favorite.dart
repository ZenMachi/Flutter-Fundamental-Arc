import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission_restaurant_app/data/model/restaurant.dart';
import 'package:submission_restaurant_app/data/model/restaurant_detail_response.dart';
import 'package:submission_restaurant_app/provider/database_provider.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({
    super.key,
    required this.detail,
  });

  final RestaurantDetail detail;

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(builder: (context, provider, child) {
      return FutureBuilder(
          future: provider.isFavorite(detail.id),
          builder: (context, snapshot) {
            final Restaurant data = Restaurant(
                id: detail.id,
                name: detail.name,
                description: detail.description,
                pictureId: detail.pictureId,
                city: detail.city,
                rating: detail.rating.toDouble());
            var isFavorite = snapshot.data ?? false;
            return isFavorite
                ? IconButton(
                    onPressed: () => provider.removeFavorite(detail.id),
                    icon: const Icon(
                      Icons.favorite,
                      size: 36,
                      color: Colors.red,
                    ))
                : IconButton(
                    onPressed: () => provider.addFavorite(data),
                    icon: const Icon(
                      Icons.favorite_outline,
                      size: 36,
                      color: Colors.red,
                    ));
          });
    });
  }
}
