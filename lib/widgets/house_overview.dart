import 'package:flutter/material.dart';

class OverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Overview',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10.0),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true, // GridView will take only the space it needs
          childAspectRatio: 3,
          physics: NeverScrollableScrollPhysics(), // Disable GridView scrolling
          children: [
            OverviewItem(icon: Icons.bed, text1: '2', text2: 'Bedroom'),
            OverviewItem(icon: Icons.calendar_today, text1: '07/07/2024', text2: 'Posted On'),
            OverviewItem(icon: Icons.bathtub, text1: '2', text2: 'Bathrooms'),
            OverviewItem(icon: Icons.access_time, text1: 'Immediately', text2: 'Possession'),
            OverviewItem(icon: Icons.restaurant, text1: 'Yes', text2: 'Nonveg Allowed'),
            OverviewItem(icon: Icons.lock, text1: 'No', text2: 'Gated Security'),
            OverviewItem(icon: Icons.directions_bike, text1: 'Car', text2: 'Parking'),
            OverviewItem(icon: Icons.home, text1: 'Independent', text2: 'House/Villa'),
          ],
        ),
      ],
    );
  }
}

class OverviewItem extends StatelessWidget {
  final IconData icon;
  final String text1;
  final String text2;

  OverviewItem({required this.icon, required this.text1, required this.text2});

  @override
  Widget build(BuildContext context) {
    return Container(
      
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Icon(icon, size: 30.0),
          SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text1,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  text2,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
// import 'package:flutter/material.dart';

// class OverviewScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Overview'),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Overview',
//               style: TextStyle(
//                 fontSize: 18.0,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 10.0),
//             GridView.count(
//               crossAxisCount: 2,
//               shrinkWrap: true, // GridView will take only the space it needs
//               childAspectRatio: 3,
//               physics: NeverScrollableScrollPhysics(), // Disable GridView scrolling
//               children: [
//                 OverviewItem(icon: Icons.bed, text1: '2', text2: 'Bedroom'),
//                 OverviewItem(icon: Icons.calendar_today, text1: '07/07/2024', text2: 'Posted On'),
//                 OverviewItem(icon: Icons.bathtub, text1: '2', text2: 'Bathrooms'),
//                 OverviewItem(icon: Icons.access_time, text1: 'Immediately', text2: 'Possession'),
//                 OverviewItem(icon: Icons.restaurant, text1: 'Yes', text2: 'Nonveg Allowed'),
//                 OverviewItem(icon: Icons.lock, text1: 'No', text2: 'Gated Security'),
//                 OverviewItem(icon: Icons.directions_bike, text1: 'Car', text2: 'Parking'),
//                 OverviewItem(icon: Icons.home, text1: 'Independent', text2: 'House/Villa'),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class OverviewItem extends StatelessWidget {
//   final IconData icon;
//   final String text1;
//   final String text2;

//   OverviewItem({required this.icon, required this.text1, required this.text2});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(8.0),
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.grey.shade300),
//       ),
//       child: Row(
//         children: [
//           Icon(icon, size: 30.0),
//           SizedBox(width: 10.0),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   text1,
//                   style: TextStyle(
//                     fontSize: 16.0,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Text(
//                   text2,
//                   style: TextStyle(
//                     fontSize: 14.0,
//                     color: Colors.grey,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
