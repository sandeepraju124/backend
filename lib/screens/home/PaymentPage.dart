import 'dart:convert';

import 'package:backendapp/provider/businessdata_provider.dart';
import 'package:backendapp/register/profile_screen.dart';
import 'package:backendapp/screens/home/bottomnav.dart';
import 'package:backendapp/screens/redirection.dart';
import 'package:backendapp/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as http;

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final Razorpay _razorpay = Razorpay();
  bool isPremium = false;

  void _togglePremium() {
    setState(() {
      isPremium = !isPremium;
    });
  }

  @override
  void initState() {
    super.initState();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  // void RemoveBusinessUid() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.remove('businessUid');
  // }
  Future<void> RemoveBusinessUid() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('businessUid');
  }

  void _processPayment() {
    var data = Provider.of<BusinessDataProvider>(context, listen: false);
    String email =
        data.BusinessData![0].businessEmail ?? "noemailaddress@gmail.com";
    String phone = data.BusinessData![0].contactInformation ?? "1234567890";

    var options = {
      'key': 'rzp_live_dWg1NHlcZci9lj',
      'amount':
          1000, // Amount in the smallest currency unit (e.g., 5000 paise = INR 50)
      'name': 'NearMe Premium',
      'description': 'Premium Account Payment',
      'prefill': {
        // 'contact': '1234567890',
        'contact': phone,
        // 'email': 'user@example.com'
        'email': email
      },
      'external': {
        'wallets': ['paytm']
      }
    };

    _razorpay.open(options);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isPremium', true);

    setState(() {
      isPremium = true;
    });

    // Update the database
    // final businessId = await prefs.getString('businessUid');
    String businessUid = await getBusinessUid(context);

    if (businessUid != null) {
      Map<String, dynamic> updatedData = {
        'business_uid': businessUid,
        'is_premium': true,
        'premium_expiry':
            DateTime.now().add(Duration(days: 10)).toIso8601String(),
      };
      print(updatedData);

      bool response =
          await Provider.of<BusinessDataProvider>(context, listen: false)
              .updateBusinessData(updatedData);
      if (response) {
        showSnackBar(context, "Payment successful! You are now a premium user");
        // Navigator.pop(context);
      } else {
        showSnackBar(
            context, "Failed to update premium status in the database.");
      }
    }
  }
  // void _handlePaymentSuccess(PaymentSuccessResponse response) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setBool('isPremium', true);

  //   setState(() {
  //     isPremium = true;
  //   });

  //   // Update the database
  //   final businessId = await prefs.getString('businessUid');

  //   if (businessId != null) {
  //     final response = await http.post(
  //       Uri.parse('https://your-api-endpoint.com/updatePremiumStatus'),
  //       body: jsonEncode({
  //         'businessId': businessId,
  //         'isPremium': true,
  //         'premiumExpiry': DateTime.now().add(Duration(days: 10)).toIso8601String(),
  //       }),
  //       headers: {'Content-Type': 'application/json'},
  //     );

  //     if (response.statusCode == 200) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text("Payment successful! You are now a premium user.")),
  //       );
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text("Failed to update premium status in the database.")),
  //       );
  //     }
  //   }
  // }

  void _handlePaymentError(PaymentFailureResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Payment failed. Please try again.")),
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("External wallet selected.")),
    );
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<BusinessDataProvider>(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Premium Account',
          style: TextStyle(fontSize: 18.8, fontWeight: FontWeight.w500),
        ),
        backgroundColor: tgDarkPrimaryColor,
        actions: [
          IconButton(
            onPressed: () {
              _scaffoldKey.currentState?.openEndDrawer();
            },
            icon: Icon(Icons.menu_rounded),
          )
        ],
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: tgDarkPrimaryColor,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text(
                'Home',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return BottomNav(
                    initialIndex: 0,
                  );
                }));
              },
            ),
            ListTile(
              leading: Icon(Icons.supervised_user_circle_rounded),
              title: Text(
                'Your Business Profile',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return BottomNav(
                    initialIndex: 2,
                  );
                }));
              },
            ),
            ListTile(
              leading: Icon(Icons.business_center_rounded),
              title: Text(
                'Add Another Business',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ProfileScreen(
                      showBackButton: true, showlogoutbutton: false);
                }));
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text(
                'Settings',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
              onTap: () {
                // Navigate to settings
              },
            ),
            ListTile(
              leading: Icon(Icons.logout_rounded),
              title: Text(
                'Logout',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: tgTextIcon,
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        "Are you sure you wanna logout",
                        style: TextStyle(fontSize: 16, letterSpacing: 0.2),
                      ),
                      actions: [
                        MaterialButton(
                          // color: tgLightPrimaryColor,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'No!',
                            style: TextStyle(color: tgPrimaryColor),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: MaterialButton(
                            // color: tgLightPrimaryColor,
                            onPressed: () async {
                              await FirebaseAuth.instance.signOut();
                              await RemoveBusinessUid();
                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => redirection()),
                                (Route<dynamic> route) => false,
                              );
                            },
                            child: Text(
                              'Yes, logout',
                              style: TextStyle(color: tgPrimaryColor),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Unlock premium features for your business!',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              (data.BusinessData != null &&
                        data.BusinessData!.isNotEmpty) ?ListTile(
                // splashColor: Colors.deepPurple,
                tileColor: Colors.green[50],
                title: Text('Premium Account'),
                subtitle: (data.BusinessData != null &&
                        data.BusinessData!.isNotEmpty)
                    ? (data.BusinessData![0].isPremium
                        ? Text('You currently have a premium account.')
                        : Text(
                            'Upgrade to a premium account for additional benefits.'))
                    : Text('No business data available.'),
                // data.BusinessData![0].isPremium
                //     ? Text('You currently have a premium account.')
                //     : Text(
                //         'Upgrade to a premium account for additional benefits.'),
                trailing: ElevatedButton(
                  style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all(tgLightPrimaryColor),
                        ),
                  onPressed: _togglePremium,
                  child: data.BusinessData![0].isPremium
                      ? Text('Downgrade')
                      : Text('Upgrade'),
                ),
              ): Text("No Business Data Available"),
              SizedBox(height: 20),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(tgLightPrimaryColor),
                ),
                onPressed: () {
                  // ScaffoldMessenger.of(context).showSnackBar(
                  //   SnackBar(content: Text("Feature not available yet")
                  //   ),
                  // );
                  data.BusinessData![0].isPremium == true
                      ? showSnackBar(context, "You are already a premium user")
                      : _processPayment();
                  //  _processPayment();
                },
                child: Text('Pay Now'),
              ),
              SizedBox(height: 20),
              Text(
                'Premium Benefits:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              _buildPremiumBenefit('Increased Visibility',
                  'Enhance your business visibility and stand out among competitors on the platform.'),
              _buildPremiumBenefit('Featured Listings',
                  'Enjoy the benefits of having a featured or sponsored listing, ensuring your business is prominently displayed to users.'),
              _buildPremiumBenefit('Analytics and Insights',
                  'Unlock valuable analytics and insights about user engagement, helping you make informed decisions to improve your services.'),
              _buildPremiumBenefit('Priority Customer Support',
                  'Receive priority customer support, ensuring quicker resolutions to any issues you may encounter.'),
              _buildPremiumBenefit('Ad-Free Experience',
                  'Enjoy an ad-free experience for your business, providing a more seamless and professional interaction with potential customers.'),
              _buildPremiumBenefit('Special Promotions',
                  'Access to exclusive promotions and deals that can help attract more customers to your business.'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPremiumBenefit(String title, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Text(
            description,
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
