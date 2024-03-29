import 'package:backendapp/utils/constants.dart';
import 'package:flutter/material.dart';


class RentalsDetailScreen extends StatefulWidget {
  const RentalsDetailScreen({Key? key}) : super(key: key);

  @override
  State<RentalsDetailScreen> createState() => _RentalsDetailScreenState();
}

class _RentalsDetailScreenState extends State<RentalsDetailScreen> {
  TextEditingController searchController = TextEditingController();
  int selectIndex = 0;
  String searchQuery = '';

  void updateSearchQuery(String query) {
    setState(() {
      searchQuery = query;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sizedBox40,
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: Text(
                  // user,
                  "user",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: SizedBox(
                  height: 45,
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(0),
                      prefixIcon: const Icon(Icons.search_outlined),
                      // hintText: searchForUser,
                      // fillColor: gOffWhite,
                      filled: true,
                      border: InputBorder.none,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                    ),
                    onChanged: updateSearchQuery,
                  ),
                ),
              ),
              sizedBox15,
              Expanded(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(10),
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color:  Colors.grey,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 2, vertical: 6),
                        child: TabBar(
                          onTap: (index) {
                            setState(() {
                              selectIndex = index;
                            });
                          },
                          labelPadding:
                              const EdgeInsets.symmetric(horizontal: 05),
                          indicatorColor: Colors.grey,
                          tabs: [
                            selectIndex != 0
                                ? const Text(
                                    // '$upComing (0)',
                                    'upComing',
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 15),
                                  )
                                : Container(
                                    width: 130,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      // color: const Color(0xffe9e9e9)),
                                      color: Colors.grey,
                                    ),
                                    child: const Center(
                                      child: Text(
                                        'upComing (0)',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 15),
                                      ),
                                    ),
                                  ),
                            selectIndex != 1
                                ? const Text(
                                    'inProgress (0)',
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 15),
                                  )
                                : Container(
                                    width: 130,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      // color: const Color(0xffe9e9e9)),
                                      color: Colors.grey,
                                    ),
                                    child: const Center(
                                      child: Text(
                                        'inProgress (0)',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 15),
                                      ),
                                    ),
                                  ),
                            selectIndex != 2
                                ? const Text(
                                    "end",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15),
                                  )
                                : Container(
                                    width: 130,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      // color: const Color(0xffe9e9e9)),
                                      color: Colors.grey,
                                    ),
                                    child: const Center(
                                      child: Text(
                                        "end",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18),
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          Text("xxx"),
                          Text("xxx"),
                          Text("xxx"),
                          // InProgressScreen(
                          //   searchQuery: searchQuery,
                          // ),
                          // InProgressScreen(
                          //   searchQuery: searchQuery,
                          // ),
                          // InProgressScreen(
                          //   searchQuery: searchQuery,
                          // ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}