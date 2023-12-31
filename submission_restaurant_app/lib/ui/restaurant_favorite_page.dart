import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:submission_restaurant_app/common/navigation.dart';
import 'package:submission_restaurant_app/provider/api_provider.dart';
import 'package:submission_restaurant_app/provider/database_provider.dart';
import 'package:submission_restaurant_app/ui/restaurant_detail_page.dart';
import 'package:submission_restaurant_app/utils/result_state.dart';
import 'package:submission_restaurant_app/widgets/card_restaurant_item.dart';

class RestaurantFavoritePage extends StatefulWidget {
  static const routeName = '/restaurant_favorite';

  const RestaurantFavoritePage({super.key});

  @override
  State<RestaurantFavoritePage> createState() => _RestaurantFavoritePageState();
}

class _RestaurantFavoritePageState extends State<RestaurantFavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.only(top: 16, left: 8, right: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTitle(context),
                SizedBox(height: 8.h),
                Text('Personal Liked',
                    style: Theme.of(context).textTheme.titleMedium?.apply(
                        color: Theme.of(context).colorScheme.onBackground)),
                _buildRestaurantItem(),
              ],
            )),
      ),
    );
  }

  Row _buildTitle(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text('Favorite',
            style: Theme.of(context)
                .textTheme
                .displayMedium
                ?.apply(color: Theme.of(context).colorScheme.onBackground)),
      ],
    );
  }

  Widget _buildRestaurantItem() {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        if (provider.state == ResultState.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (provider.state == ResultState.hasData) {
          return Flexible(
            child: ListView.builder(
                itemCount: provider.favorite.length,
                itemBuilder: (context, index) {
                  final restaurant = provider.favorite[index];
                  return Dismissible(
                    key: Key(restaurant.id),
                    onDismissed: (direction) =>
                        provider.removeFavorite(restaurant.id),
                    child: CardRestaurant(
                      restaurant: restaurant,
                      onTap: () {
                        Provider.of<ApiProvider>(context, listen: false)
                            .fetchDetailRestaurant(restaurant.id);
                        Navigation.intentWithData(
                            RestaurantDetailPage.routeName, restaurant.id);
                      },
                    ),
                  );
                }),
          );
        } else if (provider.state == ResultState.noData) {
          return Center(
            child: Material(
              child: Text(provider.message),
            ),
          );
        } else {
          return const Center(
            child: Text('Unknown Error'),
          );
        }
      },
    );
  }
}
