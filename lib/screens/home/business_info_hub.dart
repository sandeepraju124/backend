import 'package:backendapp/widgets/Businessinfo.dart' as businessInfo;
import 'package:flutter/material.dart';

import 'package:backendapp/widgets/Businessinfo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
// Keep existing imports
import 'package:backendapp/provider/businessdata_provider.dart';
import 'package:backendapp/provider/businessmongo_provider.dart';
import 'package:backendapp/provider/commentprovider.dart';
import 'package:backendapp/screens/add_photos.dart';
import 'package:backendapp/screens/amenites/diaplay_amenities.dart';
import 'package:backendapp/screens/home/bottomnav.dart';
import 'package:backendapp/utils/constants.dart';
import 'package:backendapp/utils/navigators.dart';
import 'package:backendapp/screens/amenites/AmenitiesandMore.dart';
import 'package:backendapp/widgets/operating_hours_test.dart';
import 'package:backendapp/widgets/rating.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BusinessInfoHub extends StatefulWidget {
  @override
  State<BusinessInfoHub> createState() => _BusinessInfoHubState();
}

class _BusinessInfoHubState extends State<BusinessInfoHub> {
  final String noAmenities =
      "No amenities added, add them to engage with customers";
  final String _operatingHoursMsg =
      "Choose the amenities that you provide your customers, and we'll showcase this to your potential customers on your NearMe business page and when you come up on search results";
  int _currentImageIndex = 0;
  @override
  Widget build(BuildContext context) {
    var data = Provider.of<ServicesProvider>(context);
    var businessdata = Provider.of<BusinessDataProvider>(context);
    // String _ratingString = '3';
    // String _ratingString = "${double.parse(businessdata.BusinessData![0].avgRating).toStringAsFixed(0)}";
    // int _rating = int.parse(_ratingString);
    String _ratingString = "0";
    int _rating = 0;

    if (businessdata.BusinessData != null &&
        businessdata.BusinessData!.isNotEmpty) {
      _ratingString = double.parse(businessdata.BusinessData![0].avgRating)
          .toStringAsFixed(0);
      _rating = int.parse(_ratingString);
    }

    var amenities = data.BusinessData?.amenities;
    var operatingHours = data.BusinessData?.operatingHours;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: businessdata.isLoading
          ? Center(child: CircularProgressIndicator(color: tgPrimaryColor))
          : CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 250.0,
                  floating: false,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text("Business Info Hub",
                        style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                            fontSize: 17.5)),
                    background: SlidingCoverImages(),
                  ),
                  backgroundColor: tgDarkPrimaryColor,
                  actions: [
                    IconButton(
                      onPressed: () =>
                          // showSnackBar(context, "Business Info Hub"),

                          ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Business Info Hub"),
                          behavior: SnackBarBehavior.floating,
                        ),
                      ),
                      icon: Icon(Icons.add_business_outlined),
                    )
                  ],
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BusinessHeader(
                            businessdata: businessdata, rating: _rating),
                        SizedBox(height: 20),
                        BusinessActionButtons(),
                        SizedBox(height: 20),
                        AmenitiesSection(
                            amenities: amenities, noAmenities: noAmenities),
                        SizedBox(height: 20),
                        OperatingHoursSection(
                            operatingHours: operatingHours,
                            operatingHoursMsg: _operatingHoursMsg),
                        SizedBox(height: 20),
                        // BusinessInfoSection(businessdata: businessdata),
                        if (businessdata.BusinessData != null)
                          BusinessInfoSection(businessdata: businessdata),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget SlidingCoverImages() {
    var data = Provider.of<ServicesProvider>(context);
    var images = data.BusinessData?.images;

    if (images == null || images.isEmpty) {
      return Image.network(
        "https://upload.wikimedia.org/wikipedia/commons/b/b9/No_Cover.jpg",
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      );
    }

    return Stack(
      fit: StackFit.expand,
      children: [
        CarouselSlider.builder(
          itemCount: images.length,
          itemBuilder: (BuildContext context, int index, int realIndex) {
            return Image.network(
              images[index],
              fit: BoxFit.cover,
              width: double.infinity,
            );
          },
          options: CarouselOptions(
            height: double.infinity,
            viewportFraction: 1.0,
            enlargeCenterPage: false,
            autoPlay: true,
            onPageChanged: (index, reason) {
              setState(() {
                _currentImageIndex = index;
              });
            },
          ),
        ),
        Positioned(
          bottom: 50,
          left: 0,
          right: 0,
          child: Center(
            child: AnimatedSmoothIndicator(
              activeIndex: _currentImageIndex,
              count: images.length,
              effect: WormEffect(
                  dotWidth: 8,
                  dotHeight: 8,
                  activeDotColor: tgAccentColor,
                  dotColor: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}

// class BusinessHeader extends StatelessWidget {
//   final BusinessDataProvider businessdata;
//   final int rating;

//   const BusinessHeader(
//       {Key? key, required this.businessdata, required this.rating})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           (businessdata.BusinessData != null &&
//                   businessdata.BusinessData!.isNotEmpty)
//               ? businessdata.BusinessData![0].businessName
//               : 'Default Business Name',
//           style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//         ),
//         SizedBox(height: 8),
//         StarRating(
//           rating: rating,
//           filledStarColor: tgDarkPrimaryColor,
//           unfilledStarColor: Colors.grey[300]!,
//         ),
//       ],
//     );
//   }
// }

class BusinessHeader extends StatelessWidget {
  final BusinessDataProvider businessdata;
  final int rating;

  const BusinessHeader(
      {Key? key, required this.businessdata, required this.rating})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? profileImageUrl = businessdata.BusinessData?.first.profileImageUrl;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 85,
          height: 85,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: tgDarkPrimaryColor, width: 3),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: CircleAvatar(
            radius: 37,
            backgroundImage:
                profileImageUrl != null && profileImageUrl.isNotEmpty
                    ? NetworkImage(profileImageUrl)
                    : AssetImage('assets/default_profile.png') as ImageProvider,
            backgroundColor: Colors.grey[200],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                (businessdata.BusinessData != null &&
                        businessdata.BusinessData!.isNotEmpty)
                    ? businessdata.BusinessData![0].businessName
                    : 'Default Business Name',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
              Center(
                child: Row(
                  children: [
                    // StarRating(
                    //   rating: rating,
                    //   filledStarColor: tgDarkPrimaryColor,
                    //   unfilledStarColor: Colors.grey[300]!,
                    // ),

                    customStars(rating),
                    SizedBox(width: 8),
                    Text(
                      '($rating)',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// class BusinessHeader extends StatelessWidget {
//   final BusinessDataProvider businessdata;
//   final int rating;

//   const BusinessHeader({
//     Key? key,
//     required this.businessdata,
//     required this.rating,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     String? profileImageUrl = businessdata.BusinessData?.first.profileImageUrl;
//     String businessName = (businessdata.BusinessData != null &&
//             businessdata.BusinessData!.isNotEmpty)
//         ? businessdata.BusinessData![0].businessName
//         : 'Default Business Name';

//     return Center(
//       child: Container(
//         padding: EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(16),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.1),
//               spreadRadius: 1,
//               blurRadius: 10,
//               offset: Offset(0, 3),
//             ),
//           ],
//         ),
//         child: Center(
//           child: Column(
//             children: [
//               Container(
//                 width: 100,
//                 height: 100,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   border: Border.all(color: tgDarkPrimaryColor, width: 3),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.withOpacity(0.3),
//                       spreadRadius: 2,
//                       blurRadius: 5,
//                       offset: Offset(0, 3),
//                     ),
//                   ],
//                 ),
//                 child: CircleAvatar(
//                   backgroundImage:
//                       profileImageUrl != null && profileImageUrl.isNotEmpty
//                           ? NetworkImage(profileImageUrl)
//                           : AssetImage('assets/default_profile.png')
//                               as ImageProvider,
//                   backgroundColor: Colors.grey[200],
//                 ),
//               ),
//               SizedBox(height: 16),
//               Text(
//                 businessName,
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   color: tgDarkPrimaryColor,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               SizedBox(height: 8),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   StarRating(
//                     rating: rating,
//                     filledStarColor: tgDarkPrimaryColor,
//                     unfilledStarColor: Colors.grey[300]!,
//                   ),
//                   SizedBox(width: 8),
//                   Text(
//                     '($rating)',
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.grey[600],
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class BusinessActionButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ActionButton(
          icon: Icons.rate_review,
          label: 'See reviews',
          onTap: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => BottomNav(initialIndex: 3))),
        ),
        ActionButton(
          icon: Icons.add_a_photo,
          label: 'Add photos',
          onTap: () => navigatorPush(context, AddPhotos()),
        ),
        ActionButton(
          icon: Icons.visibility,
          label: 'View',
          onTap: () {},
        ),
      ],
    );
  }
}

class ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const ActionButton(
      {Key? key, required this.icon, required this.label, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon, color: tgDarkPrimaryColor),
          SizedBox(height: 4),
          Text(label, style: TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}

class AmenitiesSection extends StatelessWidget {
  final List<dynamic>? amenities;
  final String noAmenities;

  const AmenitiesSection(
      {Key? key, required this.amenities, required this.noAmenities})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Amenities and more",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                GestureDetector(
                  onTap: () => navigatorPush(context, AmenityScreen()),
                  child: Text("view all", style: TextStyle(color: Colors.teal)),
                )
              ],
            ),
            SizedBox(height: 12),
            amenities == null || amenities!.isEmpty
                ? Text(noAmenities)
                : Column(
                    children: amenities!
                        .take(3)
                        .map((amenity) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 4.0),
                              child: Row(
                                children: [
                                  Icon(Icons.check_circle,
                                      color: Colors.green, size: 16),
                                  SizedBox(width: 8),
                                  Text(amenity),
                                ],
                              ),
                            ))
                        .toList(),
                  ),
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) => DraggableScrollableSheet(
                    expand: false,
                    initialChildSize: 0.9,
                    minChildSize: 0.5,
                    maxChildSize: 1.0,
                    builder: (context, scrollController) =>
                        AmenitiesandMoreSheet(),
                  ),
                );
              },
              child: Text(
                'View and Edit All Attributes',
                style: TextStyle(color: Colors.black87),
              ),
              style:
                  ElevatedButton.styleFrom(backgroundColor: tgDarkPrimaryColor),
            ),
          ],
        ),
      ),
    );
  }
}

