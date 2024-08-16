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
              child: const Text("Pay"),
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
                  transactionID: '000000000051',
                  paymentMethod: "momo",
                  redirectUrl: "https://google.com",
                )
                    .then((value) {
                      print("================================$value---------------");
                  if (value == "Success") {
                    showDialog(
                        context: navigatorKey.currentContext!,
                        builder: (context) {
                          return const AlertDialog(
                            content: Column(
                              // mainAxisSize:,
                              children: [Text("Successful Payment")],
                            ),
                          );
                        });
                  }else if(value != null && value != "Success"){
                     showDialog(
                        context: navigatorKey.currentContext!,
                        builder: (context) {
                          return  AlertDialog(
                            content: Column(
                              // mainAxisSize:,
                              children: [Text("$value")],
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
