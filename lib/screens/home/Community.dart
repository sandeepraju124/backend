// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:backendapp/provider/askcommunityprovider.dart';
import 'package:backendapp/provider/commentprovider.dart';
import 'package:backendapp/screens/askcommunity.dart';
import 'package:backendapp/screens/commentsection/showreviews.dart';
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

  Future<void> _refreshAsk() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? businessUid = prefs.getString('businessUid');
    print("Business_uid = $businessUid");
    print("refreshing ask community");
    // var commentsData = Provider.of<CommentSectionProvider>(context, listen: false).commentSectionProvider(businessUid);
    var askCommData = Provider.of<AskCommunityProvider>(context, listen: false)
        .fetchAskCommunityData(businessUid!);
  }

  Future<void> _refreshComments() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? businessUid = prefs.getString('businessUid');
    print("Business_uid = $businessUid");
    print("refreshing comments");
    var commentsData =
        Provider.of<CommentSectionProvider>(context, listen: false)
            .commentSectionProvider(businessUid);
    // var askCommData = Provider.of<AskCommunityProvider>(context, listen: false).fetchAskCommunityData(businessUid!);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Color(0xFFEFF0F7),
        appBar: AppBar(
          backgroundColor: tgPrimaryColor,
          title: Text(
            "Community Discussion",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
          ),
          elevation: 20,
        ),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 20),
              height: 41.4,
              child: Stack(
                children: [
                  TabBar(
                    dividerColor: Colors.transparent,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorPadding: EdgeInsets.symmetric(horizontal: 12),
                    indicator: BoxDecoration(
                      // color: Colors.blue.shade700,
                      color: Colors.teal[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    tabs: [
                      Tab(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            "Ask Community",
                            style: TextStyle(color: Colors.black87),
                          ),
                        ),
                      ),
                      Tab(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            "Comments",
                            style: TextStyle(color: Colors.black87),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Center(
                    child: VerticalDivider(
                      color: Colors.black.withOpacity(0.5),
                      thickness: 1.3,
                      width: 1,
                      indent: 10,
                      endIndent: 10,
                    ),
                  ),
                ],
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
                  RefreshIndicator(
                    onRefresh: _refreshComments,
                    child: NewShowRewviewPage(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
