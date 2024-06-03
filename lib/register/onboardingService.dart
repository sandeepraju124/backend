// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations

import 'dart:convert';
import 'package:backendapp/provider/registrationdata_provider.dart';
import 'package:backendapp/register/location_search_screen.dart';
import 'package:backendapp/screens/processing.dart';
import 'package:backendapp/register/select_location.dart';
import 'package:backendapp/utils/navigators.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:backendapp/utils/constants.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';

class OnboardingService extends StatefulWidget {
  final String? category;
   OnboardingService({ this.category });

  // String lat;
  // String lang;
  // AddService({required this.lat, required this.lang});

  @override
  State<OnboardingService> createState() => _OnboardingServiceState();
}

class _OnboardingServiceState extends State<OnboardingService> {
  late String _selectedField;
  String _category = "";
  String _sub_category = "";
  @override
  void initState() {
    super.initState();
    // _selectedField = widget.category ?? "";
    _selectedField = findFullCategoryPath(widget.category);
    print("selectedField $_selectedField");
    _serviceEditingController.text = _selectedField;
    List<String?> cat = _selectedField.split(">");
    print("cat $cat");
    _category = cat[0]!.trim();
    _sub_category = cat[1]!.trim();
  }

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

  void removeImage(int index) {
    setState(() {
      _images.removeAt(index);
    });
  }

  TextEditingController _businessName = TextEditingController();
  TextEditingController _businessEmail = TextEditingController();
  TextEditingController _contactInfo = TextEditingController();
  TextEditingController _address = TextEditingController();
  TextEditingController _description = TextEditingController();
  TextEditingController pincode = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  

