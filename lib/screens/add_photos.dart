// ignore_for_file: prefer_const_constructors

import 'package:backendapp/provider/businessmongo_provider.dart';
import 'package:backendapp/utils/constants.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class AddPhotos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var data = Provider.of<ServicesProvider>(context);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      // backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              // flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  // color: Colors.blue,
                  // borderRadius: BorderRadius.only(
                  //   bottomLeft: Radius.circular(30),
                  //   bottomRight: Radius.circular(30),
                  // ),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: DottedBorder(
                          borderType: BorderType.RRect,
                          // strokeCap: StrokeCap.round,
                          radius: Radius.circular(12),
                          // dashPattern: [1,3],
                          strokeWidth: 1,
                          color: Colors.grey,
                          child: Container(
                            height: 70,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              // border: Border.all(
                              //   color: Colors.grey
                              // )
                            ),
                            // color: Colors.white,
                            child: Center(
                              child: Icon(Icons.add_circle_sharp),
                            ),
                          )),
                  ),
                  // Text(
                  //   'Top Content',
                  //   style: TextStyle(
                  //     color: Colors.white,
                  //     fontSize: 24,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                ),
              ),
            ),

          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
        height: MediaQuery.of(context).size.height * 0.8,
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text("Total Images ${data.BusinessData!.images!.length}", style: TextStyle(fontSize: 17, color: Colors.grey),),
              ),
              // Add your scrollable bottom navigation bar items here
               GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.all(16),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                // itemCount: 16,
                itemCount: data.BusinessData!.images!.length,
                itemBuilder: (BuildContext context, int index) {
                  return GridTile(
                    child: Container(
                      color: Colors.blue,
                      margin: EdgeInsets.all(4),
                      child: 
                      Image.network(data.BusinessData!.images![index], fit: BoxFit.cover,)
                      // Center(
                      //   child: Text(
                      //     'Item ${index + 1}',
                      //     style: TextStyle(
                      //       color: Colors.white,
                      //       fontWeight: FontWeight.bold,
                      //     ),
                      //   ),
                      // ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
