import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:submission_restaurant_app/common/navigation.dart';
import 'package:submission_restaurant_app/provider/api_provider.dart';
import 'package:submission_restaurant_app/ui/restaurant_detail_page.dart';
import 'package:submission_restaurant_app/utils/result_state.dart';
import 'package:submission_restaurant_app/widgets/card_restaurant_item.dart';
import 'package:submission_restaurant_app/widgets/search_bar_restaurant.dart';

class RestaurantSearchPage extends StatefulWidget {
  static const routeName = '/restaurant_search';

  const RestaurantSearchPage({super.key});

  @override
  State<RestaurantSearchPage> createState() => _RestaurantSearchPageState();
}

class _RestaurantSearchPageState extends State<RestaurantSearchPage> {
  String queryString = '';

  callback(String onSubmit) {
    setState(() {
      queryString = onSubmit;
      Provider.of<ApiProvider>(context, listen: false)
          .fetchResultRestaurant(queryString);
    });
  }

  @override
  Widget build(BuildContext context) {
    final buildResultItem = queryString.isEmpty
        ? Center(
            child: Column(
            children: [
              SizedBox(height: 4.h),
              Lottie.asset('assets/search.json', width: 50.w),
            ],
          ))
        : _buildRestaurantItem();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.only(top: 16, left: 8, right: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Search',
                    style: Theme.of(context).textTheme.displayMedium?.apply(
                        color: Theme.of(context).colorScheme.onBackground)),
                SizedBox(height: 8.h),
                SearchBarRestaurant(
                  onSubmitted: callback,
                ),
                SizedBox(height: 4.h),
                Text('Find your Restaurant, Category or Menu',
                    style: Theme.of(context).textTheme.titleMedium?.apply(
                        color: Theme.of(context).colorScheme.onBackground)),
                buildResultItem
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
            child: Column(
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 24),
                Text('Searching for Data')
              ],
            ),
          );
        } else if (state.state == ResultState.hasData) {
          if (state.restaurantSearchResult.restaurants.isNotEmpty) {
            return Flexible(
              child: ListView.builder(
                  itemCount: state.restaurantSearchResult.founded,
                  itemBuilder: (context, index) {
                    return CardRestaurant(
                      restaurant:
                          state.restaurantSearchResult.restaurants[index],
                      onTap: () {
                        Provider.of<ApiProvider>(context, listen: false)
                            .fetchDetailRestaurant(state
                                .restaurantSearchResult.restaurants[index].id);
                        Navigation.intentWithData(
                            RestaurantDetailPage.routeName,
                            state.restaurantListResult.restaurants[index].id);
                      },
                    );
                  }),
            );
          } else {
            return const Text('No Data');
          }
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
                  const SizedBox(
                    height: 24,
                  ),
                  OutlinedButton(
                      onPressed: () =>
                          Provider.of<ApiProvider>(context, listen: false)
                              .fetchResultRestaurant(queryString),
                      child: const Text('Reload Data'))
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
