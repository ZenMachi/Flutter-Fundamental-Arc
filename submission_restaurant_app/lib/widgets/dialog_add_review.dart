import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission_restaurant_app/data/model/post_review_body.dart';
import 'package:submission_restaurant_app/data/model/restaurant_detail.dart';
import 'package:submission_restaurant_app/provider/api_provider.dart';

class DialogAddReview extends StatefulWidget {
  const DialogAddReview({
    super.key,
    required this.context,
    required this.id,
  });

  final BuildContext context;
  final String id;

  @override
  State<DialogAddReview> createState() => _DialogAddReviewState();
}

class _DialogAddReviewState extends State<DialogAddReview> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: Text('Add Review'),
      actions: [
        ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                _addReview();
              }
            },
            child: Text('Add'))
      ],
      content: ConstrainedBox(
          constraints:
              BoxConstraints(minHeight: 200, minWidth: 300, maxWidth: 300),
          child: Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    controller: nameController,
                    decoration: InputDecoration(labelText: 'Nama'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please check the name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    controller: reviewController,
                    decoration: InputDecoration(labelText: 'Review'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please check the review';
                      }
                      return null;
                    },
                  )
                ],
              ))),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Future<void> _addReview() async {
    String id = widget.id;
    String name = nameController.text.trim();
    String review = reviewController.text.trim();
    PostReviewBody reviewBody =
        PostReviewBody(id: id, name: name, review: review);

    var provider = Provider.of<ApiProvider>(context, listen: false);
    await provider.postReviewResturant(reviewBody);

    if (provider.state == ResultState.loading) {
      _showSnackbar('Processing');
    } else if (provider.state == ResultState.hasData) {
      _showSnackbar('Review Added');
      Future.delayed(Duration(seconds: 4), () => Navigator.of(context).pop());
    } else if (provider.state == ResultState.noData) {
      _showSnackbar('Review Failed to add');
    } else if (provider.state == ResultState.error) {
      _showSnackbar(provider.message);
      Future.delayed(Duration(milliseconds: 750), () => Navigator.of(context).pop());
    } else {
      _showSnackbar('Unknown Error');
    }
  }

  _showSnackbar(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
