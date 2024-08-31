// // // ignore_for_file: prefer_const_constructors

// // import 'package:backendapp/models/businessdata_models.dart';
// // import 'package:backendapp/provider/businessdata_provider.dart';
// // import 'package:backendapp/utils/constants.dart';
// // import 'package:flutter/material.dart';
// // import 'package:provider/provider.dart';
// // import 'package:shared_preferences/shared_preferences.dart';

// // class BasicInfoForm extends StatefulWidget {
// //   @override
// //   _BasicInfoFormState createState() => _BasicInfoFormState();
// // }

// // class _BasicInfoFormState extends State<BasicInfoForm> {
// //   final TextEditingController businessNameController = TextEditingController();
// //   final TextEditingController businessEmailController = TextEditingController();
// //   final TextEditingController phoneNumberController = TextEditingController();
// //   final TextEditingController websiteLinkController = TextEditingController();
// //   final TextEditingController menuLinksController = TextEditingController();
// //   final TextEditingController addressController = TextEditingController();
// //   @override
// //   void initState() {
// //     // TODO: implement initState
// //     var data = Provider.of<BusinessDataProvider>(context, listen: false);
// //     businessNameController.text = data.BusinessData![0].businessName ?? '';
// //     businessEmailController.text = data.BusinessData![0].businessEmail ?? '';
// //     addressController.text = data.BusinessData![0].address ?? '';
// //     phoneNumberController.text = data.BusinessData![0].contactInformation ?? '';
// //     // websiteLinkController.text = data.BusinessData[0]. ?? '';
// //     // menuLinksController.text = data.BusinessData[0]. ?? '';

// //     super.initState();
// //   }

// //   // @override
// //   // void dispose() {
// //   //   businessNameController.dispose();
// //   //   phoneNumberController.dispose();
// //   //   websiteLinkController.dispose();
// //   //   menuLinksController.dispose();
// //   //   super.dispose();
// //   // }

// //   @override
// //   Widget build(BuildContext context) {
// //     var data = Provider.of<BusinessDataProvider>(context);

// //     // Set initial values if available
// //     // businessNameController.text = data.BusinessData![0].businessName ?? '';
// //     // addressController.text = data.BusinessData![0].address ?? '';
// //     // phoneNumberController.text = data.BusinessData![0].contactInformation ?? '';
// //     // websiteLinkController.text = data.BusinessData[0]. ?? '';
// //     // menuLinksController.text = data.BusinessData[0]. ?? '';

