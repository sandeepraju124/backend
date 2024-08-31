// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:backendapp/provider/businessdata_provider.dart';
// import 'package:backendapp/provider/businessmongo_provider.dart';
// import 'package:backendapp/provider/commentprovider.dart';
// import 'package:backendapp/screens/home/bottomnav.dart';
// import 'package:backendapp/screens/redirection.dart';
// import 'package:backendapp/utils/constants.dart';
// import 'package:backendapp/utils/navigators.dart';
// import 'package:backendapp/widgets/rating.dart';
// import '../chat.dart';
//
// class HomePageNew extends StatefulWidget {
//   const HomePageNew({Key? key}) : super(key: key);
//
//   @override
//   State<HomePageNew> createState() => _HomePageNewState();
// }
//
// class _HomePageNewState extends State<HomePageNew> {
//   @override
//   void initState() {
//     super.initState();
//     Future.delayed(Duration(seconds: 2), () {
//       // Fetch data if needed
//     });
//   }
//
//   Future<void> removeBusinessUid() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.remove('businessUid');
//   }
//
//   String getGreeting() {
//     final now = DateTime.now();
//     final hour = now.hour;
//
//     if (hour < 12) {
//       return 'Good morning';
//     } else if (hour < 17) {
//       return 'Good afternoon';
//     } else {
//       return 'Good evening';
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var data = Provider.of<BusinessDataProvider>(context);
//     var data2 = Provider.of<ServicesProvider>(context);
//     var commentData = Provider.of<CommentSectionProvider>(context);
//
//     String name = (data.BusinessData != null && data.BusinessData!.isNotEmpty)
//         ? data.BusinessData![0].businessName
//         : "Guest";
//
//     double getProgress() {
//       int totalTasks = 7;
//       int completedTasks = 0;
//
//       if (data.BusinessData != null && data.BusinessData!.isNotEmpty) {
//         if (data.BusinessData![0].contactInformation?.isNotEmpty ?? false) completedTasks++;
//         if (data.BusinessData![0].businessEmail?.isNotEmpty ?? false) completedTasks++;
//         if (data.BusinessData![0].address?.isNotEmpty ?? false) completedTasks++;
//         if (data.BusinessData![0].businessDescription?.isNotEmpty ?? false) completedTasks++;
//       }
//
//       if (data2.BusinessData != null) {
//         if (data2.BusinessData!.amenities != null) completedTasks++;
//         if (data2.BusinessData!.operatingHours != null) completedTasks++;
//         if (data2.BusinessData!.images != null) completedTasks++;
//       }
//
//       return completedTasks / totalTasks;
//     }
//
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: Image.asset("assets/nearme2.png", width: 95),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.notifications_outlined),
//             onPressed: () async {
//               await FirebaseAuth.instance.signOut();
//               await removeBusinessUid();
//               Navigator.of(context).pushAndRemoveUntil(
//                 MaterialPageRoute(builder: (context) => redirection()),
//                     (Route<dynamic> route) => false,
//               );
//             },
//           ),
//           IconButton(
//             icon: Icon(Icons.chat_bubble_outline),
//             onPressed: () async {
//               String? userId = await getUserId();
//               navigatorPush(context, ChatListScreen(userId: userId!));
//             },
//           ),
//         ],
//       ),
//       body: data.isLoading
//           ? Center(child: CircularProgressIndicator(color: tgPrimaryColor))
//           : RefreshIndicator(
//         onRefresh: () async {
//           // Implement refresh logic
//         },
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _buildHeaderCard(name, commentData),
//               _buildQuickPostCard(),
//               _buildActivityCard(),
//               _buildProfileCompletionCard(getProgress()),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildHeaderCard(String name, CommentSectionProvider commentData) {
//     return Card(
//       margin: EdgeInsets.all(16),
//       elevation: 2,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               '${getGreeting()}, $name',
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 16),
//             Row(
//               children: [
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'NearMe Restaurant',
//                         style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
//                       ),
//                       SizedBox(height: 8),
//                       Row(
//                         children: [
//                           StarRating(
//                             rating: int.parse(commentData.averageRating.toStringAsFixed(0)),
//                             filledStarColor: tgDarkPrimaryColor,
//                             unfilledStarColor: Colors.grey,
//                           ),
//                           SizedBox(width: 8),
//                           Text(
//                             '${commentData.getCommentsData?.reviews.length ?? 0} reviews',
//                             style: TextStyle(color: Colors.teal),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.arrow_forward_ios, color: tgDarkPrimaryColor),
//                   onPressed: () {
//                     Navigator.pushReplacement(
//                       context,
//                       MaterialPageRoute(builder: (context) => Homepage(initialIndex: 3)),
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildQuickPostCard() {
//     return Card(
//       margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       elevation: 2,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Quick Post',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 16),
//             TextField(
//               decoration: InputDecoration(
//                 hintText: 'What\'s new with your business?',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                   borderSide: BorderSide(color: Colors.grey[300]!),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                   borderSide: BorderSide(color: tgPrimaryColor),
//                 ),
//               ),
//               maxLines: 3,
//             ),
//             SizedBox(height: 16),
//             ElevatedButton(
//               child: Text('POST'),
//               onPressed: () {
//                 showSnackBar(context, "Feature not available yet, stay tuned");
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: tgPrimaryColor,
//                 padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildActivityCard() {
//     return Card(
//       margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       elevation: 2,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Activity',
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                 ),
//                 TextButton(
//                   child: Text('View all insights', style: TextStyle(color: tgDarkPrimaryColor)),
//                   onPressed: () {
//                     Navigator.pushReplacement(
//                       context,
//                       MaterialPageRoute(builder: (context) => Homepage(initialIndex: 1)),
//                     );
//                   },
//                 ),
//               ],
//             ),
//             Text('Last 30 days', style: TextStyle(color: Colors.grey)),
//             SizedBox(height: 16),
//             Row(
//               children: [
//                 Expanded(
//                   child: _buildActivityItem('NearMe page visits', '--', Colors.blue),
//                 ),
//                 SizedBox(width: 16),
//                 Expanded(
//                   child: _buildActivityItem('Leads', '--', Colors.green),
//                 ),
//               ],
//             ),
//             SizedBox(height: 16),
//             Text(
//               "We've just started tracking your page's activity. Check back tomorrow for more insights.",
//               style: TextStyle(fontSize: 14, color: Colors.grey[600]),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildActivityItem(String title, String value, Color color) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(title, style: TextStyle(fontWeight: FontWeight.w500)),
//         Divider(color: color, thickness: 2),
//         Text(value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
//       ],
//     );
//   }
//
//   Widget _buildProfileCompletionCard(double progress) {
//     return Card(
//       margin: EdgeInsets.all(16),
//       elevation: 2,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Profile Completion',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 16),
//             LinearProgressIndicator(
//               value: progress,
//               backgroundColor: Colors.grey[200],
//               valueColor: AlwaysStoppedAnimation<Color>(tgPrimaryColor),
//               minHeight: 10,
//             ),
//             SizedBox(height: 8),
//             Text(
//               '${(progress * 100).toInt()}% complete',
//               style: TextStyle(color: tgPrimaryColor, fontWeight: FontWeight.w500),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:backendapp/provider/businessdata_provider.dart';
import 'package:backendapp/provider/businessmongo_provider.dart';
import 'package:backendapp/provider/commentprovider.dart';
import 'package:backendapp/screens/home/bottomnav.dart';
import 'package:backendapp/screens/redirection.dart';
import 'package:backendapp/utils/constants.dart';
import 'package:backendapp/utils/navigators.dart';
import 'package:backendapp/widgets/rating.dart';
import '../chat.dart';
import 'package:fl_chart/fl_chart.dart';