  Future<String?> postServices() async {
    print("before try");
    try {
      print("inside try");
      List<String?> cat = _selectedField.split(">");
      String? category = cat[0];
      String? sub_category = cat[1]!.trim();

      final url = Uri.parse("$baseUrl/pg/business");
      // final url = Uri.parse('https://revolution.azurewebsites.net/services');
      // final headers = {'Content-Type': 'application/json'};

      Map<String, String> body = {
        'business_name': _businessName.text,
        'business_description': _businessEmail.text,
        'contact_information': _contactInfo.text,
        'country': "india",
        'catagory': category.toString(),
        'sub_catagory': sub_category.toString(),
        // 'latitude':widget.lat.toString(),
        // 'langitude' : widget.lang.toString()
        // 'image' : _ffsaiImage
      };
      print(" try");

      // final response = await http.post(url, body: body);
      final request = http.MultipartRequest('POST', url)
        ..files.add(await http.MultipartFile.fromPath(
            'profile_image', _profileimage!.path))
        ..fields.addAll(body);
      final response = await request.send();
      print(response.statusCode);
      print(response);
      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        print(responseBody);
        return 'Service created successfully';
      } else {
        throw Exception('Failed to create service');
      }
    } catch (e) {
      print(e.toString());
      throw Exception('Failed to create service: $e');
    } 
  }

  int _activeStepIndex = 0;
  File? _ffsaiImage;
  File? _profileimage;
  File? _aadharfront;
  File? _aadharback;
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

  TextEditingController _serviceEditingController = TextEditingController();

  // String _selectedField = "";
  // String get _selectedField => widget.category ?? "";
  

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
        }
      });
    }
  }

  List<Step> stepList() => [
        Step(
          state: _activeStepIndex <= 0 ? StepState.editing : StepState.complete,
          isActive: _activeStepIndex >= 0,
          title: const Text('Account'),
          content: Column(
            children: [
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
              TypeAheadField(
                textFieldConfiguration: TextFieldConfiguration(
                    controller: _serviceEditingController,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      labelText: "Select a Service",
                      border: OutlineInputBorder(),
                    )),
                suggestionsCallback: (pattern) {
                  if (pattern.isEmpty) {
                    return List<String>.empty();
                  } else {
                    return services.where((service) =>
                        service.toLowerCase().contains(pattern.toLowerCase()));
                  }
                },
                itemBuilder: (context, service) {
                  return ListTile(
                    title: Text(service),
                  );
                },
                onSuggestionSelected: (service) {
                  _serviceEditingController.text = service;
                  List<String> cat = service.split(">");
                  _category = cat[0].trim();
                  _sub_category = cat[1].trim();

                  setState(() {
                    _selectedField = service;
                  });
                  print("this is $_selectedField");
                  print(cat[0]);
                  print(cat[1]);
                },
              ),
              _selectedField != null
                  ? displayServiceField(_selectedField)
                  : Text("no")
            ],
          ),
        ),
        Step(
            state:
                _activeStepIndex <= 1 ? StepState.editing : StepState.complete,
            isActive: _activeStepIndex >= 1,
            title: const Text('Upload Docs'),
            content: Column(
              children: [
                const SizedBox(
                  height: 8,
                ),
                // ............
                Visibility(
                    visible: _sub_category == "Bars",
                    // false,
                    child: Column(
                      children: [
                        const Align(
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
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
                                      child: Image.file(_ffsaiImage!,
                                          fit: BoxFit.fill),
                                    ),
                            ),
                          ],
                        ),
                      ],
                    )),
                // const Align(
                //     alignment: Alignment.topLeft,
                //     child: Text(
                //       "FFSAI Image",
                //       style: TextStyle(fontSize: 23),
                //     )),
                // const SizedBox(
                //   height: 4,
                // ),
                // const Align(
                //     alignment: Alignment.topLeft,
                //     child: Text(
                //       "please upload a govt issued ffsai document for us to varify",
                //       style: TextStyle(color: Colors.grey),
                //     )),
                // const SizedBox(
                //   height: 8,
                // ),
                // Stack(
                //   alignment: AlignmentDirectional.center,
                //   children: [
                //     DottedBorder(
                //         // dashPattern: [1,3],
                //         strokeWidth: 1,
                //         color: Colors.grey,
                //         child: Container(
                //           height: 120,
                //           // color: Colors.grey,
                //         )),
                //     InkWell(
                //       onTap: () {
                //         pickImage(ImageSource.gallery, "_ffsaiImage");
                //       },
                //       child: _ffsaiImage == null
                //           ? DottedBorder(
                //               strokeWidth: 1,
                //               color: Colors.grey,
                //               child: Container(
                //                 color: Colors.blue[50],
                //                 height: 75,
                //                 width: 75,
                //                 child: Column(
                //                     mainAxisAlignment:
                //                         MainAxisAlignment.spaceEvenly,
                //                     // crossAxisAlignment:CrossAxisAlignment.stretch ,
                //                     children: const [
                //                       Icon(Icons.camera_alt),
                //                       Text("Add Photo"),
                //                     ]),
                //               ),
                //             )
                //           : SizedBox(
                //               height: 75,
                //               width: 75,
                //               child: Image.file(_ffsaiImage!, fit: BoxFit.fill),
                //             ),
                //     ),
                //   ],
                // ),
                // ...................
                const SizedBox(
                  height: 13,
                ),
                GestureDetector(
                    onTap: () {
                      // _uploadImages();
                      print(_images);
                      print(_profileimage!.path);
                    },
                    child: Text("click")),
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
                                      child: Image.file(_aadharfront!,
                                          fit: BoxFit.fill),
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
                                    child: Image.file(_aadharback!,
                                        fit: BoxFit.fill),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 19,
                ),
                const Align(
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
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
                              child:
                                  Image.file(_profileimage!, fit: BoxFit.fill),
                            ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                // const Text("ugudsewedu"),
                const Divider(
                  thickness: 2,
                  height: 2,
                ),
                const SizedBox(
                  height: 30,
                ),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
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
            )),
        //   Step(
        //     state: StepState.complete,
        // isActive: _activeStepIndex >= 2,
        // title: const Text('fecities'),
        // content: Text('3')
        //   ),
        Step(
          state: StepState.complete,
          isActive: _activeStepIndex >= 2,
          title: const Text('Confirm'),
          content: Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Business name: ${_businessName.text}'),
                  Text('Business email: ${_businessEmail.text}'),
                  Text('Contact Info: ${_contactInfo.text}'),
                  const Text('Password: *****'),
                  Text('Address : ${_address.text}'),
                  Text('Category: $_category'),
                  Text('Sub Category: $_sub_category'),
                  // Text('Latitude: ${widget.lat }',),
                  // Text('Langitude: ${widget.lang }'),
                  // Text('image name : ${fileName}'),
                  // Text(' : ${.text}'),
                ],
              )),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<RegistrationProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Onboarding Business'),
      ),
      body: SafeArea(
        child: Stepper(
          elevation: 0,
          type: StepperType.horizontal,
          currentStep: _activeStepIndex,
          steps: stepList(),
          onStepContinue: () {
            if (_activeStepIndex < (stepList().length - 1)) {
              setState(() {
                _activeStepIndex += 1;
              });
            } else {
              print('Submited');
              print(_profileimage!.path);
              print("_profileimage");
              // postServices();

              Map<String, dynamic> businessdata = {
                'businessName': _businessName.text,
                'businessEmail': _businessEmail.text,
                'contactInfo': _contactInfo.text,
                'address': _address.text,
                'country': "india",
                'profile_image_url': _profileimage!.path,
                'category': _category,
                'sub_category': _sub_category,
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
              data.updateBusinessData(businessdata);
              navigatorPush(context, SearchLocationScreen());
              // navigatorPush(context, processing());
            }
          },
          onStepCancel: () {
            if (_activeStepIndex == 0) {
              return;
            }

            setState(() {
              _activeStepIndex -= 1;
            });
          },
          onStepTapped: (int index) {
            setState(() {
              _activeStepIndex = index;
            });
          },
          controlsBuilder: (BuildContext, ControlsDetails) {
            final isLastStep = _activeStepIndex == stepList().length - 1;
            return Row(
              children: [
                if (_activeStepIndex > 0)
                  Expanded(
                    child: OutlinedButton(
                        onPressed: ControlsDetails.onStepCancel,
                        child: Text("Back")),
                  ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(tgDarkPrimaryColor),
                    ),
                    onPressed: ControlsDetails.onStepContinue,
                    child: (isLastStep)
                        ? const Text('Submit',
                            style: TextStyle(color: Colors.white))
                        : const Text('Next',
                            style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            );
          },
        ),
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