class OperatingHoursSection extends StatelessWidget {
  final dynamic operatingHours;
  final String operatingHoursMsg;

  const OperatingHoursSection(
      {Key? key, required this.operatingHours, required this.operatingHoursMsg})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Operating hours",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87)),
                IconButton(
                  icon: Icon(Icons.info_outline),
                  onPressed: () => showSnackBar(context, operatingHoursMsg),
                )
              ],
            ),
            SizedBox(height: 12),
            operatingHours == null
                ? Text("No operating hours available")
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                        operatingHours.toJson().entries.map<Widget>((entry) {
                      var day = entry.key;
                      var hours = entry.value;
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(day,
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(hours['open'] ?? 'N/A'),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) => DraggableScrollableSheet(
                    expand: false,
                    initialChildSize: 0.9,
                    minChildSize: 0.5,
                    maxChildSize: 1.0,
                    builder: (context, scrollController) =>
                        OperatingHoursScreen(),
                  ),
                );
              },
              child: Text(
                'View and Edit All Attributes',
                style: TextStyle(color: Colors.black87),
              ),
              style:
                  ElevatedButton.styleFrom(backgroundColor: tgDarkPrimaryColor),
            ),
          ],
        ),
      ),
    );
  }
}

class BusinessInfoSection extends StatelessWidget {
  final BusinessDataProvider businessdata;

