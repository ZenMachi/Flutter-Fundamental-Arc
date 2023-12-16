import 'package:flutter/material.dart';
import 'package:submission_restaurant_app/restaurant_detail.dart';

import '../data/model/restaurants.dart';

class CardItem extends StatelessWidget {
  final Restaurant restaurant;

  const CardItem({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, RestaurantDetailPage.routeName, arguments: restaurant);
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
                                value: loadingProgress.expectedTotalBytes != null
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
                          Icon(
                            Icons.pin_drop_outlined,
                            size: 16,
                            color: Theme.of(context)
                                .colorScheme
                                .onSecondaryContainer,
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
                        child: Icon(
                          Icons.star,
                          color: Theme.of(context).colorScheme.tertiary,
                          size: 18,
                        ),
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