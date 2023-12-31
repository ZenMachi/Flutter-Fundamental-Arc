import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission_restaurant_app/common/navigation.dart';
import 'package:submission_restaurant_app/data/model/post_review_body.dart';
import 'package:submission_restaurant_app/provider/api_provider.dart';
import 'package:submission_restaurant_app/utils/result_state.dart';

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
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: const Text('Add Review'),
      actions: [
        ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _addReview();
              }
            },
            child: const Text('Add'))
      ],
      content: ConstrainedBox(
          constraints: const BoxConstraints(
              minHeight: 200, minWidth: 300, maxWidth: 300),
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'Nama'),
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
                    controller: _reviewController,
                    decoration: const InputDecoration(labelText: 'Review'),
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
    _nameController.dispose();
    _reviewController.dispose();
    super.dispose();
  }

  Future<void> _addReview() async {
    String id = widget.id;
    String name = _nameController.text.trim();
    String review = _reviewController.text.trim();
    PostReviewBody reviewBody =
        PostReviewBody(id: id, name: name, review: review);

    var provider = Provider.of<ApiProvider>(context, listen: false);
    await provider.postReviewRestaurant(reviewBody);

    if (provider.state == ResultState.loading) {
      _showSnackbar('Processing');
    } else if (provider.state == ResultState.hasData) {
      _showSnackbar('Review Added');
      Navigation.back();
    } else if (provider.state == ResultState.noData) {
      _showSnackbar('Review Failed to add');
    } else if (provider.state == ResultState.error) {
      _showSnackbar(provider.message);
      Future.delayed(
          const Duration(milliseconds: 750), () => Navigator.of(context).pop());
    } else {
      _showSnackbar('Unknown Error');
    }
  }

  _showSnackbar(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
