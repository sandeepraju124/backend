import 'dart:convert';
import 'package:backendapp/register/onboardingtest.dart';
import 'package:backendapp/utils/constants.dart';
import 'package:backendapp/utils/icons.dart';
import 'package:backendapp/utils/navigators.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:http/http.dart' as http;

class AllSubcategoriesPage extends StatefulWidget {
  @override
  State<AllSubcategoriesPage> createState() => _AllSubcategoriesPageState();
}

class _AllSubcategoriesPageState extends State<AllSubcategoriesPage> {
  Map<String, List<Subcategory>> _categories = {};

  @override
  void initState() {
    super.initState();
    fetchAllCategories();
  }

  Future<void> fetchAllCategories() async {
    try {
      var response = await http.get(Uri.parse('$baseUrl/business_categories'));
      if (response.statusCode == 200) {
        var decodedResponse = json.decode(response.body);
        Map<String, List<Subcategory>> categories = {};

        for (var category in decodedResponse) {
          category.forEach((key, value) {
            if (key != "_id") {
              categories[key] = List<Subcategory>.from(
                  value.map((item) => Subcategory.fromJson(item)));
            }
          });
        }

        setState(() {
          _categories = categories;
        });
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor5LightTheme,
      appBar: AppBar(
        backgroundColor: tgDarkPrimaryColor,
        title: const Text(
          'Select your Business Category',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            LineAwesomeIcons.angle_left,
            size: 17,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: _categories.keys.length,
        itemBuilder: (context, index) {
          String categoryName = _categories.keys.elementAt(index);
          List<Subcategory> subcategories = _categories[categoryName]!;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 15,
                  top: 15,
                ),
                child: Text(
                  "$categoryName:",
                  style: TextStyle(
                    fontSize: 15.5,
                    fontWeight: FontWeight.w500,
                    color: secondaryColor60LightTheme,
                  ),
                ),
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 11,
                ),
                itemCount: subcategories.length,
                itemBuilder: (context, subIndex) {
                  Subcategory subcategory = subcategories[subIndex];

                  return GestureDetector(
                    onTap: () {
                      // Handle on tap
                      print(" $categoryName > ${subcategory.subcategory}");
                      // CustomOnboardingService
                      navigatorPush(
                          context,
                          CustomOnboardingService(
                            category: categoryName,
                            Subcategory: subcategory.subcategory,
                          ));
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            getIconForSubcategory(subcategory.subcategory),
                            size: 26,
                            color: Colors.teal.shade900,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          subcategory.subcategory,
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 11,
                              fontWeight: FontWeight.w400),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  );
                },
              ),
              const Divider(
                indent: 7,
                endIndent: 7,
                color: Color.fromARGB(255, 211, 222, 226),
                thickness: 1,
              ),
            ],
          );
        },
      ),
    );
  }
}

class Subcategory {
  final int priority;
  final String subcategory;

  Subcategory({required this.priority, required this.subcategory});

  factory Subcategory.fromJson(Map<String, dynamic> json) {
    return Subcategory(
      priority: json['priority'],
      subcategory: json['subcategory'],
    );
  }
}
