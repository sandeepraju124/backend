// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';



class AddPhotos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Center(
                  child: Text(
                    'Top Content',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 8,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Add your scrollable content here
                    Container(
                      height: 800,
                      color: Colors.white,
                      child: Center(
                        child: Text(
                          'Scrollable Content',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: MediaQuery.of(context).size.height * 0.8,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Add your scrollable bottom navigation bar items here
              ListTile(
                title: Text('Item 1'),
              ),
              ListTile(
                title: Text('Item 2'),
              ),
              ListTile(
                title: Text('Item 3'),
              ),
              ListTile(
                title: Text('Item 4'),
              ),
              ListTile(
                title: Text('Item 5'),
              ),
              ListTile(
                title: Text('Item 6'),
              ),
              ListTile(
                title: Text('Item 7'),
              ),
              ListTile(
                title: Text('Item 8'),
              ),
              ListTile(
                title: Text('Item 9'),
              ),
              ListTile(
                title: Text('Item 10'),
              ),
              ListTile(
                title: Text('Item 11'),
              ),
              ListTile(
                title: Text('Item 12'),
              ),
              ListTile(
                title: Text('Item 13'),
              ),
              ListTile(
                title: Text('Item 14'),
              ),
              ListTile(
                title: Text('Item 15'),
              ),
              ListTile(
                title: Text('Item 16'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
