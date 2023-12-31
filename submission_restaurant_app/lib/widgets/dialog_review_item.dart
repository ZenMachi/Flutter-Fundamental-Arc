import 'package:flutter/material.dart';
import 'package:submission_restaurant_app/data/model/restaurant_detail_response.dart';

class DialogReviewItem extends StatelessWidget {
  const DialogReviewItem({
    super.key,
    required this.context,
    required this.detail,
  });

  final BuildContext context;
  final RestaurantDetailResponse detail;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: const Text('Reviews'),
      actions: [
        ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'))
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
                        const SizedBox(
                          height: 12,
                        ),
                        Text(detail.restaurant.customerReviews[index].date),
                      ],
                    ),
                  ),
                  const Divider()
                ],
              );
            }),
      ),
    );
  }
}
