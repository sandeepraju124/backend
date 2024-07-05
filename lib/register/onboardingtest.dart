import 'dart:io';
import 'dart:math';

import 'package:backendapp/provider/registrationdata_provider.dart';
import 'package:backendapp/register/housetest.dart';
import 'package:backendapp/register/location_search_screen.dart';
import 'package:backendapp/register/select_location.dart';
import 'package:backendapp/register/waiting.dart';
import 'package:backendapp/utils/constants.dart';
import 'package:backendapp/utils/navigators.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class CustomOnboardingService extends StatefulWidget {
  final String? category;
  final String? Subcategory;
  CustomOnboardingService({this.category, this.Subcategory});
  @override
  _CustomOnboardingServiceState createState() =>
      _CustomOnboardingServiceState();
}

enum HosueType { un, semi, fully }

enum Bedrooms {
  single,
  double,
  triple,
}

class _CustomOnboardingServiceState extends State<CustomOnboardingService> {
  PageController _pageController = PageController();
  int _currentStep = 0;

  // String _category = "";
  // String _sub_category = "";
  late String _selectedField;
  bool carParking = false;
  bool twoWheelerParking = false;
  HosueType? _selectedHouseType;
  // Bedrooms? _selectedBedroom;
  int? _selectedBedroom;
  DateTime? availableFrom;
  int rent = 0;
  int adv = 0;
  String _generated_business_uid = "";

  TextEditingController availableFromController = TextEditingController();
  TextEditingController gateClosingTimeController = TextEditingController();
  TextEditingController otherRulesController = TextEditingController();

  TextEditingController _businessName = TextEditingController();
  TextEditingController _businessEmail = TextEditingController();
  TextEditingController _contactInfo = TextEditingController();
  TextEditingController _address = TextEditingController();
  TextEditingController _description = TextEditingController();
  TextEditingController pincode = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController _serviceEditingController = TextEditingController();

  File? _ffsaiImage;
  File? _profileimage;
  File? _certificationimage = null;
  File? _aadharfront = null;
  File? _aadharback = null;

  bool _isLoading = false;
  String? _houseFacing = null;
  int? _buildingAge = null;
  String? _Preferred = null;

  final List<String> services = [
    'Beauty & Spas > Barbers',
    'Beauty & Spas > Cosmetics & Beauty Supply',
    'Beauty & Spas > Acne Treatment',
    'Education > Adult Education',
    'Home Services > Plumbing',
    'Home Services > Electricians',
    'Home Services > Carpenters',
    'Home Services > Gardeners',
    'Home Services > Home Cleaning',
    'Home Services > Interior Design',
    'Home Services > Mobile Home Repair',
    'Nightlife > Bars',
    'Nightlife > Cocktail Bars',
    'Nightlife > Comedy Clubs',
    'Nightlife > Club Crawl',
    'Nightlife > Jazz & Blues',
    'Auto Service > Car Repair',
    'Health > Gym',
    'Food > Restaurant',
  ];

  // @override
  // void initState() {
  //   super.initState();
  // _selectedField = widget.category ?? "";
  // _selectedField = findFullCategoryPath(widget.category);
  // print("selectedField $_selectedField");
  // _serviceEditingController.text = _selectedField;
  // List<String?> cat = _selectedField.split(">");
  // print("cat $cat");
  // _category = cat[0]!.trim();
  // _sub_category = cat[1]!.trim();
  // }

  String findFullCategoryPath(String? category) {
    if (category == null || category.isEmpty) return "";
    for (String service in services) {
      if (service.endsWith(category)) {
        print("service $service");
        return service;
      }
    }
    return "";
  }

  void removeImage(int index) {
    setState(() {
      _images.removeAt(index);
    });
  }

