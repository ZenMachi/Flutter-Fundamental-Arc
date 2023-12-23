import 'package:flutter/material.dart';
import 'package:submission_restaurant_app/data/model/restaurant_detail.dart';

class DialogReviewItem extends StatelessWidget {
  const DialogReviewItem({
    super.key,
    required this.context,
    required this.detail,
  });

  final BuildContext context;
  final RestaurantDetail detail;

  @override
  Widget build(BuildContext context) {
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
}