class HomePageNew extends StatefulWidget {
  const HomePageNew({Key? key}) : super(key: key);

  @override
  State<HomePageNew> createState() => _HomePageNewState();
}

class _HomePageNewState extends State<HomePageNew> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      // Fetch data if needed
    });
  }

  Future<void> removeBusinessUid() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('businessUid');
  }

  String getGreeting() {
    final now = DateTime.now();
    final hour = now.hour;

    if (hour < 12) {
      return 'Good morning';
    } else if (hour < 17) {
      return 'Good afternoon';
    } else {
      return 'Good evening';
    }
  }

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<BusinessDataProvider>(context);
    var data2 = Provider.of<ServicesProvider>(context);
    var commentData = Provider.of<CommentSectionProvider>(context);

    String name = (data.BusinessData != null && data.BusinessData!.isNotEmpty)
        ? data.BusinessData![0].businessName
        : "Guest";

    double getProgress() {
      int totalTasks = 7;
      int completedTasks = 0;

      if (data.BusinessData != null && data.BusinessData!.isNotEmpty) {
        if (data.BusinessData![0].contactInformation?.isNotEmpty ?? false) completedTasks++;
        if (data.BusinessData![0].businessEmail?.isNotEmpty ?? false) completedTasks++;
        if (data.BusinessData![0].address?.isNotEmpty ?? false) completedTasks++;
        if (data.BusinessData![0].businessDescription?.isNotEmpty ?? false) completedTasks++;
      }

      if (data2.BusinessData != null) {
        if (data2.BusinessData!.amenities != null) completedTasks++;
        if (data2.BusinessData!.operatingHours != null) completedTasks++;
        if (data2.BusinessData!.images != null) completedTasks++;
      }

      return completedTasks / totalTasks;
    }

    return Scaffold(
      body: data.isLoading
          ? Center(child: CircularProgressIndicator(color: tgPrimaryColor))
          : CustomScrollView(
        slivers: [
          _buildSliverAppBar(name),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildQuickActionButtons(),
                  SizedBox(height: 24),
                  _buildBusinessOverview(name, commentData),
                  SizedBox(height: 24),
                  _buildInsightsCard(),
                  SizedBox(height: 24),
                  _buildQuickPostCard(),
                  SizedBox(height: 24),
                  _buildProfileCompletionCard(getProgress()),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildSliverAppBar(String name) {
    return SliverAppBar(
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Text('${getGreeting()}, $name'),
        background: Image.network(
            'https://i0.wp.com/stanzaliving.wpcomstaging.com/wp-content/uploads/2022/04/a566a-restaurants-in-hyderabad.jpg?fit=1000%2C750&ssl=1',
          fit: BoxFit.cover,
        )
        // Image.asset(
        //   "assets/restaurant_background.jpg",
        //   fit: BoxFit.cover,
        // ),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.notifications_outlined),
          onPressed: () {
            // Handle notifications
          },
        ),
        IconButton(
          icon: Icon(Icons.chat_bubble_outline),
          onPressed: () async {
            String? userId = await getUserId();
            navigatorPush(context, ChatListScreen(BusinessID: userId!));
          },
        ),
      ],
    );
  }

  Widget _buildQuickActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildActionButton(Icons.edit, 'Edit Profile', () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => BottomNav(initialIndex: 3)),
          );
        }),
        _buildActionButton(Icons.insights, 'View Insights', () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => BottomNav(initialIndex: 1)),
          );
        }),
        _buildActionButton(Icons.message, 'Messages', () async {
          String? userId = await getUserId();
          navigatorPush(context, ChatListScreen(BusinessID: userId!));
        }),
      ],
    );
  }

  Widget _buildActionButton(IconData icon, String label, VoidCallback onPressed) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: onPressed,
          child: Icon(icon, color: Colors.white),
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            padding: EdgeInsets.all(20),
            backgroundColor: tgPrimaryColor,
          ),
        ),
        SizedBox(height: 8),
        Text(label, style: TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget _buildBusinessOverview(String name, CommentSectionProvider commentData) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                StarRating(
                  rating: int.parse(commentData.averageRating.toStringAsFixed(0)),
                  filledStarColor: tgDarkPrimaryColor,
                  unfilledStarColor: Colors.grey,
                ),
                SizedBox(width: 8),
                Text(
                  '${commentData.getCommentsData?.reviews.length ?? 0} reviews',
                  style: TextStyle(color: Colors.teal),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'Your business is performing well! Keep up the good work.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInsightsCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Insights',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Container(
              height: 200,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(show: false),
                  borderData: FlBorderData(show: false),
                  minX: 0,
                  maxX: 6,
                  minY: 0,
                  maxY: 6,
                  lineBarsData: [
                    LineChartBarData(
                      spots: [
                        FlSpot(0, 3),
                        FlSpot(1, 1),
                        FlSpot(2, 4),
                        FlSpot(3, 2),
                        FlSpot(4, 5),
                        FlSpot(5, 1),
                      ],
                      isCurved: true,
                      color: tgPrimaryColor,
                      barWidth: 4,
                      isStrokeCapRound: true,
                      dotData: FlDotData(show: false),
                      belowBarData: BarAreaData(show: false),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Page visits are up by 15% this week!',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickPostCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Quick Post',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                hintText: 'What\'s new with your business?',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: tgPrimaryColor),
                ),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 16),
            ElevatedButton.icon(
              icon: Icon(Icons.send),
              label: Text('POST'),
              onPressed: () {
                showSnackBar(context, "Feature not available yet, stay tuned");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: tgPrimaryColor,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileCompletionCard(double progress) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Profile Completion',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(tgPrimaryColor),
              minHeight: 10,
            ),
            SizedBox(height: 8),
            Text(
              '${(progress * 100).toInt()}% complete',
              style: TextStyle(color: tgPrimaryColor, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 16),
            ElevatedButton.icon(
              icon: Icon(Icons.edit),
              label: Text('Complete Profile'),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => BottomNav(initialIndex: 3)),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: tgPrimaryColor,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
        });
        // Handle navigation
      },
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.insights), label: 'Insights'),
        BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Messages'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
      type: BottomNavigationBarType.fixed,
      selectedItemColor: tgPrimaryColor,
      unselectedItemColor: Colors.grey,
    );
  }
}