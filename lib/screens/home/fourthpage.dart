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
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment Gateway"),
        elevation: 10,
      ),
      body: Center(
          child: ElevatedButton(
              onPressed: () {
                var options = {
                  'key': 'rzp_test_mtmrHL6yjG7sVJ',
                  'amount': 1*100,
                  'name': 'SSSV1',
                  'description': 'Fine T-Shirt',
                  // 'prefill': {
                  //   'contact': '8888888888',
                  //   'email': 'test@razorpay.com'
                  // }
                };
                _razorpay.open(options);
              },
              child: Text("Pay Me"))),
    );
  }
}
