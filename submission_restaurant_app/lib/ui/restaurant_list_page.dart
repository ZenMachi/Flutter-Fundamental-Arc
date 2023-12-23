import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:submission_restaurant_app/provider/api_provider.dart';
import 'package:submission_restaurant_app/ui/restaurant_detail_page.dart';
import 'package:submission_restaurant_app/widgets/card_restaurant_item.dart';

class RestaurantListPage extends StatefulWidget {
  static const routeName = '/restaurant_list';

  const RestaurantListPage({super.key});

  @override
  State<RestaurantListPage> createState() => _RestaurantListPageState();
}

class _RestaurantListPageState extends State<RestaurantListPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.only(top: 16, left: 8, right: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Restaurant',
                    style: Theme.of(context).textTheme.displayMedium?.apply(
                        color: Theme.of(context).colorScheme.onBackground)),
                SizedBox(height: 8.h),
                // _buildSearchBar(iconSearch),
                // SizedBox(height: 4.h),
                Text('Nearest Restaurant for You!',
                    style: Theme.of(context).textTheme.titleMedium?.apply(
                        color: Theme.of(context).colorScheme.onBackground)),
                _buildRestaurantItem(),
              ],
            )),
      ),
    );
  }

  Widget _buildRestaurantItem() {
    return Consumer<ApiProvider>(
      builder: (context, state, child) {
        if (state.state == ResultState.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.state == ResultState.hasData) {
          return Flexible(
            child: ListView.builder(
                itemCount: state.restaurantListResult.count,
                itemBuilder: (context, index) {
                  return CardRestaurant(
                    restaurant: state.restaurantListResult.restaurants[index],
                    onTap: () {
                      Provider.of<ApiProvider>(context, listen: false)
                          .fetchDetailRestaurant(
                              state.restaurantListResult.restaurants[index].id);
                      Navigator.pushNamed(
                          context, RestaurantDetailPage.routeName, arguments: state.restaurantListResult.restaurants[index].id);
                    },
                  );
                }),
          );
        } else if (state.state == ResultState.noData) {
          return Center(
            child: Material(
              child: Text(state.message),
            ),
          );
        } else if (state.state == ResultState.error) {
          return Center(
            child: Material(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset('assets/error_cat.json', height: 240),
                  Text(state.message),
                  SizedBox(height: 24,),
                  OutlinedButton(
                      onPressed: () => Provider.of<ApiProvider>(context, listen: false).fetchListRestaurant(),
                      child: Text('Refresh Data'))
                ],
              ),
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