  const BusinessInfoSection({Key? key, required this.businessdata})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Business info",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            SizedBox(height: 12),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BasicInfoForm()),
                );
              },
              child: InfoItem(
                title: "Address",
                content: (businessdata.BusinessData != null &&
                        businessdata.BusinessData!.isNotEmpty &&
                        businessdata.BusinessData![0].address != null)
                    ? businessdata.BusinessData![0].address!.isNotEmpty
                        ? businessdata.BusinessData![0].address!
                        : "Please add address"
                    : "Please add address",
                icon: Icons.location_on,
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BasicInfoForm()),
                );
              },
              child: InfoItem(
                title: "Call",
                content: (businessdata.BusinessData != null &&
                        businessdata.BusinessData!.isNotEmpty)
                    ? businessdata
                            .BusinessData![0].contactInformation.isNotEmpty
                        ? businessdata.BusinessData![0].contactInformation
                        : "Please add contact information"
                    : "Please add contact information",
                icon: Icons.phone,
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BasicInfoForm()),
                );
              },
              child: InfoItem(
                title: "Email",
                content: (businessdata.BusinessData![0].businessEmail != null &&
                        businessdata.BusinessData![0].businessEmail.isNotEmpty)
                    ? businessdata.BusinessData![0].businessEmail
                    : "Please add email address",
                icon: Icons.email,
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BasicInfoForm()),
                );
              },
              child: InfoItem(
                title: "Website",
                content: "Add a link to your business website",
                icon: Icons.language,
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BasicInfoForm()),
                );
              },
              child: InfoItem(
                title: "Menu",
                content: "Let your customers see what's on the menu",
                icon: Icons.menu_book,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoItem extends StatelessWidget {
  final String title;
  final String content;
  final IconData icon;

  const InfoItem(
      {Key? key,
      required this.title,
      required this.content,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: tgDarkPrimaryColor),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text(content, style: TextStyle(color: Colors.grey[600])),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios, size: 16),
        ],
      ),
    );
  }
}
