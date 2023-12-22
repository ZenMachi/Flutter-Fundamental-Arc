import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:submission_restaurant_app/provider/api_provider.dart';
import 'package:submission_restaurant_app/ui/restaurant_detail_page.dart';
import 'package:submission_restaurant_app/widgets/card_restaurant_item.dart';

class RestaurantSearchPage extends StatefulWidget {
  static const routeName = '/restaurant_search';

  const RestaurantSearchPage({super.key});

  @override
  State<RestaurantSearchPage> createState() => _RestaurantSearchPageState();
}

class _RestaurantSearchPageState extends State<RestaurantSearchPage> {
  final SearchController _searchController = SearchController();
  FocusNode searchFocus = FocusNode();
  String searchString = '';
  String queryString = '';

  @override
  Widget build(BuildContext context) {
    final iconSearch = searchFocus.hasPrimaryFocus
        ? const Icon(Icons.clear)
        : const Icon(Icons.search);
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
                _buildSearchBar(iconSearch),
                SizedBox(height: 4.h),
                Text('Nearest Restaurant for You!',
                    style: Theme.of(context).textTheme.titleMedium?.apply(
                        color: Theme.of(context).colorScheme.onBackground)),
                buildResultItem
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
      onSubmitted: (query) {
        setState(() {
          queryString = query;
          Provider.of<ApiProvider>(context, listen: false)
              .fetchResultRestaurant(query);
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
    return Consumer<ApiProvider>(
      builder: (context, state, child) {
        if (state.state == ResultState.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.state == ResultState.hasData) {
          if (state.restaurantSearchResult.restaurants.isNotEmpty) {
            return Flexible(
              child: ListView.builder(
                  itemCount: state.restaurantSearchResult.founded,
                  itemBuilder: (context, index) {
                    return CardRestaurantItem(
                      restaurant:
                          state.restaurantSearchResult.restaurants[index],
                      onTap: () {
                        Provider.of<ApiProvider>(context, listen: false)
                            .fetchDetailRestaurant(state
                                .restaurantSearchResult.restaurants[index].id);
                        Navigator.pushNamed(
                            context, RestaurantDetailPage.routeName,
                            arguments: state
                                .restaurantSearchResult.restaurants[index].id);
                      },
                    );
                  }),
            );
          } else {
            return Text('No Data');
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
                  SizedBox(
                    height: 24,
                  ),
                  OutlinedButton(
                      onPressed: () =>
                          Provider.of<ApiProvider>(context, listen: false)
                              .fetchResultRestaurant(queryString),
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
