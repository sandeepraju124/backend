// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:backendapp/screens/askcommunity.dart';
import 'package:backendapp/screens/home/s1.dart';
import 'package:backendapp/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentGateway extends StatefulWidget {
  const PaymentGateway({super.key});

  @override
  State<PaymentGateway> createState() => _PaymentGatewayState();
}

class _PaymentGatewayState extends State<PaymentGateway> {
  final Razorpay _razorpay = Razorpay();

  @override
  void initState() {
    super.initState();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
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
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Color(0xFFEFF0F7),
        appBar: AppBar(
          title: Text("Payment Gateway"),
          elevation: 10,
        ),
        body: Column(
          children: [
            ElevatedButton(
                onPressed: () {
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
                },
                child: Text("Pay Me")),
            Container(
              margin: EdgeInsets.all(10),
              height: 55,
              decoration: BoxDecoration(
                  color: Color(0xFF292639),
                  borderRadius: BorderRadius.circular(8)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TabBar(
                    // isScrollable: true,
                    dividerColor: Colors.transparent,

                    // isScrollable: true,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorPadding: EdgeInsets.symmetric(horizontal: 12),
                    // indicatorWeight: 4,
                    indicator: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(8)),
                    tabs: [
                      Text(
                        "Ask Community",
                        style: TextStyle(color: Colors.white),
                      ),
                      Text("Comments", style: TextStyle(color: Colors.white)),
                    ]),
              ),
            ),
            Expanded(
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
              children: [
                AskForCommunityWidget(
                          uid: '',
                          Questionid: "",
                        ),
                // Text("first"),
                // Text("second"),
                PaymentPage(),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
