// ignore_for_file: prefer_const_constructors

import 'package:backendapp/models/businessdata_models.dart';
import 'package:backendapp/provider/businessdata_provider.dart';
import 'package:backendapp/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BasicInfoForm extends StatefulWidget {
  @override
  _BasicInfoFormState createState() => _BasicInfoFormState();
}

class _BasicInfoFormState extends State<BasicInfoForm> {

  final TextEditingController businessNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController websiteLinkController = TextEditingController();
  final TextEditingController menuLinksController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
     var data = Provider.of<BusinessDataProvider>(context,listen: false);
     businessNameController.text = data.BusinessData![0].businessName ?? '';
    addressController.text = data.BusinessData![0].address ?? '';
    phoneNumberController.text = data.BusinessData![0].contactInformation ?? '';
    // websiteLinkController.text = data.BusinessData[0]. ?? '';
    // menuLinksController.text = data.BusinessData[0]. ?? '';

     

    super.initState();
  }
  
  

  // @override
  // void dispose() {
  //   businessNameController.dispose();
  //   phoneNumberController.dispose();
  //   websiteLinkController.dispose();
  //   menuLinksController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<BusinessDataProvider>(context);
    

    // Set initial values if available
    // businessNameController.text = data.BusinessData![0].businessName ?? '';
    // addressController.text = data.BusinessData![0].address ?? '';
    // phoneNumberController.text = data.BusinessData![0].contactInformation ?? '';
    // websiteLinkController.text = data.BusinessData[0]. ?? '';
    // menuLinksController.text = data.BusinessData[0]. ?? '';



    return Scaffold(
      // backgroundColor: Colors.grey[100],
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Basic Info"),
        toolbarHeight: 80,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: TextFormField(
                  controller: businessNameController,
                  decoration: const InputDecoration(
                    labelText: "Business name",
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(8.0),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: TextFormField(
                  controller: addressController,
                  decoration: InputDecoration(
                    labelText: "Address",
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(8.0),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: TextFormField(
                  controller: phoneNumberController,
                  decoration: InputDecoration(
                    labelText: "Phone number",
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(8.0),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: TextFormField(
                  controller: websiteLinkController,
                  decoration: InputDecoration(
                    labelText: "Website link (Optional)",
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(8.0),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: TextFormField(
                  controller: menuLinksController,
                  decoration: InputDecoration(
                    labelText: "Menu links (Optional)",
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(8.0),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
          
                  // Print or process the form data as needed
                  print("Business Name: ${businessNameController.text}");
                  print("Phone Number: ${phoneNumberController.text}");
                  print("Website Link: ${websiteLinkController.text}");
                  print("Menu Links: ${menuLinksController.text}");
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  String? businessUid = prefs.getString('businessUid');
          
                  Map<String, dynamic> updatedData = {
                    'business_uid': businessUid,
                    'business_name': businessNameController.text,
                    'address': addressController.text,
                    'contact_information': phoneNumberController.text,
                    // 'websiteLink': websiteLinkController.text,
                    // 'menuLinks': menuLinks,
                  };
          
                  // Call the update method from the provider
                  bool response = await Provider.of<BusinessDataProvider>(context, listen: false)
                      .updateBusinessData(updatedData);
                      if (response){
                        showSnackBar(context,"Profile Updated Sucessfully" );
                        Navigator.pop(context);
                      }
                      // Navigator.pop(context);
                },
                child: data.isLoadingPatch ? CircularProgressIndicator(): Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
