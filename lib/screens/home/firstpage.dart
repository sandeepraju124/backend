// // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// import 'package:backendapp/provider/businessdata_provider.dart';
// import 'package:backendapp/provider/businessmongo_provider.dart';
// import 'package:backendapp/provider/commentprovider.dart';
// import 'package:backendapp/screens/home/bottomnav.dart';
// import 'package:backendapp/screens/progressbar.dart';
// import 'package:backendapp/screens/redirection.dart';
// import 'package:backendapp/utils/constants.dart';
// import 'package:backendapp/utils/navigators.dart';
// import 'package:backendapp/widgets/rating.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class Firstpage extends StatefulWidget {
//   const Firstpage({super.key});

//   @override
//   State<Firstpage> createState() => _FirstpageState();
// }

// class _FirstpageState extends State<Firstpage> {
//   @override
//   void initState() {
//     Future.delayed(Duration(seconds: 2), () {
//       // var dataAsk = Provider.of<AskCommunityProvider>(context, listen: false);
//       // dataAsk.fetchAskCommunityData("NEX1O16051534921137");
//     });
//     super.initState();
//   }

//   Future<void> RemoveBusinessUid() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.remove('businessUid');
//   }

//   String getGreeting() {
//     final now = DateTime.now();
//     final hour = now.hour;

//     if (hour < 12) {
//       return 'Good morning';
//     } else if (hour < 17) {
//       return 'Good afternoon';
//     } else {
//       return 'Good evening';
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     var data = Provider.of<BusinessDataProvider>(context);
//     var data2 = Provider.of<ServicesProvider>(context);
//     // var data3 = Provider.of<CommentSectionProvider>(context);
//     // String name = data.BusinessData![0].businessName ?? "Guest";
//     String name = (data.BusinessData != null && data.BusinessData!.isNotEmpty)
//         ? data.BusinessData![0].businessName
//         : "";

//     double getProgress() {
//       int totalTasks =
//           7; // Example: operating hours, amenities, profile information
//       int completedTasks = 0;

//       // Safely check if the properties are not null before accessing them
//       if (data.BusinessData != null) {
//         if (data.BusinessData!.isNotEmpty) {
//           if (data.BusinessData![0].contactInformation?.isNotEmpty ?? false)
//             completedTasks++;
//           if (data.BusinessData![0].businessEmail?.isNotEmpty ?? false)
//             completedTasks++;
//           if (data.BusinessData![0].address?.isNotEmpty ?? false)
//             completedTasks++;
//           if (data.BusinessData![0].businessDescription?.isNotEmpty ?? false)
//             completedTasks++;
//         }
//       }

//       if (data2.BusinessData != null) {
//         if (data2.BusinessData!.amenities != null) completedTasks++;
//         if (data2.BusinessData!.operatingHours != null) completedTasks++;
//         if (data2.BusinessData!.images != null) completedTasks++;
//       }

//       return completedTasks / totalTasks;
//     }

//     return Scaffold(
//         appBar: AppBar(
//           // leading: Center(child: Text("NearMe")),
//           automaticallyImplyLeading: false,
//           // elevation: 10,
//           title: Container(
//               width: 95,
//               child: Image.asset(
//                 "assets/nearme2.png",
//               )),
//           actions: [
//             GestureDetector(
//               onTap: () async {
//                 await FirebaseAuth.instance.signOut();
//                 await RemoveBusinessUid();
//                 Navigator.of(context).pushAndRemoveUntil(
//                   MaterialPageRoute(builder: (context) => redirection()),
//                   (Route<dynamic> route) => false,
//                 );
//               },
//               child: Padding(
//                 padding: const EdgeInsets.only(right: 10),
//                 child: Icon(Icons.notification_important_outlined),
//               ),
//             )
//           ],
//         ),
//         body: data.isLoading
//             ? Center(
//                 child: CircularProgressIndicator(
//                 color: tgPrimaryColor,
//               ))
//             : SingleChildScrollView(
//                 child: Column(
//                   // mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(
//                       height: 10,
//                     ),
//                     Divider(
//                       color: Colors.grey[200],
//                       thickness: 5,
//                     ),
//                     introduction(name),

//                     Divider(
//                       color: Colors.grey[200],
//                       thickness: 5,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Text(
//                         "View all insights...",
//                         style: TextStyle(color: tgDarkPrimaryColor),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(
//                           vertical: 20, horizontal: 40),
//                       child: Container(
//                         // padding: EdgeInsets.all(20.0),
//                         height: 160,
//                         decoration: BoxDecoration(
//                           border: Border.all(color: Colors.grey),
//                           // borderRadius: BorderRadius.circular(10.0),
//                           // color:
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 30, vertical: 10),
//                               child: Text("Start with a Headline",
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                   )),
//                             ),
//                             Container(
//                               padding: EdgeInsets.symmetric(horizontal: 10),
//                               margin: EdgeInsets.symmetric(horizontal: 20),
//                               // decoration: BoxDecoration(
//                               //   border: Border.all(color: Colors.grey),
//                               //   // borderRadius: BorderRadius.circular(5.0),
//                               // ),
//                               child: TextField(
//                                 decoration: InputDecoration(
//                                   hintStyle: TextStyle(color: Colors.grey),
//                                   hintText: 'Add a discription',
//                                   contentPadding: EdgeInsets.all(10.0),
//                                   border: InputBorder.none,
//                                 ),
//                               ),
//                             ),
//                             GestureDetector(
//                                 onTap: () {
//                                   showSnackBar(context,
//                                       "feature not available yet, stay tuned");
//                                 },
//                                 child: RetangularBorderBox("POST")),
//                             SizedBox(
//                               height: 10,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),