// //     return Scaffold(
// //       // backgroundColor: Colors.grey[100],
// //       backgroundColor: Colors.white,
// //       appBar: AppBar(
// //         backgroundColor: Colors.white,
// //         title: Text("Basic Info"),
// //         toolbarHeight: 80,
// //       ),
// //       body: Padding(
// //         padding: EdgeInsets.all(16.0),
// //         child: SingleChildScrollView(
// //           child: Column(
// //             children: [
// //               Container(
// //                 decoration: BoxDecoration(
// //                   color: Colors.white,
// //                   border: Border.all(color: Colors.grey),
// //                   borderRadius: BorderRadius.circular(5.0),
// //                 ),
// //                 child: TextFormField(
// //                   controller: businessNameController,
// //                   decoration: const InputDecoration(
// //                     labelText: "Business name",
// //                     border: InputBorder.none,
// //                     contentPadding: EdgeInsets.all(8.0),
// //                   ),
// //                 ),
// //               ),
// //               SizedBox(height: 16.0),
// //               Container(
// //                 decoration: BoxDecoration(
// //                   color: Colors.white,
// //                   border: Border.all(color: Colors.grey),
// //                   borderRadius: BorderRadius.circular(5.0),
// //                 ),
// //                 child: TextFormField(
// //                   controller: businessEmailController,
// //                   decoration: const InputDecoration(
// //                     labelText: "Business email",
// //                     border: InputBorder.none,
// //                     contentPadding: EdgeInsets.all(8.0),
// //                   ),
// //                 ),
// //               ),
// //               SizedBox(height: 16.0),
// //               Container(
// //                 decoration: BoxDecoration(
// //                   color: Colors.white,
// //                   border: Border.all(color: Colors.grey),
// //                   borderRadius: BorderRadius.circular(5.0),
// //                 ),
// //                 child: TextFormField(
// //                   controller: addressController,
// //                   decoration: InputDecoration(
// //                     labelText: "Address",
// //                     border: InputBorder.none,
// //                     contentPadding: EdgeInsets.all(8.0),
// //                   ),
// //                 ),
// //               ),
// //               SizedBox(height: 16.0),
// //               Container(
// //                 decoration: BoxDecoration(
// //                   color: Colors.white,
// //                   border: Border.all(color: Colors.grey),
// //                   borderRadius: BorderRadius.circular(5.0),
// //                 ),
// //                 child: TextFormField(
// //                   controller: phoneNumberController,
// //                   decoration: InputDecoration(
// //                     labelText: "Phone number",
// //                     border: InputBorder.none,
// //                     contentPadding: EdgeInsets.all(8.0),
// //                   ),
// //                 ),
// //               ),
// //               SizedBox(height: 16.0),
// //               Container(
// //                 decoration: BoxDecoration(
// //                   color: Colors.white,
// //                   border: Border.all(color: Colors.grey),
// //                   borderRadius: BorderRadius.circular(5.0),
// //                 ),
// //                 child: TextFormField(
// //                   controller: websiteLinkController,
// //                   decoration: InputDecoration(
// //                     labelText: "Website link (Optional)",
// //                     border: InputBorder.none,
// //                     contentPadding: EdgeInsets.all(8.0),
// //                   ),
// //                 ),
// //               ),
// //               SizedBox(height: 16.0),
// //               Container(
// //                 decoration: BoxDecoration(
// //                   color: Colors.white,
// //                   border: Border.all(color: Colors.grey),
// //                   borderRadius: BorderRadius.circular(5.0),
// //                 ),
// //                 child: TextFormField(
// //                   controller: menuLinksController,
// //                   decoration: InputDecoration(
// //                     labelText: "Menu links (Optional)",
// //                     border: InputBorder.none,
// //                     contentPadding: EdgeInsets.all(8.0),
// //                   ),
// //                 ),
// //               ),
// //               SizedBox(height: 16.0),
// //               ElevatedButton(
// //                 onPressed: () async {
// //                   // Print or process the form data as needed
// //                   print("Business Name: ${businessNameController.text}");
// //                   print("Phone Number: ${phoneNumberController.text}");
// //                   print("Website Link: ${websiteLinkController.text}");
// //                   print("Menu Links: ${menuLinksController.text}");
// //                   SharedPreferences prefs =
// //                       await SharedPreferences.getInstance();
// //                   String? businessUid = prefs.getString('businessUid');

// //                   Map<String, dynamic> updatedData = {
// //                     'business_uid': businessUid,
// //                     'business_name': businessNameController.text,
// //                     'address': addressController.text,
// //                     'contact_information': phoneNumberController.text,
// //                     'business_email': businessEmailController.text,
// //                     // 'websiteLink': websiteLinkController.text,
// //                     // 'menuLinks': menuLinks,
// //                   };

// //                   // Call the update method from the provider
// //                   bool response = await Provider.of<BusinessDataProvider>(
// //                           context,
// //                           listen: false)
// //                       .updateBusinessData(updatedData);
// //                   if (response) {
// //                     showSnackBar(context, "Profile Updated Sucessfully");
// //                     Navigator.pop(context);
// //                   }
// //                   // Navigator.pop(context);
// //                 },
// //                 child: data.isLoadingPatch
// //                     ? CircularProgressIndicator()
// //                     : Text("Submit"),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'package:backendapp/models/businessdata_models.dart';
// import 'package:backendapp/provider/businessdata_provider.dart';
// import 'package:backendapp/utils/constants.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class BasicInfoForm extends StatefulWidget {
//   @override
//   _BasicInfoFormState createState() => _BasicInfoFormState();
// }

