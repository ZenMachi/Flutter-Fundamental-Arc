import 'dart:convert';

class PostReviewBody {
  String id;
  String name;
  String review;

  PostReviewBody({
    required this.id,
    required this.name,
    required this.review,
  });

  factory PostReviewBody.fromRawJson(String str) =>
      PostReviewBody.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PostReviewBody.fromJson(Map<String, dynamic> json) => PostReviewBody(
        id: json["id"],
        name: json["name"],
        review: json["review"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "review": review,
      };
}
