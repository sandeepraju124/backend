// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:backendapp/provider/askcommunityprovider.dart';
import 'package:backendapp/provider/commentprovider.dart';
import 'package:backendapp/screens/askcommunity.dart';
import 'package:backendapp/screens/commentsection/showreviews.dart';
import 'package:backendapp/screens/home/s1.dart';
import 'package:backendapp/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Community extends StatefulWidget {
  const Community({super.key});

  @override
  State<Community> createState() => _CommunityState();
}

class _CommunityState extends State<Community> {


  // @override
  // void initState() {
  //   super.initState();
  //   _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
  //   _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
  //   _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  // }

  Future<void> _refreshAsk()async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? businessUid = prefs.getString('businessUid');
    print("Business_uid = $businessUid");
    print("refreshing ask community");
    // var commentsData = Provider.of<CommentSectionProvider>(context, listen: false).commentSectionProvider(businessUid);
    var askCommData = Provider.of<AskCommunityProvider>(context, listen: false).fetchAskCommunityData(businessUid!);

  }
  Future<void> _refreshComments()async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? businessUid = prefs.getString('businessUid');
    print("Business_uid = $businessUid");
    print("refreshing comments");
    var commentsData = Provider.of<CommentSectionProvider>(context, listen: false).commentSectionProvider(businessUid);
    // var askCommData = Provider.of<AskCommunityProvider>(context, listen: false).fetchAskCommunityData(businessUid!);

  }

  
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Color(0xFFEFF0F7),
        appBar: AppBar(
          // backgroundColor: tgAccentColor,
          title: Text("Community Discussion"),
          elevation: 10,
        ),
        body: Column(
          children: [
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
                RefreshIndicator(
                   onRefresh: _refreshAsk,
                  child: AskForCommunityWidget(
                            uid: '',
                            Questionid: "",
                          ),
                ),
                // Text("first"),
                // Text("second"),
                // PaymentPage(),
                RefreshIndicator(
                  onRefresh: _refreshComments,
                  child: NewShowRewviewPage())
              ],
            ))
          ],
        ),
      ),
    );
  }
}
