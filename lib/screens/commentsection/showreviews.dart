// // ignore: duplicate_ignore
// // ignore: duplicate_ignore
// // ignore: duplicate_ignore
// // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
//
// import 'dart:core';
//
// import 'package:backendapp/provider/commentprovider.dart';
// import 'package:backendapp/utils/constants.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:line_awesome_flutter/line_awesome_flutter.dart';
// import 'package:provider/provider.dart';
//
// import "package:intl/intl.dart";
//
// import "package:lottie/lottie.dart";
//
// class NewShowRewviewPage extends StatefulWidget {
//   const NewShowRewviewPage({super.key});
//
//   @override
//   State<NewShowRewviewPage> createState() => _NewShowRewviewPageState();
// }
//
// class _NewShowRewviewPageState extends State<NewShowRewviewPage> {
//   @override
//
//   final bool _showAllReviews = false;
//
//   Widget stars(int rating) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: List.generate(
//           rating,
//           (index) => Padding(
//                 padding: const EdgeInsets.only(right: 4, bottom: 7, top: 10),
//                 child: Container(
//                   width: 17,
//                   height: 17,
//                   decoration: BoxDecoration(
//                       color: tgDarkPrimaryColor,
//                       borderRadius: BorderRadius.circular(4),
//                       border: Border.all(color: Colors.black, width: 0.3)),
//                   child: Icon(
//                     Icons.star,
//                     color: Colors.white,
//                     // color: Colors.amber[700],
//                     size: 12,
//                   ),
//                 ),
//               )),
//     );
//   }
//
//   String formatDateTime(DateTime dateTime) {
//     final DateTime localDateTime = dateTime.toLocal();
//     final DateFormat dateFormatter = DateFormat('dd-MM-yyyy (EEE)', 'en_US');
//     final DateFormat timeFormatter = DateFormat('h:mm a', 'en_US');
//     return '${dateFormatter.format(localDateTime)} at ${timeFormatter.format(localDateTime)}';
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var data = Provider.of<CommentSectionProvider>(context);
//
//     return ListView(children: [
//       Padding(
//         padding: const EdgeInsets.only(top: 24),
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(left: 16),
//               child: Row(
//                 children: [
//                   SizedBox(width: 10),
//                   Text(
//                     "Reviews",
//                     style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
//                   ),
//                   SizedBox(
//                       width:
//                           10), // Add some space between the text and the rating bar
//                   Expanded(
//                     child: Row(
//                       children: [
//                         // Text(
//                         //   "(",
//                         //   style: TextStyle(
//                         //       fontSize: 16, fontWeight: FontWeight.w400),
//                         // ),
//                         RatingBar.builder(
//                           initialRating:4.0,
//                               // Provider.of<CommentSectionProvider>(context)
//                               //     .averageRating,
//                           minRating: 1,
//                           direction: Axis.horizontal,
//                           allowHalfRating: true,
//                           itemCount: 5,
//                           itemPadding: EdgeInsets.symmetric(horizontal: 0.1),
//                           itemSize: 11,
//                           itemBuilder: (context, _) => Icon(
//                             Icons.star,
//                             color: Colors.amber[700],
//                           ),
//                           onRatingUpdate: (rating) {
//                             print(rating);
//                           },
//                         ),
//                         SizedBox(width: 5),
//                         Text(
//                           "(",
//                           style: TextStyle(
//                               fontSize: 16, fontWeight: FontWeight.w400),
//                         ),
//                         Text(
//                           Provider.of<CommentSectionProvider>(context)
//                               .averageRating
//                               .toStringAsFixed(1),
//                           style: TextStyle(
//                               color: Colors.black87,
//                               fontSize: 13,
//                               fontWeight: FontWeight.w400),
//                         ),
//                         Text(
//                           ")",
//                           style: TextStyle(
//                               fontSize: 16, fontWeight: FontWeight.w400),
//                         ),
//                         SizedBox(width: 5),
//                         Text(
//                           "(",
//                           style: TextStyle(
//                               fontSize: 16, fontWeight: FontWeight.w400),
//                         ),
//                         Text(data.getCommentsData?.reviews.length.toString() ??
//                             "0"),
//                         Text(
//                           ")",
//                           style: TextStyle(
//                               fontSize: 16, fontWeight: FontWeight.w400),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.only(right: 280),
//               height: 3,
//               width: 70,
//               decoration: BoxDecoration(
//                   border: Border(bottom: BorderSide(color: tgPrimaryColor))),
//             )
//           ],
//         ),
//       ),
//       GestureDetector(
//         onTap: () {
//           showModalBottomSheet(
//             context: context,
//             elevation: 6,
//             isScrollControlled: true,
//             backgroundColor: Colors.transparent,
//             builder: (BuildContext context) {
//               return Builder(
//                 builder: (context) {
//                   return Padding(
//                     padding: EdgeInsets.only(
//                       bottom: MediaQuery.of(context).viewInsets.bottom,
//                     ),
//                     child: SingleChildScrollView(
//                       child: Container(
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.only(
//                             topLeft: Radius.circular(20),
//                             topRight: Radius.circular(20),
//                           ),
//                         ),
//                         child: Column(
//                           children: [
//                             Container(
//                               padding: EdgeInsets.all(20),
//                               decoration: BoxDecoration(
//                                 color: secondaryColor20LightTheme,
//                                 borderRadius: BorderRadius.only(
//                                   topLeft: Radius.circular(20),
//                                   topRight: Radius.circular(20),
//                                 ),
//                               ),
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text(
//                                     "Share Your Experience",
//                                     style: TextStyle(
//                                       color: Colors.black,
//                                       fontSize: 15,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Padding(
//                                 padding: const EdgeInsets.all(4.0),
//                                 child: Text("xnxnnxnx")
//                                 // DisplayReviewBottomSheet(
//                                 //   businessUid:
//                                 //       data1.businessProfileData!.businessUid,
//                                 // ),
//                                 ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               );
//             },
//           );
//         },
//         child: Column(
//           children: [
//             // Padding(
//             //   padding: const EdgeInsets.only(top: 20),
//             //   child: Container(
//             //     height: 30,
//             //     width: 360,
//             //     decoration: BoxDecoration(
//             //       border: Border.all(
//             //         color: secondaryColor40LightTheme,
//             //       ),
//             //       // color: tgPrimaryColor
//             //     ),
//             //     child: Padding(
//             //       padding: const EdgeInsets.only(left: 70),
//             //       child: Row(
//             //         children: [
//             //           Text(
//             //             "Share your insights and help others!",
//             //             style: TextStyle(color: tgPrimaryText, fontSize: 12),
//             //           ),
//             //           Padding(
//             //             padding: const EdgeInsets.only(left: 70),
//             //             child: Icon(
//             //               LineAwesomeIcons.angle_right,
//             //               size: 20,
//             //             ),
//             //           )
//             //         ],
//             //       ),
//             //     ),
//             //   ),
//             // )
//           ],
//         ),
//       ),
//       data.isLoading
//           ? Padding(
//               padding: const EdgeInsets.only(top: 200),
//               child: Center(
//                   child: CircularProgressIndicator(color: tgPrimaryColor)),
//             )
//           : data.getCommentsData?.reviews.isEmpty == true
//               ? Center(
//                   child: Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 20),
//                   child: Column(
//                     children: [
//                       SizedBox(height: 30),
//                       // Lottie.asset("images/reviews.json", height: 210),
//                       Padding(
//                         padding: const EdgeInsets.only(top: 50),
//                         child: Lottie.asset("assets/Empty.json", height: 200),
//                       ),
//                       Text(
//                         "Your opinion matters.\nPlease consider being the first to share your review",
//                         style: TextStyle(
//                             color: secondaryColor20LightTheme, fontSize: 10.8),
//                       ),
//                     ],
//                   ),
//                 ))
//               : ListView.builder(
//                   physics: NeverScrollableScrollPhysics(),
//                   shrinkWrap: true,
//                   // itemCount: data.getCommentsData!.reviews.length,
//                   itemCount:
//                   // 10,
//                   data.getCommentsData?.reviews.length,
//
//                   // _showAllReviews
//                   //     ? (data.getCommentsData?.reviews.length ?? 0)
//                   //     : ((data.getCommentsData?.reviews.length ?? 0) > 2
//                   //         ? 2
//                   //         : (data.getCommentsData?.reviews.length ?? 0)),
//
//                   itemBuilder: (BuildContext context, int int) {
//                     var review = data.getCommentsData!.reviews[int];
//
//                     // String stars(rating) {
//                     //   return List<String>.generate(rating, (index) => '⭐')
//                     //       .join();
//                     // }
//
//                     return Container(
//                       margin: EdgeInsets.all(8.0),
//                       padding: EdgeInsets.all(8.0),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(10.0),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.grey.withOpacity(0.5),
//                             spreadRadius: 5,
//                             blurRadius: 7,
//                             offset: Offset(0, 3),
//                           ),
//                         ],
//                       ),
//                       child: ListTile(
//                         title: Padding(
//                           padding: const EdgeInsets.only(top: 2, bottom: 8),
//                           child: Text(
//                             review.comment,
//                             style: TextStyle(
//                                 fontFamily: "Roboto",
//                                 fontSize: 14.0,
//                                 fontWeight: FontWeight.w500,
//                                 wordSpacing: 0.5,
//                                 letterSpacing: -0.1,
//                                 color: secondaryColor60LightTheme),
//                           ),
//                         ),
//                         subtitle: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               children: [
//                                 // Text(
//                                 //   "Rating: ",
//                                 //   style: TextStyle(fontSize: 12.0),
//                                 // ),
//                                 stars(review.rating),
//                               ],
//                             ), // This will display the row of stars
//                             Text(
//                               "Posted by: ${review.username}\nDate: ${formatDateTime(review.createdAt)}",
//                               style: TextStyle(fontSize: 12.0),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   }),
//     ]);
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../../models/commentsection_models.dart';
import '../../provider/businessdata_provider.dart';
import '../../provider/commentprovider.dart';
import '../../utils/constants.dart';
// import 'package:cached_network_image/cached_network_image.dart';

class ImprovedCommentSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var data = Provider.of<BusinessDataProvider>(context);
    String _ratingString = "0";
    int _rating = 0;

    if (data.BusinessData != null &&
        data.BusinessData!.isNotEmpty &&
        data.BusinessData![0].avgRating != null) {
      _ratingString =
          double.parse(data.BusinessData![0].avgRating).toStringAsFixed(0);
      _rating = int.parse(_ratingString);
    }

    return Consumer<CommentSectionProvider>(
      builder: (context, provider, child) {
        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Reviews',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        // _buildRatingStars(data.BusinessData[0].avgRating),
                        // _buildRatingStars(5),
                        // customStars(3),
                        customStars(_rating),
                        // _buildRatingStars(data.BusinessData[0].avgRating),
                        SizedBox(width: 8),
                        Text(
                          // "5.0",
                          "${double.parse(data.BusinessData![0].avgRating).toStringAsFixed(1)} . (${data.BusinessData![0].totalReviews})",

                          // double.parse(data.BusinessData![0].avgRating).toStringAsFixed(1)
                          // '${provider.averageRating.toStringAsFixed(1)} (${provider.comments.length})',
                          // style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            provider.isLoading
                ? SliverFillRemaining(
                    child: Center(child: CircularProgressIndicator()),
                  )
                : provider.comments.isEmpty
                    ? SliverFillRemaining(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Lottie.asset('assets/business.json', width: 200),
                              SizedBox(height: 16),
                              Text(
                                'Be the first to leave a review!',
                                // style: Theme.of(context).textTheme.subtitle1,
                              ),
                            ],
                          ),
                        ),
                      )
                    : SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) => _buildCommentCard(
                              context, provider.comments[index]),
                          childCount: provider.comments.length,
                        ),
                      ),
          ],
        );
      },
    );
  }

  Widget _buildRatingStars(double rating) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < rating ? Icons.star : Icons.star_border,
          color: Colors.amber,
          size: 18,
        );
      }),
    );
  }

  Widget _buildCommentCard(BuildContext context, CommentsModels comment) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(comment.profileImageUrl),
                  // Image.network(comment.profileImageUrl),
                  // CachedNetworkImageProvider(comment.profileImageUrl),
                  radius: 20,
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        comment.userName,
                        // style: Theme.of(context).textTheme.subtitle1
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                          formatCreatedAt(
                            comment.createdAt,
                          ),
                          // "2d ago",
                          // DateFormat('MMM d, yyyy').format(comment.createdAt),
                          style: TextStyle(
                            fontSize: 11.2,
                            color: Colors.grey,
                          )),
                    ],
                  ),
                ),
                // _buildRatingStars(comment.rating.toDouble()),
                customStars(comment.rating),
              ],
            ),
            SizedBox(height: 17),
            Text(
              comment.comment,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
