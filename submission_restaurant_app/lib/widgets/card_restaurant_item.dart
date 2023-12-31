import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';

import '../data/model/restaurant.dart';

class CardRestaurant extends StatelessWidget {
  final Restaurant restaurant;
  final Function() onTap;

  const CardRestaurant(
      {super.key, required this.restaurant, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: InkWell(
          onTap: onTap,
          child: Card(
              color: Theme.of(context).colorScheme.surface,
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
                          "https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}",
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
                          errorBuilder: (_, __, ___) {
                            return const Icon(Icons.error_outline);
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
                              color: Theme.of(context).colorScheme.onSurface),
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
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                            ),
                          ),
                          Text(
                            restaurant.city,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.apply(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface),
                          )
                        ],
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: RatingBarIndicator(
                              rating: restaurant.rating,
                              itemSize: 18,
                              itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  )))
                    ],
                  )
                ],
              )),
        ),
      ),
    );
  }
}
