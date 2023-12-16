import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:sizer/sizer.dart';
import 'package:submission_restaurant_app/widgets/card_restaurant_item.dart';

import '../data/model/restaurants.dart';

class RestaurantList extends StatefulWidget {
  static const routeName = '/';

  const RestaurantList({super.key});

  @override
  State<RestaurantList> createState() => _RestaurantListState();
}

class _RestaurantListState extends State<RestaurantList> {
  final SearchController _searchController = SearchController();
  List<Restaurant> _displayRestaurant = [];
  FocusNode searchFocus = FocusNode();
  String searchString = '';

  late Future dataJson;

  @override
  void initState() {
    dataJson = DefaultAssetBundle.of(context)
        .loadString("assets/local_restaurant.json");

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
                    style: Theme.of(context).textTheme.displayLarge?.apply(
                        color: Theme.of(context).colorScheme.onBackground)),
                SizedBox(height: 8.h),
                _buildSearchBar(iconSearch),
                SizedBox(height: 4.h),
                Text('Nearest Restaurant for You!',
                    style: Theme.of(context).textTheme.titleLarge?.apply(
                        color: Theme.of(context).colorScheme.onBackground)),
                _buildRestaurantItem(searchString),
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

  FutureBuilder _buildRestaurantItem(String query) {
    return FutureBuilder(
        future: dataJson,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final RestaurantDetail restaurant = parseRestaurant(snapshot.data);
            _displayRestaurant = List.from(restaurant.restaurants);

            return Flexible(
              child: ListView.builder(
                  itemCount: _displayRestaurant.length,
                  itemBuilder: (context, index) {
                    return _displayRestaurant[index]
                            .name
                            .toLowerCase()
                            .contains(query.toLowerCase())
                        ? CardRestaurantItem(
                            restaurant: _displayRestaurant[index])
                        : Container();
                  }),
            );
          }

          return const Center(
            child: Text('No Data'),
          );
        });
  }
}
