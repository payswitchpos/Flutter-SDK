import 'package:example/constants.dart';
import 'package:flutter/material.dart';
import 'package:the_teller_checkout/init_request.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final chec = CheckoutRequest();

  final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        navigatorKey: navigatorKey,
        home: Scaffold(
          body: Center(
            child: GestureDetector(
              child: Text("Pay"),
              onTap: () async {
                await chec
                    .initRequest(
                  navigatorKey.currentContext!,
                  platform: 'pro',
                  amount: '000000000010',
                  apiKeys: kApiKeys,
                  apiUser: kApiUser,
                  description: 'Hello',
                  email: 'theteller@payswitch.com.gh',
                  merchantID: kmerchantId,
                  transactionID: '000000000052',
                  paymentMethod: "card",
                  redirectUrl: "https://google.com",
                )
                    .then((value) {
                  // final snackBar = SnackBar(
                  //   content: Text(value),
                  // );
                });
              },
            ),
          ),
        ));
  }
}
