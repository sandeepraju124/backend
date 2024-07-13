import 'package:backendapp/provider/businessdata_provider.dart';
import 'package:backendapp/provider/businessmongo_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TasksScreen extends StatelessWidget {
  final List<Task> tasks = [
    Task(title: 'Amenities', isCompleted: false),
    Task(title: 'Profile Picture Update', isCompleted: true),
    Task(title: 'Update Operating Hours', isCompleted: false),
    Task(title: 'Update Phone Number', isCompleted: true),
    Task(title: 'Update Business Information', isCompleted: false),
  ];

  @override
  Widget build(BuildContext context) {
    // var data = Provider.of<BusinessDataProvider>(context);
    // var data2 = Provider.of<ServicesProvider>(context);
    // List<Task> tasks = [];

    // List<Task> generateTasks() {
    //   if (data.BusinessData != null) {
    //     if (data.BusinessData!.isNotEmpty) {
    //       tasks.add(Task(
    //         title: 'Update Phone Number',
    //         isCompleted:
    //             data.BusinessData![0].contactInformation?.isNotEmpty ?? false,
    //       ));
    //       tasks.add(Task(
    //         title: 'Update Business Email',
    //         isCompleted:
    //             data.BusinessData![0].businessEmail?.isNotEmpty ?? false,
    //       ));
    //       tasks.add(Task(
    //         title: 'Update Address',
    //         isCompleted: data.BusinessData![0].address?.isNotEmpty ?? false,
    //       ));
    //       tasks.add(Task(
    //         title: 'Update Business Description',
    //         isCompleted:
    //             data.BusinessData![0].businessDescription?.isNotEmpty ?? false,
    //       ));
    //       tasks.add(Task(
    //         title: 'Amenities',
    //         isCompleted: data2.BusinessData!.amenities != null,
    //       ));
    //     }
    //   }

    //   return tasks;
    // }

    return Scaffold(
      appBar: AppBar(
        title: Text('Tasks'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            final task = tasks[index];
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 4.0,
              margin: EdgeInsets.symmetric(vertical: 10.0),
              child: ListTile(
                leading: Icon(
                  task.isCompleted ? Icons.check_circle : Icons.pending,
                  color: task.isCompleted ? Colors.green : Colors.orange,
                  size: 30.0,
                ),
                title: Text(
                  task.title,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: task.isCompleted ? Colors.grey : Colors.black,
                    decoration: task.isCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey,
                  size: 20.0,
                ),
                onTap: () {
                  // Handle task tap
                  print('Task ${task.title} tapped');
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class Task {
  final String title;
  final bool isCompleted;

  Task({required this.title, required this.isCompleted});
}


// import 'package:backendapp/provider/businessdata_provider.dart';
// import 'package:backendapp/provider/businessmongo_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

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
//       tasks.clear(); // Clear the tasks list before adding new tasks
//       if (data.BusinessData != null && data.BusinessData!.isNotEmpty) {
//         tasks.add(Task(
//           title: 'Update Phone Number',
//           isCompleted: data.BusinessData![0].contactInformation?.isNotEmpty ?? false,
//         ));
//         tasks.add(Task(
//           title: 'Update Business Email',
//           isCompleted: data.BusinessData![0].businessEmail?.isNotEmpty ?? false,
//         ));
//         tasks.add(Task(
//           title: 'Update Address',
//           isCompleted: data.BusinessData![0].address?.isNotEmpty ?? false,
//         ));
//         tasks.add(Task(
//           title: 'Update Business Description',
//           isCompleted: data.BusinessData![0].businessDescription?.isNotEmpty ?? false,
//         ));
//       }
//       if (data2.BusinessData != null && data2.BusinessData!.amenities != null) {
//         tasks.add(Task(
//           title: 'Amenities',
//           isCompleted: data2.BusinessData!.amenities != null,
//         ));
//       }
//     }

//     generateTasks(); // Generate tasks once to initialize the list

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Tasks'),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: ListView.builder(
//           itemCount: tasks.length,
//           itemBuilder: (context, index) {
//             final task = tasks[index];
//             return Card(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10.0),
//               ),
//               elevation: 4.0,
//               margin: EdgeInsets.symmetric(vertical: 10.0),
//               child: ListTile(
//                 leading: Icon(
//                   task.isCompleted ? Icons.check_circle : Icons.pending,
//                   color: task.isCompleted ? Colors.green : Colors.orange,
//                   size: 30.0,
//                 ),
//                 title: Text(
//                   task.title,
//                   style: TextStyle(
//                     fontSize: 18.0,
//                     fontWeight: FontWeight.bold,
//                     color: task.isCompleted ? Colors.grey : Colors.black,
//                     decoration: task.isCompleted
//                         ? TextDecoration.lineThrough
//                         : TextDecoration.none,
//                   ),
//                 ),
//                 trailing: Icon(
//                   Icons.arrow_forward_ios,
//                   color: Colors.grey,
//                   size: 20.0,
//                 ),
//                 onTap: () {
//                   // Handle task tap
//                   print('Task ${task.title} tapped');
//                 },
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

// class Task {
//   final String title;
//   final bool isCompleted;

//   Task({required this.title, required this.isCompleted});
// }