// class _BasicInfoFormState extends State<BasicInfoForm> {
//   final TextEditingController businessNameController = TextEditingController();
//   final TextEditingController businessEmailController = TextEditingController();
//   final TextEditingController phoneNumberController = TextEditingController();
//   final TextEditingController websiteLinkController = TextEditingController();
//   final TextEditingController menuLinksController = TextEditingController();
//   final TextEditingController addressController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();

//   @override
//   void initState() {
//     super.initState();
//     var data = Provider.of<BusinessDataProvider>(context, listen: false);
//     businessNameController.text = data.BusinessData![0].businessName ?? '';
//     businessEmailController.text = data.BusinessData![0].businessEmail ?? '';
//     addressController.text = data.BusinessData![0].address ?? '';
//     phoneNumberController.text = data.BusinessData![0].contactInformation ?? '';
//   }

//   @override
//   void dispose() {
//     businessNameController.dispose();
//     businessEmailController.dispose();
//     phoneNumberController.dispose();
//     websiteLinkController.dispose();
//     menuLinksController.dispose();
//     addressController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     var data = Provider.of<BusinessDataProvider>(context);

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         title: Text("Basic Info", style: TextStyle(color: Colors.black)),
//         iconTheme: IconThemeData(color: Colors.black),
//         elevation: 0,
//         toolbarHeight: 80,
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: ListView(
//             children: [
//               _buildTextField(
//                 controller: businessNameController,
//                 label: "Business Name",
//                 icon: Icons.business,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter the business name';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 16.0),
//               _buildTextField(
//                 controller: businessEmailController,
//                 label: "Business Email",
//                 icon: Icons.email,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter the business email';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 16.0),
//               _buildTextField(
//                 controller: addressController,
//                 label: "Address",
//                 icon: Icons.location_on,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter the address';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 16.0),
//               _buildTextField(
//                 controller: phoneNumberController,
//                 label: "Phone Number",
//                 icon: Icons.phone,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter the phone number';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 16.0),
//               _buildTextField(
//                 controller: websiteLinkController,
//                 label: "Website Link (Optional)",
//                 icon: Icons.link,
//               ),
//               SizedBox(height: 16.0),
//               _buildTextField(
//                 controller: menuLinksController,
//                 label: "Menu Links (Optional)",
//                 icon: Icons.menu_book,
//               ),
//               SizedBox(height: 24.0),
//               ElevatedButton(
//                 onPressed: () async {
//                   if (_formKey.currentState!.validate()) {
//                     SharedPreferences prefs =
//                         await SharedPreferences.getInstance();
//                     String? businessUid = prefs.getString('businessUid');

//                     Map<String, dynamic> updatedData = {
//                       'business_uid': businessUid,
//                       'business_name': businessNameController.text,
//                       'address': addressController.text,
//                       'contact_information': phoneNumberController.text,
//                       'business_email': businessEmailController.text,
//                     };

//                     bool response = await Provider.of<BusinessDataProvider>(
//                             context,
//                             listen: false)
//                         .updateBusinessData(updatedData);
//                     if (response) {
//                       showSnackBar(context, "Profile Updated Successfully");
//                       Navigator.pop(context);
//                     }
//                   }
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: tgAccentColor,
//                   padding: EdgeInsets.symmetric(vertical: 16.0),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10.0),
//                   ),
//                 ),
//                 child: data.isLoadingPatch
//                     ? CircularProgressIndicator(
//                         valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//                       )
//                     : Text("Submit", style: TextStyle(fontSize: 16)),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildTextField({
//     required TextEditingController controller,
//     required String label,
//     required IconData icon,
//     String? Function(String?)? validator,
//   }) {
//     return Card(
//       elevation: 2,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10.0),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 8.0),
//         child: TextFormField(
//           controller: controller,
//           decoration: InputDecoration(
//             labelText: label,
//             prefixIcon: Icon(icon),
//             border: InputBorder.none,
//           ),
//           validator: validator,
//         ),
//       ),
//     );
//   }
// }

// void showSnackBar(BuildContext context, String message) {
//   ScaffoldMessenger.of(context).showSnackBar(
//     SnackBar(
//       content: Text(message),
//       backgroundColor: Colors.black54,
//       behavior: SnackBarBehavior.floating,
//     ),
//   );
// }

import 'package:backendapp/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:backendapp/provider/businessdata_provider.dart';

class BasicInfoForm extends StatefulWidget {
  @override
  _BasicInfoFormState createState() => _BasicInfoFormState();
}

class _BasicInfoFormState extends State<BasicInfoForm> {
  final TextEditingController businessNameController = TextEditingController();
  final TextEditingController businessEmailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController websiteLinkController = TextEditingController();
  final TextEditingController menuLinksController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    var data = Provider.of<BusinessDataProvider>(context, listen: false);
    businessNameController.text = data.BusinessData![0].businessName ?? '';
    businessEmailController.text = data.BusinessData![0].businessEmail ?? '';
    addressController.text = data.BusinessData![0].address ?? '';
    phoneNumberController.text = data.BusinessData![0].contactInformation ?? '';
  }

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<BusinessDataProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: tgPrimaryColor,
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.keyboard_arrow_left_rounded)),
        title: Text("Basic Info",
            style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w600)),
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        toolbarHeight: 80,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildTextField(
                controller: businessNameController,
                label: "Business Name",
                icon: Icons.business,
                isRequired: true,
              ),
              SizedBox(height: 16.0),
              _buildTextField(
                controller: businessEmailController,
                label: "Business Email",
                icon: Icons.email,
                isRequired: true,
              ),
              SizedBox(height: 16.0),
              _buildTextField(
                controller: addressController,
                label: "Address",
                icon: Icons.location_on,
                isRequired: true,
              ),
              SizedBox(height: 16.0),
              _buildTextField(
                controller: phoneNumberController,
                label: "Phone Number",
                icon: Icons.phone,
                isRequired: true,
              ),
              SizedBox(height: 16.0),
              _buildTextField(
                controller: websiteLinkController,
                label: "Website Link (Optional)",
                icon: Icons.link,
              ),
              SizedBox(height: 16.0),
              _buildTextField(
                controller: menuLinksController,
                label: "Menu Links (Optional)",
                icon: Icons.menu_book,
              ),
              SizedBox(height: 24.0),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      String? businessUid = prefs.getString('businessUid');

                      Map<String, dynamic> updatedData = {
                        'business_uid': businessUid,
                        'business_name': businessNameController.text,
                        'address': addressController.text,
                        'contact_information': phoneNumberController.text,
                        'business_email': businessEmailController.text,
                      };

                      bool response = await Provider.of<BusinessDataProvider>(
                              context,
                              listen: false)
                          .updateBusinessData(updatedData);
                      if (response) {
                        showSnackBar(context, "Profile Updated Successfully");
                        Navigator.pop(context);
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: data.isLoadingPatch
                      ? SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                            strokeWidth: 2.0,
                          ),
                        )
                      : Text("Submit",
                          style: TextStyle(fontSize: 16, color: Colors.black)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final _formKey = GlobalKey<FormState>();

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool isRequired = false,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            prefixIcon: Icon(icon),
            border: InputBorder.none,
            labelStyle: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500),
            errorStyle: TextStyle(color: Colors.redAccent, fontSize: 14.0),
          ),
          validator: isRequired
              ? (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter $label';
                  }
                  return null;
                }
              : null,
        ),
      ),
    );
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.black54,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
