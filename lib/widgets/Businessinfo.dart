import 'package:flutter/material.dart';


class BasicInfoForm extends StatefulWidget {
  @override
  _BasicInfoFormState createState() => _BasicInfoFormState();
}

class _BasicInfoFormState extends State<BasicInfoForm> {
  final TextEditingController businessNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController websiteLinkController = TextEditingController();
  final TextEditingController menuLinksController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text("Basic Info"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
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
                decoration: InputDecoration(
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
              onPressed: () {
                // You can submit the form data here
                String businessName = businessNameController.text;
                String phoneNumber = phoneNumberController.text;
                String websiteLink = websiteLinkController.text;
                String menuLinks = menuLinksController.text;

                // Print or process the form data as needed
                print("Business Name: $businessName");
                print("Phone Number: $phoneNumber");
                print("Website Link: $websiteLink");
                print("Menu Links: $menuLinks");
              },
              child: Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    businessNameController.dispose();
    phoneNumberController.dispose();
    websiteLinkController.dispose();
    menuLinksController.dispose();
    super.dispose();
  }
}
