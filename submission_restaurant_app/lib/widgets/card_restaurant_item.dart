import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:submission_restaurant_app/ui/restaurant_detail.dart';

import '../data/model/restaurants.dart';

class CardRestaurantItem extends StatelessWidget {
  final Restaurant restaurant;

  const CardRestaurantItem({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, RestaurantDetailPage.routeName,
                arguments: restaurant);
          },
          child: Card(
              color: Theme.of(context).colorScheme.secondaryContainer,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Hero(
                        tag: restaurant.pictureId,
                        child: Image.network(
                          restaurant.pictureId,
                          width: 128,
                          height: 92,
                          fit: BoxFit.fitHeight,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            }
                            return Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 2),
                        child: Text(
                          restaurant.name,
                          style: Theme.of(context).textTheme.titleMedium?.apply(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSecondaryContainer),
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 2.0,
                              right: 4.0,
                            ),
                            child: SvgPicture.asset(
                              'images/icons/icon_location.svg',
                              width: 12,
                            ),
                          ),
                          Text(
                            restaurant.city,
                            style: Theme.of(context).textTheme.bodySmall?.apply(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSecondaryContainer),
                          )
                        ],
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: RatingBarIndicator(
                            rating: restaurant.rating,
                            itemSize: 18,
                            itemBuilder: (context, index) {
                              return Icon(
                                Icons.star,
                                color: Theme.of(context).colorScheme.tertiary,
                              );
                            },
                          )
                          // Icon(
                          //   Icons.star,
                          //   color: Theme.of(context).colorScheme.tertiary,
                          //   size: 18,
                          // ),
                          )
                    ],
                  )
                ],
              )),
        ),
      ),
    );
  }
}
