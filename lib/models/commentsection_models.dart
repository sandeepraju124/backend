// import 'dart:convert';
//
// CommentSectionModels commentSectionModelsFromJson(String str) =>
//     CommentSectionModels.fromJson(json.decode(str));
//
// String commentSectionModelsToJson(CommentSectionModels data) =>
//     json.encode(data.toJson());
//
// class CommentSectionModels {
//   String id;
//   String businessUid;
//   List<Review> reviews;
//
//   CommentSectionModels({
//     required this.id,
//     required this.businessUid,
//     required this.reviews,
//   });
//
//   factory CommentSectionModels.fromJson(Map<String, dynamic> json) {
//     var reviewsJson = json["reviews"] as List<dynamic>? ?? [];
//     var reviewsList = reviewsJson.map((x) => Review.fromJson(x)).toList();
//     return CommentSectionModels(
//       id: json["_id"],
//       businessUid: json["business_uid"],
//       reviews: reviewsList,
//     );
//   }
//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "business_uid": businessUid,
//         "reviews": List<dynamic>.from(reviews.map((x) => x.toJson())),
//       };
//
//   List<Review> get reversedReviews {
//     List<Review> reversed = List.from(reviews);
//     reversed = reversed.reversed.toList();
//     return reversed;
//   }
// }
//
// // class Review {
// //   String comment;
// //   DateTime createdAt;
// //   int rating;
// //   String userId;
// //   String? username;
//
// //   Review({
// //     required this.comment,
// //     required this.createdAt,
// //     required this.rating,
// //     required this.userId,
// //     this.username,
// //   });
//
// //   factory Review.fromJson(Map<String, dynamic> json) => Review(
// //         comment: json["comment"],
// //         createdAt: DateTime.parse(json["created_at"]),
// //         rating: json["rating"],
// //         userId: json["user_id"],
// //         username: json["username"],
// //       );
//
// //   Map<String, dynamic> toJson() => {
// //         "comment": comment,
// //         "created_at": createdAt.toIso8601String(),
// //         "rating": rating,
// //         "user_id": userId,
// //         "username": username,
// //       };
//
// class Review {
//   String comment;
//   DateTime createdAt;
//   int rating;
//   String userId;
//   String? username;
//   String? reviewId;
//   DateTime? updatedAt;
//
//   Review({
//     required this.comment,
//     required this.createdAt,
//     required this.rating,
//     required this.userId,
//     this.username,
//     this.reviewId,
//     this.updatedAt,
//   });
//
//   factory Review.fromJson(Map<String, dynamic> json) => Review(
//         comment: json["comment"],
//         createdAt: DateTime.parse(json["created_at"]),
//         rating: json["rating"],
//         userId: json["user_id"],
//         username: json["username"],
//         reviewId: json["review_id"],
//         updatedAt: json["updated_at"] == null
//             ? null
//             : DateTime.parse(json["updated_at"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "comment": comment,
//         "created_at": createdAt.toIso8601String(),
//         "rating": rating,
//         "user_id": userId,
//         "username": username,
//         "review_id": reviewId,
//         "updated_at": updatedAt?.toIso8601String(),
//       };
// }


// To parse this JSON data, do
//
//     final nearbyComments = nearbyCommentsFromJson(jsonString);

import 'dart:convert';

List<CommentsModels> nearbyCommentsFromJson(String str) => List<CommentsModels>.from(json.decode(str).map((x) => CommentsModels.fromJson(x)));

String nearbyCommentsToJson(List<CommentsModels> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CommentsModels {
  String businessId;
  dynamic businessName;
  String comment;
  int commentId;
  String createdAt;
  String lat;
  String long;
  dynamic profileImageUrl;
  int rating;
  String updatedAt;
  String userId;
  String userName;

  CommentsModels({
    required this.businessId,
    required this.businessName,
    required this.comment,
    required this.commentId,
    required this.createdAt,
    required this.lat,
    required this.long,
    required this.profileImageUrl,
    required this.rating,
    required this.updatedAt,
    required this.userId,
    required this.userName,
  });

  factory CommentsModels.fromJson(Map<String, dynamic> json) => CommentsModels(
    businessId: json["business_id"],
    businessName: json["business_name"],
    comment: json["comment"],
    commentId: json["comment_id"],
    createdAt: json["created_at"],
    lat: json["lat"],
    long: json["long"],
    profileImageUrl: json["profile_image_url"],
    rating: json["rating"],
    updatedAt: json["updated_at"],
    userId: json["user_id"],
    userName: json["user_name"],
  );

  Map<String, dynamic> toJson() => {
    "business_id": businessId,
    "business_name": businessName,
    "comment": comment,
    "comment_id": commentId,
    "created_at": createdAt,
    "lat": lat,
    "long": long,
    "profile_image_url": profileImageUrl,
    "rating": rating,
    "updated_at": updatedAt,
    "user_id": userId,
    "user_name": userName,
  };
}
