import 'dart:convert';

import 'package:submission_restaurant_app/data/model/customer_review.dart';

class ReviewResponse {
  bool error;
  String message;
  List<CustomerReview> customerReviews;

  ReviewResponse({
    required this.error,
    required this.message,
    required this.customerReviews,
  });

  factory ReviewResponse.fromRawJson(String str) =>
      ReviewResponse.fromJson(json.decode(str));

  factory ReviewResponse.fromJson(Map<String, dynamic> json) => ReviewResponse(
        error: json["error"],
        message: json["message"],
        customerReviews: List<CustomerReview>.from(
            json["customerReviews"].map((x) => CustomerReview.fromJson(x))),
      );
}
