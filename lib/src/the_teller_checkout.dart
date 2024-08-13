library the_teller_checkout;

import 'package:flutter/material.dart';
import 'package:the_teller_checkout/src/browser/inapp_browser.dart';
import 'services/remote_services.dart';

/// A Calculator.
class CheckoutRequest {
  final _service = RemoverServices();
  Future<dynamic> initRequest(BuildContext context,
      {String? email,
      String? redirectUrl,
      String? paymentMethod,
      required String platform,
      required String amount,
      required String description,
      required String apiKeys,
      required String merchantID,
      required String apiUser,
      required String transactionID,


      Color? themeColor}) async {
    dynamic data;
    Map<String, dynamic> body = {
      "merchant_id": merchantID,
      "transaction_id": transactionID,
      "desc": description,
      "amount": amount,
      "redirect_url": redirectUrl ??
          "https://test.theteller.net/checkout/checkout/eU1xSFN5Ky92MUt5dmpnT",
      "email": email,
      "API_Key": apiKeys,
      "apiuser": apiUser,
      "payment_method": paymentMethod??"both",
    };
    await _service
        .initiate(
            platform: platform, apiKey: apiKeys, userApi: apiUser, body: body)
        .then((response) async {
      if (response.status == 'success') {
        // debugPrint(response.checkoutUrl.toString());
       
        data = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => WebViewExample(
                    themeColor: themeColor ?? const Color.fromARGB(255, 26, 3, 144),
                    url: response.checkoutUrl!)));

        // debugPrint("=====================$data");
      }
    });

    return data;
  }
}