//                     SizedBox(
//                       height: 10,
//                     ),
//                     Divider(
//                       color: Colors.grey[200],
//                       thickness: 5,
//                     ),
//                     activity(),
//                     Divider(
//                       color: Colors.grey[200],
//                       thickness: 5,
//                     ),
//                     Center(
//                       // child: EnhancedHalfCircleProgressBar(0.3),
//                       child: EnhancedHalfCircleProgressBar(getProgress()),
//                     ),

//                     SizedBox(
//                       height: 10,
//                     ),
//                     Divider(
//                       color: Colors.grey[200],
//                       thickness: 5,
//                     ),

//                     GestureDetector(
//                         onTap: () async {
//                           final SharedPreferences prefs =
//                               await SharedPreferences.getInstance();
//                           final String? action = prefs.getString('businessUid');
//                           // await prefs.setString('businessUid', "VHAClcXeT7MAuIS24zb5rIha2J22");
//                           print("businessUid: $action");
//                           showSnackBar(context, action!);
//                         },
//                         child: Text("Print BusinessUid")),

//                     // Text(data.BusinessData![0].businessDescription)
//                   ],
//                 ),
//               ));
//   }

//   Widget activity() {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Text(
//                 'Activity',
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               Spacer(),
//               GestureDetector(
//                 onTap: () {
//                   Navigator.pushReplacement(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => Homepage(initialIndex: 1)));
//                   // showSnackBar(context, "feature not available yet, stay tuned");
//                 },
//                 child: Text(
//                   'View all insights...',
//                   style: TextStyle(
//                     color: tgDarkPrimaryColor,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 8),
//           Text(
//             'Last 30 days',
//             style: TextStyle(
//               fontSize: 16,
//               color: Colors.grey,
//             ),
//           ),
//           SizedBox(height: 16),
//           Row(
//             children: [
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Nearme page visits',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     Divider(
//                       color: Colors.red,
//                       thickness: 2,
//                     ),
//                     Text(
//                       '--',
//                       style: TextStyle(
//                         fontSize: 24,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Leads',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     Divider(
//                       color: Colors.transparent,
//                       thickness: 2,
//                     ),
//                     Text(
//                       '--',
//                       style: TextStyle(
//                         fontSize: 24,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 16),
//           Text(
//             "We've just started tracking your page's activity, and we can't wait to share the results. Check back tomorrow to see more.",
//             style: TextStyle(
//               fontSize: 16,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget introduction(String name) {
//     var data = Provider.of<CommentSectionProvider>(context);
//     String greet = getGreeting();
//     String _ratingString = Provider.of<CommentSectionProvider>(context)
//             .averageRating
//             .toStringAsFixed(0) ??
//         "0";
//     int _rating = int.parse(_ratingString);

