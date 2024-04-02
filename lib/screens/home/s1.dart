// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final Razorpay _razorpay = Razorpay();
  bool isPremium = false;

  void _togglePremium() {
    setState(() {
      isPremium = !isPremium;
    });
  }

  void _processPayment() {
    // Add your payment processing logic here
    // This could involve integrating with a payment gateway
    // and handling the response accordingly.
    print('Processing payment...');
    var options = {
      'key': 'rzp_test_mtmrHL6yjG7sVJ',
      'amount': 1 * 100,
      'name': 'SSSV1',
      'description': 'Fine T-Shirt',
      // 'prefill': {
      //   'contact': '8888888888',
      //   'email': 'test@razorpay.com'
      // }
    };
    _razorpay.open(options);
  }

  @override
  void initState() {
    super.initState();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    print("succeeds");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    print("fails");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
    print("external wallet");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Premium Account'),
        actions: [
          IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: Icon(Icons.menu))
        ],
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
              ListTile(
                title: Text('Premium Account'),
                subtitle: isPremium
                    ? Text('You currently have a premium account.')
                    : Text(
                        'Upgrade to a premium account for additional benefits.'),
                trailing: ElevatedButton(
                  onPressed: _togglePremium,
                  child: isPremium ? Text('Downgrade') : Text('Upgrade'),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _processPayment,
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
      drawer: Drawer(
        width: double.infinity,
        child: Text("hdhdh")),
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
