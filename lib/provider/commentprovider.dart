// // ignore_for_file: non_constant_identifier_names, avoid_print, prefer_const_constructors, use_build_context_synchronously, unused_field
//
// import 'package:backendapp/http.dart';
// import 'package:backendapp/models/commentsection_models.dart';
// import 'package:backendapp/utils/constants.dart';
// import 'package:flutter/material.dart';
// import "package:http/http.dart" as http;
//
//
// class CommentSectionProvider extends ChangeNotifier {
//   final TextEditingController _reviewController = TextEditingController();
//   CommentSectionModels? _comments;
//   bool _isLoading = false;
//
//   CommentSectionModels? get getCommentsData => _comments;
//   bool get isLoading => _isLoading;
//
//
//   Future<void> commentSectionProvider(uid) async {
//     _isLoading = true;
//     try {
//       CommentSectionModels commentsection = await NetworkCalling().fetchComments("$baseUrl/rescomments/$uid");
//       // CommentSectionModels commentsection = await NetworkCalling().fetchComments("$baseUrl/rescomments/PIZFOO4357128905678");
//       _comments = commentsection;
//     } catch (e) {
//       print('Error fetching comments: $e');
//       _comments = null; // Set to null if there's an error
//     } finally {
//       _isLoading = false; // Ensure isLoading is set to false when done
//       notifyListeners();
//     }
//   }
//
//   ///////////////////// Average calculating ///////////////////
//   double get averageRating {
//     if (_comments?.reviews.isNotEmpty == true) {
//       return calculateAverageRating(_comments!);
//     } else {
//       return 0.0; // Return 0.0 if there are no comments or if _comments is null
//     }
//   }
//
//   double calculateAverageRating(CommentSectionModels comments) {
//     if (comments.reviews.isEmpty) {
//       return 0.0;
//     }
//
//     int total = comments.reviews.fold(0, (sum, review) => sum + review.rating);
//     return total / comments.reviews.length;
//   }
//
//   ////////////////////////////////////////// post comment below //////////////////////////
//
//   Future<bool> postCommentProvider({
//     required BuildContext context,
//     required int rating,
//     required String business_uid,
//     required String user_id,
//     required List<String> selectedSuggestions, // List of selected suggestions
//     required List<String> userReviews, // List of user-written reviews
//   }) async {
//     // print('postCommentProvider called'); // Debug print statement
//     try {
//       _isLoading = true;
//
//       final body = {
//         'rating': rating.toString(),
//         'business_uid': business_uid,
//         'user_id': user_id,
//         'selected_suggestions':
//             selectedSuggestions.join(' + '), // Join the suggestions with ' + '
//         'user_reviews': userReviews.join(' + '), // Join the reviews with ' + '
//       };
//
//       final url = Uri.parse("$baseUrl/postcomment");
//       final headers = {'Content-Type': 'application/x-www-form-urlencoded'};
//
//       final response = await http.post(url, headers: headers, body: body);
//       if (response.statusCode == 200) {
//         print("comment posted successfully");
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text("Your review posted Successfully"),
//             behavior: SnackBarBehavior.floating,
//           ),
//         );
//
//         await commentSectionProvider(business_uid);
//
//         _isLoading = false;
//         return true;
//       } else {
//         print("Failed to post comment. Status code: ${response.statusCode}");
//         print('Response body: ${response.body}');
//         return false;
//       }
//     } catch (e) {
//       print('Error posting data: $e');
//       return false;
//     } finally {
//       _isLoading = false;
//     }
//   }
//   ///////////////   Edit comment ////////////
//
//
//   Future<bool> editCommentProvider({
//     required BuildContext context,
//     required String business_uid,
//     required String review_id,
//     required String user_id,
//     required int rating,
//     required String newReview, // This should be the combined review string
//   }) async {
//     try {
//       _isLoading = true;
//
//       final body = {
//         'business_uid': business_uid,
//         'review_id': review_id,
//         'user_id': user_id,
//         'rating': rating.toString(),
//         'review': newReview, // Send the combined review string
//       };
//
//       final url = Uri.parse("$baseUrl/editcomment");
//       final headers = {'Content-Type': 'application/x-www-form-urlencoded'};
//
//       final response = await http.put(url, headers: headers, body: body);
//       if (response.statusCode == 200) {
//         print("comment edited successfully");
//         _isLoading = false;
//
//         // Show a snackbar with a success message
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text("Review updated successfully"),
//             behavior: SnackBarBehavior.floating,
//           ),
//         );
//         // Refresh the comments to reflect the changes
//         await commentSectionProvider(business_uid);
//
//         return true;
//       } else {
//         print("Failed to edit comment. Status code: ${response.statusCode}");
//         print('Response body: ${response.body}');
//         return false;
//       }
//     } catch (e) {
//       print('Error editing comment: $e');
//       return false;
//     } finally {
//       _isLoading = false;
//     }
//   }
//
//   /////////////////  delete comment //////////////////
//   ///
//   Future<bool> deleteCommentProvider({
//     required BuildContext context, // Context needed to show the snackbar
//     required String business_uid,
//     required String review_id,
//     required String user_id,
//   }) async {
//     try {
//       _isLoading = true;
//
//       final body = {
//         'business_uid': business_uid,
//         'review_id': review_id,
//         'user_id': user_id,
//       };
//
//       final url = Uri.parse("$baseUrl/deletecomment");
//       final headers = {'Content-Type': 'application/x-www-form-urlencoded'};
//
//       final response = await http.delete(url, headers: headers, body: body);
//       if (response.statusCode == 200) {
//         print("comment deleted successfully");
//         _isLoading = false;
//
//
//         // }
//
//         // Refresh the comments to reflect the changes
//         await commentSectionProvider(business_uid);
//
//         return true;
//       } else {
//         print("Failed to delete comment. Status code: ${response.statusCode}");
//         print('Response body: ${response.body}');
//         return false;
//       }
//     } catch (e) {
//       print('Error deleting comment: $e');
//       return false;
//     } finally {
//       _isLoading = false;
//     }
//   }
// }




// ignore_for_file: unused_import, prefer_const_constructors

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "package:http/http.dart" as http;
import 'package:geolocator/geolocator.dart';

import '../models/commentsection_models.dart';
import '../utils/constants.dart';



class CommentSectionProvider extends ChangeNotifier {
  final TextEditingController _reviewController = TextEditingController();
  List<CommentsModels> _comments = [];
  bool _isLoading = false;

  List<CommentsModels> get comments => _comments;
  bool get isLoading => _isLoading;

  // Get comments
  Future<void> getComments(String business_id) async {
    String url = "$baseUrl/comments/where?business_id=$business_id";
    try {
      _isLoading = true;
      notifyListeners();

      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        _comments = responseData.map((data) => CommentsModels.fromJson(data)).toList();
        print(_comments);
      }else if (response.statusCode == 404) {
        // If the status code is 400, return an empty list
        _comments = [];
        print('No comments found: status code 404');
      } else {
        throw Exception('Failed to load comments');
      }
    } catch (error) {
      print(error);
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void reset() {
    _comments = [];
    _isLoading = false;
    notifyListeners();
  }

}
