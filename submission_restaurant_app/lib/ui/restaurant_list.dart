import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:submission_restaurant_app/provider/restaurant_provider.dart';
import 'package:submission_restaurant_app/widgets/card_restaurant_item.dart';

class RestaurantList extends StatefulWidget {
  static const routeName = '/';

  const RestaurantList({super.key});

  @override
  State<RestaurantList> createState() => _RestaurantListState();
}

class _RestaurantListState extends State<RestaurantList> {
  final SearchController _searchController = SearchController();
  FocusNode searchFocus = FocusNode();
  String searchString = '';

  @override
  void initState() {
    FlutterNativeSplash.remove();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final iconSearch = searchFocus.hasPrimaryFocus
        ? const Icon(Icons.clear)
        : const Icon(Icons.search);


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
                _buildSearchBar(iconSearch),
                SizedBox(height: 4.h),
                Text('Nearest Restaurant for You!',
                    style: Theme.of(context).textTheme.titleMedium?.apply(
                        color: Theme.of(context).colorScheme.onBackground)),
                _buildRestaurantItem(),
              ],
            )),
      ),
    );
  }

  SearchBar _buildSearchBar(Icon iconSearch) {
    return SearchBar(
      focusNode: searchFocus,
      controller: _searchController,
      elevation: MaterialStateProperty.all(1),
      hintText: 'Search Restaurant',
      onChanged: (value) {
        setState(() {
          searchString = value;
        });
      },
      trailing: [
        IconButton(
          icon: iconSearch,
          onPressed: () {
            setState(() {
              searchString = '';
              _searchController.clear();
              searchFocus.unfocus();
            });
          },
        )
      ],
    );
  }

  Widget _buildRestaurantItem() {
    return Consumer<RestaurantProvider>(
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
                  return CardRestaurantItem(
                      restaurant:
                          state.restaurantListResult.restaurants[index]);
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
              child: Text(state.message),
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
