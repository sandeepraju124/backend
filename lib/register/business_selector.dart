// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import

import 'package:backendapp/register/onboardingService.dart';
import 'package:backendapp/register/onboardingtest.dart';
import 'package:backendapp/register/select_location.dart';
import 'package:backendapp/register/selectallbusinesstest.dart';
import 'package:backendapp/screens/graphs/review_insight.dart';
import 'package:backendapp/screens/graphs/profile_visit.dart';
import 'package:backendapp/utils/constants.dart';
import 'package:backendapp/utils/navigators.dart';
import 'package:backendapp/widgets/linechart.dart';
import 'package:flutter/material.dart';

class BusinessSelector extends StatefulWidget {
  // const BusinessSelector({super.key});

  @override
  State<BusinessSelector> createState() => _BusinessSelectorState();
}

class _BusinessSelectorState extends State<BusinessSelector> {
  final List<String> imagePaths = [
    'assets/business_selector/autoservice.jpg',
    'assets/business_selector/cleaning.jpg',
    'assets/business_selector/gym.jpg',
    'assets/business_selector/hospital.jpg',
    'assets/business_selector/plumbing.jpg',
    'assets/business_selector/restaurent.jpg',
  ];

  // final List<String> businessNames = [
  //   'Car Repair',
  //   'Home Cleaning',
  //   'Gym',
  //   'Hospital',
  //   'Plumbing',
  //   'Restaurant',
  // ];

  final List<Map<String, dynamic>> businessNames = [
    {"Auto Mobile":"Car Repair"},
    {"Home Service":"Home Cleaning"},
    {"Lifestyle":"Gym"},
    {"Health":"Hospital"},
    {"Home Service":"Plumbing"},
    {"Food":"Restaurant"},
  ];


  // Define a mapping between image paths and screen route
  //  final Map<String, Widget> screenRoutes = {
  //   'assets/linechart.png': ReviewInsightChart(),
  //   'assets/17906.jpg': MonthlyViewsChart(),
  //   // 'assets/pie.jpg': OtherScreen2(),
  // };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.green.shade50,
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 1,
          title: Text("Pick your business"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  // childAspectRatio: 0.75, // Adjust aspect ratio as needed
                  childAspectRatio: 3 / 4, // Adjust aspect ratio as needed
                ),
                itemCount: imagePaths.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      print("tapped");
                      print(businessNames[index]);
                //       Navigator.of(context).pushReplacement(
                // MaterialPageRoute(builder: (context) => OnboardingService(
                //   category:businessNames[index] 
                // //  category: "Beauty & Spas > Barbers"
                //   ,)));
                   navigatorPush(context, CustomOnboardingService(category: businessNames[index].keys.first.toString(),Subcategory: businessNames[index].values.first.toString(),));
                    },
                    child: GridTile(
                      child: Stack(
                        children: [
                          Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            // color: Colors.white,
                            color: tgLightPrimaryColor,
                            boxShadow: [
                              // BoxShadow(
                              //   color: Colors.grey.withOpacity(0.5),
                              //   spreadRadius: 1,
                              //   blurRadius: 4,
                              //   offset: const Offset(0, 2),
                              // ),
                            ],
                          ),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Container(
                                // width: 50,
                                // height: 50,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: AssetImage(imagePaths[index]),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                              // Image.asset(
                              //   imagePaths[index],
                              //   fit: BoxFit.cover,
                              // ),
                              ),
                        ),
                        Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: 
                              Container(
                                color: Colors.black.withOpacity(0.5),
                                padding: EdgeInsets.symmetric(vertical: 5),
                                child: Text(
                                  businessNames[index].values.first.toString(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                        ], 
                      ),
                    ),
                  );
                },
              ),
              GestureDetector(
                onTap: (){
                  // showSnackBar(context, "Feature is in progress soon it will be available");
                  navigatorPush(context, AllSubcategoriesPage());
                },
                child: ClipPath(
                  clipper: PointedCornerClipper(),
                  child: Container(
                    width: 200,
                    height: 30,
                    color: Colors.grey,
                    child: Center(child: Text("View All",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold, color: Colors.white),)),
                  ),
                ),
              ),
              SizedBox(height: 39,)
            ],
          ),
        ));
  }
}

class PointedCornerClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, 0); // Start at top-left corner
    path.lineTo(size.width - 20, 0); // Draw to near the top-right corner
    path.lineTo(size.width, 20); // Draw to the top-right pointed corner
    path.lineTo(size.width, size.height); // Draw to bottom-right corner
    path.lineTo(20, size.height); // Draw to near the bottom-left corner
    path.lineTo(0, size.height - 20); // Draw to the bottom-left pointed corner
    path.close(); // Close the path
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}



// bkp
// // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import

// import 'package:backendapp/register/select_location.dart';
// import 'package:backendapp/screens/graphs/review_insight.dart';
// import 'package:backendapp/screens/graphs/profile_visit.dart';
// import 'package:backendapp/utils/constants.dart';
// import 'package:backendapp/utils/navigators.dart';
// import 'package:backendapp/widgets/linechart.dart';
// import 'package:flutter/material.dart';

// class BusinessSelector extends StatefulWidget {
//   // const BusinessSelector({super.key});

//   @override
//   State<BusinessSelector> createState() => _BusinessSelectorState();
// }

// class _BusinessSelectorState extends State<BusinessSelector> {
//   final List<String> imagePaths = [
//     'assets/business_selector/autoservice.jpg',
//     'assets/business_selector/cleaning.jpg',
//     'assets/business_selector/gym.jpg',
//     'assets/business_selector/hospital.jpg',
//     'assets/business_selector/plumbing.jpg',
//     'assets/business_selector/plumbing.jpg',
//     // 'assets/business_selector/saloon.jpg',
//     'assets/business_selector/gym.jpg',
//     'assets/business_selector/hospital.jpg',
//   ];

//   // Define a mapping between image paths and screen route
//   //  final Map<String, Widget> screenRoutes = {
//   //   'assets/linechart.png': ReviewInsightChart(),
//   //   'assets/17906.jpg': MonthlyViewsChart(),
//   //   // 'assets/pie.jpg': OtherScreen2(),
//   // };

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.green.shade50,
//         // backgroundColor: Colors.grey[200],
//         appBar: AppBar(
//           elevation: 1,
//           title: Text("Pick your business"),
//         ),
//         body: SingleChildScrollView(
//           child: Column(
//             children: [
//               GridView.builder(
//                 physics: const NeverScrollableScrollPhysics(),
//                 padding: const EdgeInsets.all(16),
//                 shrinkWrap: true,
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   crossAxisSpacing: 16,
//                   mainAxisSpacing: 16,
//                   // childAspectRatio: 0.75, // Adjust aspect ratio as needed
//                   childAspectRatio: 3 / 4, // Adjust aspect ratio as needed
//                 ),
//                 itemCount: imagePaths.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   return GestureDetector(
//                     onTap: () {
//                       print("tapped");
//                     },
//                     child: GridTile(
//                       child: Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(12),
//                           // color: Colors.white,
//                           color: tgLightPrimaryColor,
//                           boxShadow: [
//                             // BoxShadow(
//                             //   color: Colors.grey.withOpacity(0.5),
//                             //   spreadRadius: 1,
//                             //   blurRadius: 4,
//                             //   offset: const Offset(0, 2),
//                             // ),
//                           ],
//                         ),
//                         child: ClipRRect(
//                             borderRadius: BorderRadius.circular(12),
//                             child: Container(
//                               width: 50,
//                               height: 50,
//                               decoration: BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 image: DecorationImage(
//                                   image: AssetImage(imagePaths[index]),
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                             )
//                             // Image.asset(
//                             //   imagePaths[index],
//                             //   fit: BoxFit.cover,
//                             // ),
//                             ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//               ClipPath(
//                 clipper: PointedCornerClipper(),
//                 child: Container(
//                   width: 200,
//                   height: 30,
//                   color: Colors.grey,
//                   child: Center(child: Text("Plumber",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold, color: Colors.black87),)),
//                 ),
//               ),
//               SizedBox(height: 39,)
//             ],
//           ),
//         ));
//   }
// }

// class PointedCornerClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     final path = Path();
//     path.moveTo(0, 0); // Start at top-left corner
//     path.lineTo(size.width - 20, 0); // Draw to near the top-right corner
//     path.lineTo(size.width, 20); // Draw to the top-right pointed corner
//     path.lineTo(size.width, size.height); // Draw to bottom-right corner
//     path.lineTo(20, size.height); // Draw to near the bottom-left corner
//     path.lineTo(0, size.height - 20); // Draw to the bottom-left pointed corner
//     path.close(); // Close the path
//     return path;
//   }

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) {
//     return false;
//   }
// }
