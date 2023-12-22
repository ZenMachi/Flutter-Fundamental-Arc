import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:submission_restaurant_app/data/model/restaurant_detail.dart';
import 'package:submission_restaurant_app/provider/api_provider.dart';
import 'package:submission_restaurant_app/widgets/card_menu_item.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/restaurant_detail';
  final String id;

  const RestaurantDetailPage({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return _buildContent();
  }

  Scaffold _buildContent() {
    return Scaffold(
      body: Consumer<ApiProvider>(
        builder: (context, state, child) {
          if (state.state == ResultState.loading) {
            return const Center(
              child: Material(child: CircularProgressIndicator()),
            );
          } else if (state.state == ResultState.hasData) {
            return NestedScrollView(
              headerSliverBuilder: (context, isScrolled) => [
                SliverAppBar(
                  expandedHeight: 300,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    background:
                        _buildImage(context, state.restaurantDetailResult),
                  ),
                )
              ],
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        children: [
                          const SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: _buildNameAndLocation(
                                    context, state.restaurantDetailResult),
                              ),
                              ElevatedButton(
                                  onPressed: () => showDialog(
                                      context: context,
                                      builder: (context) => _buildReviewDialog(
                                          context,
                                          state.restaurantDetailResult)),
                                  child: Text('Reviews'))
                            ],
                          ),
                          const SizedBox(height: 24),
                          _buildDescription(
                              context, state.restaurantDetailResult),
                          const SizedBox(height: 24),
                          _buildMenu(context, state.restaurantDetailResult),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
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
                    Text(state.message),
                    OutlinedButton(
                        onPressed: () => Provider.of<ApiProvider>(
                                context,
                                listen: false)
                            .fetchDetailRestaurant(id),
                        child: Text('Refresh Data'))
                  ],
                ),
              ),
            );
          } else {
            return Scaffold(
              body: const Center(
                child: Text('Unknown Error'),
              ),
            );
          }
        },
      ),
    );
  }

  AlertDialog _buildReviewDialog(
      BuildContext context, RestaurantDetail detail) {
    return AlertDialog(
      scrollable: true,
      title: Text('Reviews'),
      actions: [
        ElevatedButton(
            onPressed: () => Navigator.of(context).pop(), child: Text('Close'))
      ],
      content: SizedBox(
        height: 300,
        width: 300,
        child: ListView.builder(
            itemCount: detail.restaurant.customerReviews.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  ListTile(
                    isThreeLine: false,
                    title: Text(detail.restaurant.customerReviews[index].name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(detail.restaurant.customerReviews[index].review),
                        SizedBox(
                          height: 12,
                        ),
                        Text(detail.restaurant.customerReviews[index].date),
                      ],
                    ),
                  ),
                  Divider()
                ],
              );
            }),
      ),
    );
  }

  Column _buildMenu(BuildContext context, RestaurantDetail detail) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Menu',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(
          height: 4,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Foods',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  SizedBox(
                    height: 120,
                    width: 100.w,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: detail.restaurant.menus.foods.length,
                        itemBuilder: (context, index) {
                          return Center(
                              child: CardMenu(
                                  menuName: detail
                                      .restaurant.menus.foods[index].name));
                        }),
                  ),
                  Text(
                    'Drinks',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  SizedBox(
                    height: 120,
                    width: 100.w,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: detail.restaurant.menus.drinks.length,
                        itemBuilder: (context, index) {
                          return Center(
                              child: CardMenu(
                                  menuName: detail
                                      .restaurant.menus.drinks[index].name));
                        }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  ClipRRect _buildImageDummy(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
      child: Hero(
        tag: 14,
        child: Image.network(
          "https://restaurant-api.dicoding.dev/images/medium/14",
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.fitHeight,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) {
              return child;
            }
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
              ),
            );
          },
        ),
      ),
    );
  }

  ClipRRect _buildImage(BuildContext context, RestaurantDetail detail) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
      child: Hero(
        tag: detail.restaurant.pictureId,
        child: Image.network(
          "https://restaurant-api.dicoding.dev/images/medium/${detail.restaurant.pictureId}",
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.fitHeight,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) {
              return child;
            }
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
              ),
            );
          },
        ),
      ),
    );
  }

  Column _buildDescription(BuildContext context, RestaurantDetail detail) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Text(
          detail.restaurant.description,
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }

  Column _buildNameAndLocation(BuildContext context, RestaurantDetail detail) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          detail.restaurant.name,
          style: Theme.of(context).textTheme.headlineMedium,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          softWrap: true,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                right: 8.0,
              ),
              child: SvgPicture.asset(
                'images/icons/icon_location.svg',
                width: 12,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            Text(
              detail.restaurant.city,
              style: Theme.of(context).textTheme.bodyLarge,
            )
          ],
        ),
        RatingBarIndicator(
            rating: detail.restaurant.rating,
            itemSize: 18,
            itemBuilder: (context, index) => Icon(
                  Icons.star,
                  color: Theme.of(context).colorScheme.primary,
                ))
      ],
    );
  }
}