  Future pickImage(ImageSource source, String file) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    // String? path = await _ffsaiImage?.path;
    // String fileName = path!.split('/').last;
    // print("fileName $fileName");
    // String imageName = path?.basename(imagePath);
    // print("path $path");
    if (pickedFile != null) {
      setState(() {
        switch (file) {
          case "_ffsaiImage":
            _ffsaiImage = File(
              pickedFile.path,
            );
            break;
          case "_aadharfront":
            _aadharfront = File(
              pickedFile.path,
            );
            break;
          case "_aadharback":
            _aadharback = File(
              pickedFile.path,
            );
            break;
          case "_profileimage":
            _profileimage = File(
              pickedFile.path,
            );
            break;
          case "_certificationimage":
            _certificationimage = File(
              pickedFile.path,
            );
            break;
        }
      });
    }
  }

  final _mapScreen = MapScreen();
  List<File> _images = [];

  Future<void> multiImagePick() async {
    List pickedFiles = await ImagePicker().pickMultiImage();
    setState(() {
      _images = pickedFiles.map((file) => File(file.path)).toList();
    });
  }

  Future<void> pickImageExtra() async {
    List pickedFiles = await ImagePicker().pickMultiImage();
    setState(() {
      // List<File> _extraImages = [];
      List<File> _extraImages =
          pickedFiles.map((file) => File(file.path)).toList();
      _images.addAll(_extraImages);
    });
  }

  // ################## posting  ############################

  String generateRandomChars(int length) {
    const chars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    return String.fromCharCodes(Iterable.generate(
        length, (_) => chars.codeUnitAt(random.nextInt(chars.length))));
  }

  String generateRandomString(String category, String subCategory) {
    // Get the first 3 letters of the category and subcategory
    String categoryPrefix = category.substring(0, 3).toUpperCase();
    String subCategoryPrefix = subCategory.substring(0, 3).toUpperCase();

    // Generate random alphanumeric characters
    String randomChars = generateRandomChars(10);

    // Concatenate all parts to form the final string
    return '$categoryPrefix$subCategoryPrefix$randomChars';
  }

  // String business_uid = generateRandomString(widget.category, widget.Subcategory);

  Future<bool> postImages() async {
    try {
      // String business_uid = generateRandomString(widget.category!, widget.Subcategory!);
      final url2 = Uri.parse(
          "https://supernova1137.azurewebsites.net/post_multiple_images");
      var request = http.MultipartRequest('POST', url2);
      request.fields['business_uid'] = _generated_business_uid;
      print(_generated_business_uid);

      if (_aadharfront != null) {
        File aadharFrontImage = File(_aadharfront!.path);
        File aadharBackImage = File(_aadharback!.path);
        request.files.add(await http.MultipartFile.fromPath(
            'aadhar_front', aadharFrontImage.path));
        request.files.add(await http.MultipartFile.fromPath(
            'aadhar_back', aadharBackImage.path));
      }

      if (_images.isNotEmpty) {
        for (File image in _images) {
          request.files
              .add(await http.MultipartFile.fromPath('images', image.path));
        }
      }

      if (_certificationimage != null) {
        File certification = File(_certificationimage!.path);
        request.files.add(await http.MultipartFile.fromPath(
            'certificationimage', certification.path));
      }

      if (_ffsaiImage != null) {
        File ffsaiImage = File(_certificationimage!.path);
        request.files.add(
            await http.MultipartFile.fromPath('ffsaiImage', ffsaiImage.path));
      }

      var response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        print(responseBody);

        // return 'Service created successfully';
        return true;
      } else {
        throw Exception('Failed to send images');
      }
    } catch (e) {
      print(e.toString());
      throw Exception('Failed to send images: $e');
    }
  }

  Future<bool> postBusiness(String category, String subcategory) async {
    setState(() {
      _isLoading = true;
    });

    final user = FirebaseAuth.instance.currentUser;
    final userid = user?.uid;
    print(userid);

    print("before try");
    try {
      print("inside try");
      final url =
          Uri.parse("https://supernova1137.azurewebsites.net/pg/business");

      Map<String, String> body = {
        'business_uid': _generated_business_uid,
        'business_name': _businessName.text,
        'business_description': _description.text,
        'contact_information': _contactInfo.text,
        'country': "india",
        'category': category,
        'sub_category': subcategory,
        // 'latitude': data.registrationData['latitude'].toString(),
        // 'longitude': data.registrationData['longitude'].toString(),
        'userid': userid.toString(),
      };

      print(" try");
      print(Random(5).nextInt(5));

      final request = http.MultipartRequest(
        'POST',
        url,
      )..fields.addAll(body);

      // Conditionally add profile_image_url if it is not null
      // if (data.registrationData['profile_image_url'] != null && data.registrationData['profile_image_url'].isNotEmpty) {
      //   request.files.add(await http.MultipartFile.fromPath(
      //     'profile_image_url', data.registrationData['profile_image_url']
      //   ));
      // }

      if (_profileimage != null) {
        File profileimage = File(_profileimage!.path);
        request.files.add(await http.MultipartFile.fromPath(
            'profileimage', profileimage.path));
      }

      // Conditionally add aadhar_front if it is not null

      final response = await request.send();
      print(response.statusCode);
      print(response);

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        print(responseBody);

        if (widget.Subcategory == "Fullhouse") {
          postHouseData().then((value) {
            if (value == true) {
              // navigatorPush(context, WaitingScreen());
              print(value);
              
              print("house data uploaded");
            } else {
              showSnackBar(context, "error please try again");
            }
          });
        }

        setState(() {
          _isLoading = false;
        });

        return true;
      } else {
        throw Exception('Failed to create service');
      }
    } catch (e) {
      print(e.toString());
      throw Exception('Failed to create service: $e');
    }
  }

  Future<bool> postHouseData() async {
    setState(() {
      _isLoading = true;
    });

    final user = FirebaseAuth.instance.currentUser;
    final userid = user?.uid;
    print(userid);
    try {
      print("inside try");
      final url = "https://supernova1137.azurewebsites.net/pg/house";

      Map<String, String> body = {
        'business_uid': _generated_business_uid,
        'house_facing': _houseFacing!,
        'building_age': _buildingAge!.toString(),
        'house_type': _selectedHouseType.toString(),
        'price': rent.toString(),
        'bedrooms': _buildingAge!.toString(),
        'car_parking': carParking.toString(),
        'advance': adv.toString(),
        'preferred': _Preferred!,
        'furnishing_level': _selectedHouseType.toString(),
        // 'latitude': data.registrationData['latitude'].toString(),
        // 'longitude': data.registrationData['longitude'].toString(),
        // 'userid': userid.toString(),
      };

      print("housebody $body");

      final response = await http.post(
        Uri.parse(url),
        body: body,
      );
      print(response.statusCode);
      print(response);

      if (response.statusCode == 200) {
        final responseBody = await response.body;
        print(responseBody);

        setState(() {
          _isLoading = false;
        });

        return true;
      } else {
        throw Exception('Failed to create service');
      }
    } catch (e) {
      print(e.toString());
      throw Exception('Failed to create service: $e');
    }
  }

  // ################## posting  ############################

  @override
  Widget build(BuildContext context) {
    print("category ${widget.category}");
    print("subcategoey ${widget.Subcategory}");
    var data = Provider.of<RegistrationProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(
          'Onboarding Details',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentStep = index;
          });
        },
        children: [
          _basicInfoStep(),
          // PGDetailsForm(),
          // _uploadDoc(),
          // _houseInfo(),
          //  if (widget.Subcategory != null && Page2Display(widget.Subcategory!) != null)
          //   Page2Display(widget.Subcategory!),
          Page2Display(widget.Subcategory ?? ""),
          // _plumber(),
          // _sub_category == "Barbers" ? _basicInfoStep():_buildStep2(),
          // _buildStep3(),
          // _uploadDoc(),
          // _uploadImagesAll(),
          _imageUploadByCategory(),
          // SearchLocationScreen(),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _houseInfo() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Step 2: House Info'),
            SizedBox(height: 16),
            // _buildGenderSelection(),
            SizedBox(height: 16),
            _buildTenantTypeSelection(),
            // SizedBox(height: 16),
            // _buildAvailableFromInput(),
            SizedBox(height: 16),
            _buildAvailableNewFromInput(),
            // _buildFoodIncludedSelection(),

            SizedBox(
              height: 16,
            ),
            _buildFacingTypeSelection(),
            SizedBox(
              height: 16,
            ),
            _buildBuildingAge(),
            SizedBox(
              height: 16,
            ),
            Text("Funiture type"),
            SizedBox(
              height: 16,
            ),
            furnitureType(),
            SizedBox(
              height: 16,
            ),
            bedrooms(),
            SizedBox(
              height: 16,
            ),
            CarParking(),
            // SizedBox(height: 8,),
            TwoWheelerParking(),
            SizedBox(
              height: 10,
            ),
            rentAmount(),
            SizedBox(
              height: 10,
            ),
            advAmount(),
          ],
        ),
      ),
    );
  }

  Widget _plumber() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Step 2: Plumbing Info'),
          SizedBox(height: 16),
          _plumbingExperiance(),
        ]),
      ),
    );
  }

  Widget furnitureType() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildHouseOption(HosueType.un, "Un"),
          _buildHouseOption(HosueType.semi, "Semi"),
          _buildHouseOption(HosueType.fully, "Fully")
        ],
      ),
    );
  }

  Widget bedrooms() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildBedRoomOption(Bedrooms.single, "Single"),
          _buildBedRoomOption(Bedrooms.double, "Double"),
          _buildBedRoomOption(Bedrooms.triple, "Triple"),
          // _buildBedRoomOption(Bedrooms.triple, "Triple")
        ],
      ),
    );
  }

  Widget _buildHouseOption(HosueType type, String label) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedHouseType = type;
          print(_selectedHouseType);
          // _selectedCriteria.houseType = type;
          // _selectedCriteria2['houseType'] = type.toString().split('.').last;
          // print(_selectedCriteria2);
          // print("_selectedCriteria2");

          // print(_selectedCriteria);
        });
      },
      child: Container(
          // margin: EdgeInsets.all(10),
          // height: 50,
          // width: 50,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Colors.grey,
                width: 1.0,
              ),
              color: _selectedHouseType == type
                  // ? Colors.teal[200]
                  ? Colors.grey[200]
                  : Colors.white
              // Colors.grey[200]
              ),
          child: Column(
            children: [
              // Icon(Icons.access_alarm_rounded),
              if (type == HosueType.un)
                SvgPicture.asset("assets/fullhouse.svg", height: 30),
              if (type == HosueType.semi)
                SvgPicture.asset("assets/pg.svg", height: 30),
              if (type == HosueType.fully)
                SvgPicture.asset("assets/penthouse.svg", height: 30),
              Text(
                label,
              ),
              Text(
                "Furnished",
              ),
            ],
          )),
    );
  }

  Widget rentAmount() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: 'Rent Amount',
          labelStyle: TextStyle(
            color: Colors.teal,
            fontWeight: FontWeight.bold,
          ),
          hintText: 'Enter the rent amount',
          hintStyle: TextStyle(color: Colors.grey),
          prefixIcon: Icon(Icons.attach_money, color: Colors.green),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(
              color: Colors.teal,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(
              color: Colors.teal,
              width: 2.0,
            ),
          ),
        ),
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
        ],
        onChanged: (value) {
          setState(() {
            rent = int.tryParse(value) ?? 0;
          });
        },
      ),
    );
  }

  Widget descriptionBox() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextFormField(
        maxLines: null, // Makes the TextFormField expandable
        decoration: InputDecoration(
          labelText: 'Description',
          labelStyle: TextStyle(
            color: Colors.teal,
            fontWeight: FontWeight.bold,
          ),
          hintText: 'Enter the description',
          hintStyle: TextStyle(color: Colors.grey),
          prefixIcon: Icon(Icons.description, color: Colors.blue),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(
              color: Colors.teal,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(
              color: Colors.teal,
              width: 2.0,
            ),
          ),
        ),
        keyboardType: TextInputType.multiline,
        textInputAction: TextInputAction.newline,
        onChanged: (value) {
          setState(() {
            // description = value;
          });
        },
      ),
    );
  }

  Widget advAmount() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: 'Advance Amount',
          labelStyle: TextStyle(
            color: Colors.teal,
            fontWeight: FontWeight.bold,
          ),
          hintText: 'Enter the Advance amount',
          hintStyle: TextStyle(color: Colors.grey),
          prefixIcon: Icon(Icons.currency_rupee, color: Colors.teal),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(
              color: Colors.teal,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(
              color: Colors.teal,
              width: 2.0,
            ),
          ),
        ),
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
        ],
        onChanged: (value) {
          setState(() {
            rent = int.tryParse(value) ?? 0;
          });
        },
      ),
    );
  }

  Widget _buildBedRoomOption(Bedrooms type, String label) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (type == "Bedrooms.single") {
            _selectedBedroom = 1;
          }
          if (type == "Bedrooms.double") {
            _selectedBedroom = 2;
          }
          if (type == "Bedrooms.triple") {
            _selectedBedroom = 3;
          }
          // _selectedBedroom = type;
          print(_selectedBedroom);
          // _selectedCriteria.houseType = type;
          // _selectedCriteria2['houseType'] = type.toString().split('.').last;
          // print(_selectedCriteria2);
          // print("_selectedCriteria2");

          // print(_selectedCriteria);
        });
      },
      child: Container(
          // margin: EdgeInsets.all(10),
          // height: 50,
          // width: 50,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Colors.grey,
                width: 1.0,
              ),
              color: _selectedBedroom == type
                  // ? Colors.teal[200]
                  ? Colors.grey[200]
                  : Colors.white
              // Colors.grey[200]
              ),
          child: Column(
            children: [
              // Icon(Icons.access_alarm_rounded),
              if (type == Bedrooms.single)
                SvgPicture.asset("assets/fullhouse.svg", height: 30),
              if (type == Bedrooms.double)
                SvgPicture.asset("assets/pg.svg", height: 30),
              if (type == Bedrooms.triple)
                SvgPicture.asset("assets/penthouse.svg", height: 30),
              Text(
                label,
              ),
              Text(
                "Bedroom",
              ),
            ],
          )),
    );
  }

  Widget CarParking() {
    return CheckboxListTile(
      title: const Text('Car Parking'),
      value: carParking,
      onChanged: (bool? value) {
        setState(() {
          carParking = value!;
        });
      },
    );
  }

  Widget TwoWheelerParking() {
    return CheckboxListTile(
      title: const Text('Two Wheeler Parking'),
      value: twoWheelerParking,
      onChanged: (bool? value) {
        setState(() {
          twoWheelerParking = value!;
        });
      },
    );
  }

  Widget _basicInfoStep() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text('Step 1: Basic Info'),
            SizedBox(
              height: 26,
            ),
            // Text("${widget.category} > ${widget.Subcategory}", style:TextStyle(overflow: TextOverflow.fade) ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(10),
                labelText: 'Selected category',
              ),
              controller: TextEditingController(
                text: "${widget.category} > ${widget.Subcategory}",
              ),
              enabled: false, // Makes the TextField non-editable
            ),

            SizedBox(height: 16),
            TextField(
              controller: _businessName,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelStyle: TextStyle(),
                contentPadding: EdgeInsets.all(10),
                labelText: 'Business Name or Owner Name',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _businessEmail,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(10),
                labelText: 'Email',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _description,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10),
                border: OutlineInputBorder(),
                labelText: 'Business description',
              ),
              autofocus: false,
              // focusNode: _focusnode,
              maxLines: null,
              // controller: _newreplycontroller,
              keyboardType: TextInputType.text,
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              controller: _contactInfo,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(10),
                border: OutlineInputBorder(),
                labelText: 'Contact info',
              ),
              autofocus: false,
              maxLines: null,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              controller: _address,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(10),
                border: OutlineInputBorder(),
                labelText: 'Address',
              ),
              autofocus: false,
              // focusNode: _focusnode,
              maxLines: null,
              // controller: _newreplycontroller,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(
              height: 16,
            ),
            // TypeAheadField(
            //   textFieldConfiguration: TextFieldConfiguration(
            //       // controller: _serviceEditingController,
            //       decoration: const InputDecoration(
            //     contentPadding: EdgeInsets.all(10),
            //     labelText: "Select a Service",
            //     border: OutlineInputBorder(),
            //   )),
            //   suggestionsCallback: (pattern) {
            //     if (pattern.isEmpty) {
            //       return List<String>.empty();
            //     } else {
            //       return services.where((service) =>
            //           service.toLowerCase().contains(pattern.toLowerCase()));
            //     }
            //   },
            //   itemBuilder: (context, service) {
            //     return ListTile(
            //       title: Text(service),
            //     );
            //   },
            //   onSuggestionSelected: (service) {
            //     _serviceEditingController.text = service;
            //     List<String> cat = service.split(">");
            //     // _category = cat[0].trim();
            //     // _sub_category = cat[1].trim();

            //     setState(() {
            //       _selectedField = service;
            //     });
            //     print("this is $_selectedField");
            //     print(cat[0]);
            //     print(cat[1]);
            //   },
            // ),
            // _selectedField != null
            //     ? displayServiceField(_selectedField)
            //     : Text("no")
          ],
        ),
      ),
    );
  }

  Widget _uploadImagesAll() {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Step 3: Upload Images'),
            SizedBox(height: 16),
            _profilePictureUpload(),
            SizedBox(height: 16),
            _multiSelectUpload(),
            SizedBox(height: 16),
            _govIdUpload(),
            SizedBox(height: 16),
            _aadharUpload(),
            SizedBox(height: 16),
            _certificationUpload(),
          ],
        )));
  }

  Widget _multiSelectUpload() {
    return Column(
      children: [
        const Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Upload Business images (Max 10)",
              style: TextStyle(fontSize: 23),
            )),
        const SizedBox(
          height: 2,
        ),
        const Align(
            alignment: Alignment.topLeft,
            child: Text(
              "upload all the images that will be shown in the profile",
              style: TextStyle(color: Colors.grey),
            )),
        const SizedBox(
          height: 8,
        ),
        Stack(
          alignment: AlignmentDirectional.center,
          children: [
            DottedBorder(
                // dashPattern: [1,3],
                strokeWidth: 1,
                color: Colors.grey,
                child: Container(
                  height: 120,
                  // color: Colors.grey,
                )),
            _images.length == 0
                ? InkWell(
                    onTap: () {
                      // pickImage(ImageSource.gallery,"_ffsaiImage" );
                      // pickImage();
                      multiImagePick();
                    },
                    child:
                        // _ffsaiImage == null ?
                        DottedBorder(
                      strokeWidth: 1,
                      color: Colors.grey,
                      child: Container(
                        color: Colors.blue[50],
                        height: 75,
                        width: 75,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            // crossAxisAlignment:CrossAxisAlignment.stretch ,
                            children: const [
                              Icon(Icons.camera_alt),
                              Text("Add Photo"),
                            ]),
                      ),
                    ))
                : SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            pickImageExtra();
                          },
                          child: DottedBorder(
                            strokeWidth: 1,
                            color: Colors.grey,
                            child: Container(
                              color: Colors.blue[50],
                              height: 75,
                              width: 75,
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  // crossAxisAlignment:CrossAxisAlignment.stretch ,
                                  children: const [
                                    Icon(Icons.camera_alt),
                                    Text("Add Photo"),
                                  ]),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        for (int i = 0; i < _images.length; i++)
                          Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DottedBorder(
                                  strokeWidth: 1,
                                  color: Colors.grey,
                                  child: Row(
                                    children: [
                                      Image.file(
                                        _images[i],
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.clear),
                                onPressed: () => removeImage(i),
                              ),
                            ],
                          ),
                      ],
                    ),
                  )
          ],
        ),
      ],
    );
  }

  Widget _buildStep2() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Step 2: PG Rules'),
          SizedBox(height: 16),
          _buildGateClosingTimeInput(),
          SizedBox(height: 16),
          _buildPGRulesSelection(),
        ],
      ),
    );
  }

  Widget _govIdUpload() {
    return Column(
      children: [
        Align(
            alignment: Alignment.topLeft,
            child: Text(
              "FFSAI Image",
              style: TextStyle(fontSize: 23),
            )),
        const SizedBox(
          height: 4,
        ),
        const Align(
            alignment: Alignment.topLeft,
            child: Text(
              "please upload a govt issued ffsai document for us to varify",
              style: TextStyle(color: Colors.grey),
            )),
        const SizedBox(
          height: 8,
        ),
        Stack(
          alignment: AlignmentDirectional.center,
          children: [
            DottedBorder(
                // dashPattern: [1,3],
                strokeWidth: 1,
                color: Colors.grey,
                child: Container(
                  height: 120,
                  // color: Colors.grey,
                )),
            InkWell(
              onTap: () {
                pickImage(ImageSource.gallery, "_ffsaiImage");
              },
              child: _ffsaiImage == null
                  ? DottedBorder(
                      strokeWidth: 1,
                      color: Colors.grey,
                      child: Container(
                        color: Colors.blue[50],
                        height: 75,
                        width: 75,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            // crossAxisAlignment:CrossAxisAlignment.stretch ,
                            children: const [
                              Icon(Icons.camera_alt),
                              Text("Add Photo"),
                            ]),
                      ),
                    )
                  : SizedBox(
                      height: 75,
                      width: 75,
                      child: Image.file(_ffsaiImage!, fit: BoxFit.fill),
                    ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _aadharUpload() {
    return Column(
      children: [
        const Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Aadhar Card Images",
              style: TextStyle(fontSize: 23),
            )),
        const SizedBox(
          height: 1,
        ),
        const Align(
            alignment: Alignment.topLeft,
            child: Text(
              "please upload a govt issued aadhar document for us to varify",
              style: TextStyle(color: Colors.grey),
            )),
        const SizedBox(
          height: 10,
        ),
        Stack(
          alignment: AlignmentDirectional.center,
          children: [
            DottedBorder(
                // dashPattern: [1,3],
                strokeWidth: 1,
                color: Colors.grey,
                child: Container(
                  height: 120,
                  // color: Colors.grey,
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    pickImage(ImageSource.gallery, "_aadharfront");
                  },
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: _aadharfront == null
                          ? DottedBorder(
                              strokeWidth: 1,
                              color: Colors.grey,
                              child: Container(
                                height: 75,
                                width: 75,
                                color: Colors.blue[50],
                                child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    // crossAxisAlignment:CrossAxisAlignment.stretch ,
                                    children: const [
                                      Icon(Icons.camera_alt),
                                      Text("Front Photo")
                                    ]),
                              ),
                            )
                          : SizedBox(
                              height: 75,
                              width: 75,
                              child:
                                  Image.file(_aadharfront!, fit: BoxFit.fill),
                            )),
                ),
                InkWell(
                  onTap: () {
                    pickImage(ImageSource.gallery, "_aadharback");
                  },
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: _aadharback == null
                        ? DottedBorder(
                            strokeWidth: 1,
                            color: Colors.grey,
                            child: Container(
                              height: 75,
                              width: 75,
                              color: Colors.blue[50],
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  // crossAxisAlignment:CrossAxisAlignment.stretch ,
                                  children: const [
                                    Icon(Icons.camera_alt),
                                    Text("Back Photo")
                                  ]),
                            ),
                          )
                        : SizedBox(
                            height: 75,
                            width: 75,
                            child: Image.file(_aadharback!, fit: BoxFit.fill),
                          ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStep3() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Step 3: Other Rules'),
          SizedBox(height: 16),
          _buildOtherRulesInput(),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // Handle form submission
            },
            child: Text('Save and Continue'),
          ),
        ],
      ),
    );
  }

  // Widget Page2Display(String category){
  //   switch (category){
  //     case "house":
  //       return _houseInfo();

  //   }

  //  }

  Widget Page2Display(String subcategory) {
    switch (subcategory) {
      case "Fullhouse":
        return _houseInfo();
      case "Plumbers":
        return _plumber();
      case 'Carpenters':
        return Column(children: const [
          Text("this is 4"),
          Text("this is 5"),
        ]);
      default:
        return descriptionBox();
    }
  }

  Widget Page3Display(String subcategory) {
    switch (subcategory) {
      case "Fullhouse":
        return Column(
          children: [
            _profilePictureUpload(),
            SizedBox(
              height: 16,
            ),
            _multiSelectUpload(),
          ],
        );
      case "Plumbers":
        return Column(
          children: [
            _govIdUpload(),
            SizedBox(
              height: 16,
            ),
            _multiSelectUpload(),
          ],
        );
      case 'Carpenters':
        return Column(children: [
          _aadharUpload(),
        ]);
      default:
        return Column(children: [
          _multiSelectUpload(),
        ]);
    }
  }

  Widget _imageUploadByCategory() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Page3Display(widget.Subcategory ?? ""),
        ]),
      ),
    );
  }

  Widget _profilePictureUpload() {
    return Column(
      children: [
        Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Profile picture (Optional)",
              style: TextStyle(fontSize: 23),
            )),
        const SizedBox(
          height: 2,
        ),
        const Align(
            alignment: Alignment.topLeft,
            child: Text(
              "please upload a certification related your services",
              style: TextStyle(color: Colors.grey),
            )),
        const SizedBox(
          height: 8,
        ),
        Stack(
          alignment: AlignmentDirectional.center,
          children: [
            DottedBorder(
                // dashPattern: [1,3],
                strokeWidth: 1,
                color: Colors.grey,
                child: Container(
                  height: 120,
                  // color: Colors.grey,
                )),
            InkWell(
              onTap: () {
                pickImage(ImageSource.gallery, "_profileimage");
              },
              child: _profileimage == null
                  ? DottedBorder(
                      strokeWidth: 1,
                      color: Colors.grey,
                      child: Container(
                        color: Colors.blue[50],
                        height: 75,
                        width: 75,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            // crossAxisAlignment:CrossAxisAlignment.stretch ,
                            children: const [
                              Icon(Icons.camera_alt),
                              Text("Add Photo"),
                            ]),
                      ),
                    )
                  : SizedBox(
                      height: 75,
                      width: 75,
                      child: Image.file(_profileimage!, fit: BoxFit.fill),
                    ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _certificationUpload() {
    return Column(
      children: [
        Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Certifications/Licenses (Optional)",
              style: TextStyle(fontSize: 23),
            )),
        const SizedBox(
          height: 2,
        ),
        const Align(
            alignment: Alignment.topLeft,
            child: Text(
              "please upload a certification related your services",
              style: TextStyle(color: Colors.grey),
            )),
        const SizedBox(
          height: 8,
        ),
        Stack(
          alignment: AlignmentDirectional.center,
          children: [
            DottedBorder(
                // dashPattern: [1,3],
                strokeWidth: 1,
                color: Colors.grey,
                child: Container(
                  height: 120,
                  // color: Colors.grey,
                )),
            InkWell(
              onTap: () {
                pickImage(ImageSource.gallery, "_certificationimage");
              },
              child: _certificationimage == null
                  ? DottedBorder(
                      strokeWidth: 1,
                      color: Colors.grey,
                      child: Container(
                        color: Colors.blue[50],
                        height: 75,
                        width: 75,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            // crossAxisAlignment:CrossAxisAlignment.stretch ,
                            children: const [
                              Icon(Icons.camera_alt),
                              Text("Add Photo"),
                            ]),
                      ),
                    )
                  : SizedBox(
                      height: 75,
                      width: 75,
                      child: Image.file(_certificationimage!, fit: BoxFit.fill),
                    ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildGenderSelection() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Text('PG available for: '),
          Radio(value: 1, groupValue: 0, onChanged: (value) {}),
          Text('Male'),
          Radio(value: 2, groupValue: 0, onChanged: (value) {}),
          Text('Female'),
          Radio(value: 3, groupValue: 0, onChanged: (value) {}),
          Text('Anyone'),
        ],
      ),
    );
  }

  Widget _buildTenantTypeSelection() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Preferred Tenants',
      ),
      items: ['Anyone', 'Family'].map((String type) {
        return DropdownMenuItem<String>(
          value: type,
          child: Text(type),
        );
      }).toList(),
      onChanged: (value) {
        print(value);
        _Preferred = value;
      },
    );
  }

  Widget _buildFacingTypeSelection() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Facing',
      ),
      items: ['not to Specify', 'East', 'West', 'South', 'North']
          .map((String type) {
        return DropdownMenuItem<String>(
          value: type,
          child: Text(type),
        );
      }).toList(),
      onChanged: (value) {
        print(value);
        _houseFacing = value!;
      },
    );
  }

  Widget _buildBuildingAge() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Building Age',
      ),
      items: ['One', 'Two', 'Three', 'Four', 'Five+'].map((String type) {
        return DropdownMenuItem<String>(
          value: type,
          child: Text(type),
        );
      }).toList(),
      onChanged: (value) {
        // _buildingAge = value!;
        if (value == "One") {
          _buildingAge = 1;
        } else if (value == "Two") {
          _buildingAge = 2;
        } else if (value == "Three") {
          _buildingAge = 3;
        } else if (value == "Four") {
          _buildingAge = 4;
        } else if (value == "Five+") {
          _buildingAge = 5;
        }
      },
    );
  }

  Widget _plumbingExperiance() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Years of Experiance',
      ),
      items: ['One', 'Two', 'Three', 'Four', 'Five+'].map((String type) {
        return DropdownMenuItem<String>(
          value: type,
          child: Text(type),
        );
      }).toList(),
      onChanged: (value) {},
    );
  }

  Widget _buildAvailableFromInput() {
    return TextFormField(
      controller: availableFromController,
      decoration: InputDecoration(
        hintText: 'Available From',
        border: OutlineInputBorder(),
        labelText: availableFrom != null
            ? 'Available From: ${availableFrom!.toLocal().toString().split(' ')[0]}'
            : 'Available From',
        suffixIcon: GestureDetector(
            onTap: () async {
              DateTime? picked = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2101),
              );
              if (picked != null && picked != availableFrom)
                setState(() {
                  availableFrom = picked;
                });
            },
            child: Icon(
              Icons.calendar_today,
            )),
      ),
    );
  }

  Widget _buildAvailableNewFromInput() {
    return TextFormField(
      controller: availableFromController,
      readOnly: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Available From',
        suffixIcon: GestureDetector(
          onTap: () async {
            DateTime? picked = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2101),
            );
            if (picked != null && picked != availableFrom) {
              setState(() {
                availableFrom = picked;
                availableFromController.text =
                    "${picked.toLocal()}".split(' ')[0];
              });
            }
          },
          child: Icon(Icons.calendar_today),
        ),
      ),
    );
  }

  Widget _buildFoodIncludedSelection() {
    return Row(
      children: [
        Text('Food Included: '),
        Radio(value: 1, groupValue: 0, onChanged: (value) {}),
        Text('Yes'),
        Radio(value: 2, groupValue: 0, onChanged: (value) {}),
        Text('No'),
      ],
    );
  }

  Widget _buildGateClosingTimeInput() {
    return TextField(
      controller: gateClosingTimeController,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Enter gate closing time',
        suffixIcon: Icon(Icons.access_time),
      ),
    );
  }

  Widget _buildPGRulesSelection() {
    return Column(
      children: [
        CheckboxListTile(
          title: Text('No Smoking'),
          value: false,
          onChanged: (value) {},
        ),
        CheckboxListTile(
          title: Text('No Non-veg'),
          value: false,
          onChanged: (value) {},
        ),
        CheckboxListTile(
          title: Text('No Guardian'),
          value: false,
          onChanged: (value) {},
        ),
        CheckboxListTile(
          title: Text('No Drinking'),
          value: false,
          onChanged: (value) {},
        ),
      ],
    );
  }

  Widget _buildOtherRulesInput() {
    return TextField(
      controller: otherRulesController,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Specify other rules',
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    var data = Provider.of<RegistrationProvider>(context, listen: false);
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (_currentStep > 0)
            TextButton(
              onPressed: () {
                _pageController.previousPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.ease,
                );
              },
              child: Text('Back'),
            ),
          if (_currentStep < 2)
            TextButton(
              onPressed: () {
                _pageController.nextPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.ease,
                );
              },
              child: Text('Next'),
            ),
          if (_currentStep == 2)
            ElevatedButton(
              onPressed: () async {
                // Handle form submission
                Map<String, dynamic> businessdata = {
                  'businessName': _businessName.text,
                  'businessEmail': _businessEmail.text,
                  'contactInfo': _contactInfo.text,
                  'address': _address.text,
                  'country': "india",
                  'profile_image_url': _profileimage?.path,
                  'category': widget.category,
                  'sub_category': widget.Subcategory,
                  'business_description': _description.text
                  // 'latitude':widget.lat.toString(),
                  // 'langitude' : widget.lang.toString()
                  // 'image' : _ffsaiImage
                };
                if (_images.isNotEmpty) {
                  businessdata['images'] = _images;
                }
                if (_aadharfront != null && _aadharback != null) {
                  businessdata['aadhar_front'] = _aadharfront;
                  businessdata['aadhar_back'] = _aadharback;
                }
                // Adding additional fields
                // if (_selectedField.isNotEmpty) {
                //   businessdata['selectedField'] = _selectedField;
                // }

                // businessdata['carParking'] = carParking;
                // businessdata['twoWheelerParking'] = twoWheelerParking;

                // if (_selectedType != null) {
                //   businessdata['selectedType'] = _selectedType.toString();
                // }

                // if (rent != 0) {
                //   businessdata['rent'] = rent;
                // }
                // // Remove any entries with null values
                // businessdata.removeWhere((key, value) => value == null);

                _generated_business_uid =
                    await generateRandomString(widget.category!, widget.Subcategory!);
                // data.updateBusinessData(businessdata);
                // print("pressed $businessdata");
                postBusiness(widget.category!, widget.Subcategory!)
                    .then((value) {
                  if (value == true) {
                    // navigatorPush(context, WaitingScreen());
                    postImages().then((value) {
                      if (value == true) {
                        // navigatorPush(context, WaitingScreen());
                        print("images uploaded");
                        navigatorPush(context, SearchLocationScreen(businessUid: _generated_business_uid,));
                      }
                    });
                    print(value);
                  } else {
                    showSnackBar(context, "error please try again");
                  }
                });
                // navigatorPush(context, SearchLocationScreen());
                // if (widget.Subcategory == "Fullhouse") {
                //   postHouseData().then((value) {
                //     if (value == true) {
                //       // navigatorPush(context, WaitingScreen());
                //       print(value);
                //       print("house data uploaded");
                //     } else {
                //       showSnackBar(context, "error please try again");
                //     }
                //   });
                // }
                // navigatorPush(context, SearchLocationScreen());
              },
              child: _isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                        backgroundColor: Colors.white,
                      ))
                    : Text('Save & Continue'),

            ),
        ],
      ),
    );
  }

  Widget displayServiceField(String service) {
    switch (service) {
      case "Beauty & Spas > Barbers":
        return Column(children: [
          SizedBox(
            height: 10,
          ),
          TextField(
            // controller: ,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelStyle: TextStyle(),
              contentPadding: EdgeInsets.all(10),
              labelText: 'Plumbing issue description',
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            // controller: two,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelStyle: TextStyle(),
              contentPadding: EdgeInsets.all(10),
              labelText: 'Cost estimate',
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            // controller: three,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelStyle: TextStyle(),
              contentPadding: EdgeInsets.all(10),
              labelText: 'Contact information',
            ),
          ),
        ]);
      case 'Home Services > Carpenters':
        return Column(children: const [
          Text("this is 4"),
          Text("this is 5"),
        ]);
      case 'Auto Service > Car Repair':
        return Column(children: const [
          SizedBox(
            height: 10,
          ),
          TextField(
            // controller: ,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelStyle: TextStyle(),
              contentPadding: EdgeInsets.all(10),
              labelText: 'Car Name',
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text("this is 7"),
        ]);

      default:
        return Text("");
    }
  }
}
