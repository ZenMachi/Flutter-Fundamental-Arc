import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:submission_restaurant_app/data/model/restaurant_detail.dart';
import 'package:submission_restaurant_app/provider/restaurant_provider.dart';
import 'package:submission_restaurant_app/widgets/card_menu_item.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/restaurant_detail';

  final String id;

  const RestaurantDetailPage({
    super.key, required this.id,
  });


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(child: Consumer<RestaurantProvider>(
          builder: (context, state, child) {
            if (state.state == ResultState.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.state == ResultState.hasData) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildImage(context, state.restaurantDetailResult),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      children: [
                        const SizedBox(height: 24),
                        _buildNameAndLocation(
                            context, state.restaurantDetailResult),
                        const SizedBox(height: 24),
                        _buildDescription(
                            context, state.restaurantDetailResult),
                        const SizedBox(height: 24),
                        _buildMenu(context, state.restaurantDetailResult),
                      ],
                    ),
                  ),
                ],
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
        )),
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
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Foods',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      Text(
                        'Drinks',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    height: 220,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 40.w,
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: detail.restaurant.menus.foods.length,
                              itemBuilder: (context, index) {
                                return Center(
                                    child: CardMenu(
                                        menuName: detail.restaurant.menus
                                            .foods[index].name));
                              }),
                        ),
                        SizedBox(
                          width: 40.w,
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: detail.restaurant.menus.drinks.length,
                              itemBuilder: (context, index) {
                                return Center(
                                    child: CardMenu(
                                        menuName: detail.restaurant.menus
                                            .drinks[index].name));
                              }),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
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
              ),
            ),
            Text(
              detail.restaurant.city,
              style: Theme.of(context).textTheme.bodyLarge,
            )
          ],
        ),
      ],
    );
  }
}