//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             // 'Good afternoon, $name',
//             '$greet, $name',
//             // '$greet, ${name ?? "Guest"}',
//             style: TextStyle(
//               fontSize: 21.2,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           SizedBox(height: 8),
//           GestureDetector(
//             onTap: () {
//               // navigatorPush(context, Homepage(initialIndex: 3));
//               Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => Homepage(initialIndex: 3)));
//               // navigatorPush(context, Homepage(initialIndex: 3));
//             },
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'nearme restaurent',
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     SizedBox(height: 8),
//                     Row(
//                       children: [
//                         StarRating(
//                           rating: _rating,
//                           // rating: 4,
//                           filledStarColor:
//                               tgDarkPrimaryColor, // Adjust as needed
//                           unfilledStarColor: Colors.grey, // Adjust as needed
//                         ),
//                         SizedBox(width: 8),
//                         Text(
//                           data.getCommentsData?.reviews != null
//                               ? "${data.getCommentsData!.reviews.length} reviews"
//                               : " reviews",
//                           style: TextStyle(
//                             fontSize: 13,
//                             color: Colors.teal,
//                           ),
//                         )
//                       ],
//                     ),
//                   ],
//                 ),
//                 Icon(Icons.keyboard_arrow_right_rounded),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:backendapp/screens/task_progress_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:backendapp/provider/businessdata_provider.dart';
import 'package:backendapp/provider/businessmongo_provider.dart';
import 'package:backendapp/provider/commentprovider.dart';
import 'package:backendapp/screens/home/bottomnav.dart';
import 'package:backendapp/screens/redirection.dart';
import 'package:backendapp/utils/constants.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../chat.dart';
import 'homepage_new.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final TextEditingController _postController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String getGreeting() {
    final now = DateTime.now();
    final hour = now.hour;
    if (hour < 12) return 'Good morning';
    if (hour < 17) return 'Good afternoon';
    return 'Good evening';
  }

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<BusinessDataProvider>(context);
    var data2 = Provider.of<ServicesProvider>(context);
    var commentData = Provider.of<CommentSectionProvider>(context);

    String name = (data.BusinessData != null && data.BusinessData!.isNotEmpty)
        ? data.BusinessData![0].businessName
        : "Guest";

    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: data.isLoading
          ? Center(child: CircularProgressIndicator(color: tgPrimaryColor))
          : SafeArea(
              child: AnimationLimiter(
                child: ListView(
                  padding: EdgeInsets.all(16),
                  children: AnimationConfiguration.toStaggeredList(
                    duration: const Duration(milliseconds: 375),
                    childAnimationBuilder: (widget) => SlideAnimation(
                      horizontalOffset: 50.0,
                      child: FadeInAnimation(
                        child: widget,
                      ),
                    ),
                    children: [
                      _buildHeader(name),
                      SizedBox(height: 20),
                      _buildQuickActions(),
                      SizedBox(height: 20),
                      _buildActivityCard(commentData),
                      SizedBox(height: 20),
                      _buildPostCard(),
                      SizedBox(height: 20),
                      _buildProgressCard(data, data2),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Widget _buildHeader(String name) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              getGreeting(),
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            GestureDetector(
              onTap: () async {
                String businessUid = await getBusinessUid(context);
                print(businessUid);
                showSnackBar(context, businessUid);
              },
              child: Text(
                name,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        CircleAvatar(
          backgroundColor: tgPrimaryColor,
          child: IconButton(
            icon: Icon(Icons.notifications_outlined, color: Colors.white),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => redirection()),
                (Route<dynamic> route) => false,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildActionButton(Icons.insights, 'Insights', () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => BottomNav(initialIndex: 1)),
          );
        }),
        _buildActionButton(Icons.storefront, 'My Business', () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => BottomNav(initialIndex: 2)),
          );
        }),
        _buildActionButton(Icons.forum, 'Community', () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => BottomNav(initialIndex: 3)),
          );
        }),
      ],
    );
  }

  Widget _buildActionButton(
      IconData icon, String label, VoidCallback onPressed) {
    return Column(
      children: [
        FloatingActionButton(
          heroTag: label,
          onPressed: onPressed,
          child: Icon(icon),
          backgroundColor: tgPrimaryColor,
        ),
        SizedBox(height: 8),
        Text(label, style: TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget _buildActivityCard(CommentSectionProvider commentData) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Activity Overview',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildActivityStat('Page Visits', '--'),
                // _buildActivityStat('Reviews', '${commentData.getCommentsData?.reviews.length ?? 0}'),
                // _buildActivityStat('Reviews', '0'),
                // _buildActivityStat('Rating', '${commentData.averageRating.toStringAsFixed(1)}'),
                _buildActivityStat('Rating', '0.0'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityStat(String label, String value) {
    return Column(
      children: [
        Text(value,
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: tgPrimaryColor)),
        SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
      ],
    );
  }

  Widget _buildPostCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Share an Update',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            TextField(
              controller: _postController,
              decoration: InputDecoration(
                hintText: 'What\'s new with your business?',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              child: Text('Post Update'),
              onPressed: () {
                showSnackBar(context, 'Feature coming soon!');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: tgPrimaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressCard(BusinessDataProvider data, ServicesProvider data2) {
    double progress = _calculateProgress(data, data2);
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return TasksScreen();
        }));
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Profile Completion',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 16),
              LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(tgPrimaryColor),
              ),
              SizedBox(height: 8),
              Text('${(progress * 100).toInt()}% Complete',
                  style: TextStyle(fontSize: 14, color: Colors.grey[600])),
            ],
          ),
        ),
      ),
    );
  }

  double _calculateProgress(BusinessDataProvider data, ServicesProvider data2) {
    int totalTasks = 7;
    int completedTasks = 0;

    if (data.BusinessData != null && data.BusinessData!.isNotEmpty) {
      if (data.BusinessData![0].contactInformation?.isNotEmpty ?? false)
        completedTasks++;
      if (data.BusinessData![0].businessEmail?.isNotEmpty ?? false)
        completedTasks++;
      if (data.BusinessData![0].address?.isNotEmpty ?? false) completedTasks++;
      if (data.BusinessData![0].businessDescription?.isNotEmpty ?? false)
        completedTasks++;
    }

    if (data2.BusinessData != null) {
      if (data2.BusinessData!.amenities != null) completedTasks++;
      if (data2.BusinessData!.operatingHours != null) completedTasks++;
      if (data2.BusinessData!.images != null) completedTasks++;
    }

    return completedTasks / totalTasks;
  }
}
