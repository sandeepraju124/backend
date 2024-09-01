// import 'package:backendapp/provider/businessdata_provider.dart';
// import 'package:backendapp/provider/businessmongo_provider.dart';
// import 'package:backendapp/screens/amenites/AmenitiesandMore.dart';
// import 'package:backendapp/utils/navigators.dart';
// import 'package:backendapp/widgets/Businessinfo.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// // class TasksScreen extends StatelessWidget {
// //   final List<Task> tasks = [
// //     Task(title: 'Amenities', isCompleted: false),
// //     Task(title: 'Profile Picture Update', isCompleted: true),
// //     Task(title: 'Update Operating Hours', isCompleted: false),
// //     Task(title: 'Update Phone Number', isCompleted: true),
// //     Task(title: 'Update Business Information', isCompleted: false),
// //   ];

// //   @override
// //   Widget build(BuildContext context) {
// //     // var data = Provider.of<BusinessDataProvider>(context);
// //     // var data2 = Provider.of<ServicesProvider>(context);
// //     // List<Task> tasks = [];

// //     // List<Task> generateTasks() {
// //     //   if (data.BusinessData != null) {
// //     //     if (data.BusinessData!.isNotEmpty) {
// //     //       tasks.add(Task(
// //     //         title: 'Update Phone Number',
// //     //         isCompleted:
// //     //             data.BusinessData![0].contactInformation?.isNotEmpty ?? false,
// //     //       ));
// //     //       tasks.add(Task(
// //     //         title: 'Update Business Email',
// //     //         isCompleted:
// //     //             data.BusinessData![0].businessEmail?.isNotEmpty ?? false,
// //     //       ));
// //     //       tasks.add(Task(
// //     //         title: 'Update Address',
// //     //         isCompleted: data.BusinessData![0].address?.isNotEmpty ?? false,
// //     //       ));
// //     //       tasks.add(Task(
// //     //         title: 'Update Business Description',
// //     //         isCompleted:
// //     //             data.BusinessData![0].businessDescription?.isNotEmpty ?? false,
// //     //       ));
// //     //       tasks.add(Task(
// //     //         title: 'Amenities',
// //     //         isCompleted: data2.BusinessData!.amenities != null,
// //     //       ));
// //     //     }
// //     //   }

// //     //   return tasks;
// //     // }

// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Tasks'),
// //         centerTitle: true,
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: ListView.builder(
// //           itemCount: tasks.length,
// //           itemBuilder: (context, index) {
// //             final task = tasks[index];
// //             return Card(
// //               shape: RoundedRectangleBorder(
// //                 borderRadius: BorderRadius.circular(10.0),
// //               ),
// //               elevation: 4.0,
// //               margin: EdgeInsets.symmetric(vertical: 10.0),
// //               child: ListTile(
// //                 leading: Icon(
// //                   task.isCompleted ? Icons.check_circle : Icons.pending,
// //                   color: task.isCompleted ? Colors.green : Colors.orange,
// //                   size: 30.0,
// //                 ),
// //                 title: Text(
// //                   task.title,
// //                   style: TextStyle(
// //                     fontSize: 18.0,
// //                     fontWeight: FontWeight.bold,
// //                     color: task.isCompleted ? Colors.grey : Colors.black,
// //                     decoration: task.isCompleted
// //                         ? TextDecoration.lineThrough
// //                         : TextDecoration.none,
// //                   ),
// //                 ),
// //                 trailing: Icon(
// //                   Icons.arrow_forward_ios,
// //                   color: Colors.grey,
// //                   size: 20.0,
// //                 ),
// //                 onTap: () {
// //                   // Handle task tap
// //                   print('Task ${task.title} tapped');
// //                 },
// //               ),
// //             );
// //           },
// //         ),
// //       ),
// //     );
// //   }
// // }

// // class Task {
// //   final String title;
// //   final bool isCompleted;

// //   Task({required this.title, required this.isCompleted});
// // }

// // class TasksScreen extends StatefulWidget {
// //   @override
// //   State<TasksScreen> createState() => _TasksScreenState();
// // }

// // class _TasksScreenState extends State<TasksScreen> {
// //   List<Task> tasks = [];

// //   @override
// //   Widget build(BuildContext context) {
// //     var data = Provider.of<BusinessDataProvider>(context);
// //     var data2 = Provider.of<ServicesProvider>(context);
// //     // print(data2.BusinessData!.amenities);
// //     // print("data2.BusinessData!.amenities");
// //     // print(data2.BusinessData!.amenities?.isNotEmpty);

// //     void generateTasks() {
// //       tasks.clear(); // Clear the tasks list before adding new tasks
// //       // if (data.BusinessData != null && data.BusinessData!.isNotEmpty) {
// //         tasks.add(Task(
// //           title: 'Update Phone Number',
// //           isCompleted: data.BusinessData![0].contactInformation?.isNotEmpty ?? false,
// //         ));
// //         tasks.add(Task(
// //           title: 'Update Business Email',
// //           isCompleted: data.BusinessData![0].businessEmail?.isNotEmpty ?? false,
// //         ));
// //         tasks.add(Task(
// //           title: 'Update Address',
// //           isCompleted: data.BusinessData![0].address?.isNotEmpty ?? false,
// //         ));
// //         tasks.add(Task(
// //           title: 'Update Business Description',
// //           isCompleted: data.BusinessData![0].businessDescription?.isNotEmpty ?? false,
// //         ));

// //         tasks.add(Task(
// //           title: 'Amenities',
// //           isCompleted: data2.BusinessData!.amenities?.isNotEmpty ?? false,
// //         ));
// //       }
// //       // if (data2.BusinessData != null && data2.BusinessData!.amenities != null) {
// //         // tasks.add(Task(
// //         //   title: 'Amenities',
// //         //   isCompleted: data2.BusinessData!.amenities?.isNotEmpty ?? false,
// //         // ));
// //       // }
// //     // }

// //     generateTasks(); // Generate tasks once to initialize the list

// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Tasks'),
// //         centerTitle: true,
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: ListView.builder(
// //           itemCount: tasks.length,
// //           itemBuilder: (context, index) {
// //             final task = tasks[index];
// //             return Card(
// //               shape: RoundedRectangleBorder(
// //                 borderRadius: BorderRadius.circular(10.0),
// //               ),
// //               elevation: 4.0,
// //               margin: EdgeInsets.symmetric(vertical: 10.0),
// //               child: ListTile(
// //                 leading: Icon(
// //                   task.isCompleted ? Icons.check_circle : Icons.pending,
// //                   color: task.isCompleted ? Colors.green : Colors.orange,
// //                   size: 30.0,
// //                 ),
// //                 title: Text(
// //                   task.title,
// //                   style: TextStyle(
// //                     fontSize: 18.0,
// //                     fontWeight: FontWeight.bold,
// //                     color: task.isCompleted ? Colors.grey : Colors.black,
// //                     decoration: task.isCompleted
// //                         ? TextDecoration.lineThrough
// //                         : TextDecoration.none,
// //                   ),
// //                 ),
// //                 trailing: Icon(
// //                   Icons.arrow_forward_ios,
// //                   color: Colors.grey,
// //                   size: 20.0,
// //                 ),
// //                 onTap: () {
// //                   // Handle task tap
// //                   print('Task ${task.title} tapped');
// //                   navigateToTaskPage(context, task.title);
// //                 },
// //               ),
// //             );
// //           },
// //         ),
// //       ),
// //     );
// //   }

// //    void navigateToTaskPage(BuildContext context, String taskTitle) {
// //     switch (taskTitle) {
// //       case 'Update Phone Number':
// //         navigatorPush(context, BasicInfoForm());
// //         break;
// //       case 'Update Business Email':
// //         Navigator.push(
// //           context,
// //           MaterialPageRoute(builder: (context) => BasicInfoForm()),
// //         );
// //         break;
// //       case 'Update Address':
// //         Navigator.pushReplacement(
// //           context,
// //           MaterialPageRoute(builder: (context) => BasicInfoForm()),
// //         );
// //         break;
// //       case 'Update Business Description':
// //         Navigator.push(
// //           context,
// //           MaterialPageRoute(builder: (context) => BasicInfoForm()),
// //         );
// //         break;
// //       case 'Amenities':
// //         Navigator.push(
// //           context,
// //           MaterialPageRoute(builder: (context) => AmenitiesandMoreSheet()),
// //         );
// //         break;
// //       default:
// //         print('Unknown task: $taskTitle');
// //         break;
// //     }
// //   }
// // }

// // class Task {
// //   final String title;
// //   final bool isCompleted;

// //   Task({required this.title, required this.isCompleted});
// // }

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:backendapp/provider/businessdata_provider.dart';
// // import 'package:backendapp/provider/services_provider.dart';
// // import 'package:backendapp/screens/basic_info_form.dart';
// // import 'package:backendapp/screens/amenities_and_more_sheet.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// class TasksScreen extends StatefulWidget {
//   @override
//   State<TasksScreen> createState() => _TasksScreenState();
// }

// class _TasksScreenState extends State<TasksScreen> {
//   List<Task> tasks = [];

//   @override
//   Widget build(BuildContext context) {
//     var data = Provider.of<BusinessDataProvider>(context);
//     var data2 = Provider.of<ServicesProvider>(context);

//     void generateTasks() {
//       tasks.clear();
//       tasks.add(Task(
//         title: 'Update Phone Number',
//         isCompleted:
//             data.BusinessData![0].contactInformation?.isNotEmpty ?? false,
//         icon: 'assets/icons/phone.svg',
//       ));
//       tasks.add(Task(
//         title: 'Update Business Email',
//         isCompleted: data.BusinessData![0].businessEmail?.isNotEmpty ?? false,
//         icon: 'assets/icons/email.svg',
//       ));
//       tasks.add(Task(
//         title: 'Update Address',
//         isCompleted: data.BusinessData![0].address?.isNotEmpty ?? false,
//         icon: 'assets/icons/location.svg',
//       ));
//       tasks.add(Task(
//         title: 'Update Business Description',
//         isCompleted:
//             data.BusinessData![0].businessDescription?.isNotEmpty ?? false,
//         icon: 'assets/icons/description.svg',
//       ));
//       tasks.add(Task(
//         title: 'Amenities',
//         isCompleted: data2.BusinessData!.amenities?.isNotEmpty ?? false,
//         icon: 'assets/icons/amenities.svg',
//       ));
//     }

//     generateTasks();

//     return Scaffold(
//       body: CustomScrollView(
//         slivers: [
//           SliverAppBar(
//             expandedHeight: 200.0,
//             floating: false,
//             pinned: true,
//             flexibleSpace: FlexibleSpaceBar(
//               title: Text('Business Tasks'),
//               background: Image.asset(
//                 'assets/images/tasks_background.jpg',
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: EdgeInsets.all(16.0),
//               child: Text(
//                 'Complete these tasks to improve your business profile:',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//             ),
//           ),
//           SliverList(
//             delegate: SliverChildBuilderDelegate(
//               (BuildContext context, int index) {
//                 final task = tasks[index];
//                 return Padding(
//                   padding:
//                       EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//                   child: _buildTaskCard(task, context),
//                 );
//               },
//               childCount: tasks.length,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildTaskCard(Task task, BuildContext context) {
//     return GestureDetector(
//       onTap: () => navigateToTaskPage(context, task.title),
//       child: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: task.isCompleted
//                 ? [Colors.green.shade100, Colors.green.shade200]
//                 : [Colors.orange.shade100, Colors.orange.shade200],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//           borderRadius: BorderRadius.circular(15),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.3),
//               spreadRadius: 2,
//               blurRadius: 5,
//               offset: Offset(0, 3),
//             ),
//           ],
//         ),
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(15),
//           child: Stack(
//             children: [
//               Positioned(
//                 right: -20,
//                 bottom: -20,
//                 child: Opacity(
//                   opacity: 0.2,
//                   child: SvgPicture.asset(
//                     task.icon,
//                     width: 100,
//                     height: 100,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.all(16.0),
//                 child: Row(
//                   children: [
//                     SvgPicture.asset(
//                       task.icon,
//                       width: 40,
//                       height: 40,
//                       color: Colors.white,
//                     ),
//                     SizedBox(width: 16),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             task.title,
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white,
//                             ),
//                           ),
//                           SizedBox(height: 4),
//                           Text(
//                             task.isCompleted ? 'Completed' : 'Pending',
//                             style: TextStyle(
//                               fontSize: 14,
//                               color: Colors.white.withOpacity(0.8),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Icon(
//                       task.isCompleted
//                           ? Icons.check_circle
//                           : Icons.arrow_forward_ios,
//                       color: Colors.white,
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void navigateToTaskPage(BuildContext context, String taskTitle) {
//     switch (taskTitle) {
//       case 'Update Phone Number':
//       case 'Update Business Email':
//       case 'Update Address':
//       case 'Update Business Description':
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => BasicInfoForm()),
//         );
//         break;
//       case 'Amenities':
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => AmenitiesandMoreSheet()),
//         );
//         break;
//       default:
//         print('Unknown task: $taskTitle');
//         break;
//     }
//   }
// }

// class Task {
//   final String title;
//   final bool isCompleted;
//   final String icon;

//   Task({required this.title, required this.isCompleted, required this.icon});
// }

import 'package:backendapp/provider/businessmongo_provider.dart';
import 'package:backendapp/screens/amenites/AmenitiesandMore.dart';
import 'package:backendapp/utils/constants.dart';
import 'package:backendapp/widgets/Businessinfo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:backendapp/provider/businessdata_provider.dart';
// import 'package:backendapp/provider/services_provider.dart';
// import 'package:backendapp/screens/basic_info_form.dart';
// import 'package:backendapp/screens/amenities_and_more_sheet.dart';

class TasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var businessData =
        Provider.of<BusinessDataProvider>(context).BusinessData?[0];
    var servicesData = Provider.of<ServicesProvider>(context).BusinessData;

    List<Task> tasks = [
      Task(
        title: 'Update Phone Number',
        isCompleted: businessData?.contactInformation?.isNotEmpty ?? false,
        icon: Icons.phone,
      ),
      Task(
        title: 'Update Business Email',
        isCompleted: businessData?.businessEmail?.isNotEmpty ?? false,
        icon: Icons.email,
      ),
      Task(
        title: 'Update Address',
        isCompleted: businessData?.address?.isNotEmpty ?? false,
        icon: Icons.location_on,
      ),
      Task(
        title: 'Update Business Description',
        isCompleted: businessData?.businessDescription?.isNotEmpty ?? false,
        icon: Icons.description,
      ),
      Task(
        title: 'Amenities',
        isCompleted: servicesData?.amenities?.isNotEmpty ?? false,
        icon: Icons.hotel,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: tgAccentColor,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.keyboard_arrow_left_rounded)),
        title: Text(
          'Business Profile Tasks',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
        ),
        elevation: 0,
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(16),
        itemCount: tasks.length,
        separatorBuilder: (context, index) => SizedBox(height: 16),
        itemBuilder: (context, index) {
          return _buildTaskCard(context, tasks[index]);
        },
      ),
    );
  }

  Widget _buildTaskCard(BuildContext context, Task task) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () => _navigateToTaskPage(context, task.title),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(
                task.icon,
                size: 28,
                color: task.isCompleted ? tgDarkPrimaryColor : Colors.orange,
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      task.isCompleted ? 'Completed' : 'Pending',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                task.isCompleted ? Icons.check_circle : Icons.arrow_forward_ios,
                color: task.isCompleted ? tgDarkPrimaryColor : Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToTaskPage(BuildContext context, String taskTitle) {
    Widget page;
    switch (taskTitle) {
      case 'Update Phone Number':
      case 'Update Business Email':
      case 'Update Address':
      case 'Update Business Description':
        page = BasicInfoForm();
        break;
      case 'Amenities':
        page = AmenitiesandMoreSheet();
        break;
      default:
        print('Unknown task: $taskTitle');
        return;
    }
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }
}

class Task {
  final String title;
  final bool isCompleted;
  final IconData icon;

  Task({required this.title, required this.isCompleted, required this.icon});
}
