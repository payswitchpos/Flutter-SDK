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
                  transactionID: '000000000056',
                  paymentMethod: "both",
                  redirectUrl: "https://google.com",
                )
                    .then((value) {
        
                  if (value == "Success") {
                    showDialog(
                        context: navigatorKey.currentContext!,
                        builder: (context) {
                          return const AlertDialog(
                            content: Column(
                              mainAxisSize:MainAxisSize.min,
                              // mainAxisSize:,
                              children: [Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text("Successful Payment"),
                              )],
                            ),
                          );
                        });
                  } else if (value != null && value != "Success") {
                    showDialog(
                        context: navigatorKey.currentContext!,
                        builder: (context) {
                          return AlertDialog(
                            content: Column(
                              mainAxisSize:MainAxisSize.min,
                              children: [Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text("$value"),
                              )],
                            ),
                          );
                        });
                  }
                });
              },
            ),
          ),
        ));
  }
}
