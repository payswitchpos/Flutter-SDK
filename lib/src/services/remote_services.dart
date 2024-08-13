import 'dart:convert';

import  'package:http/http.dart' as http ;
import 'package:the_teller_checkout/src/model/model.dart';


const initUrl ='https://checkout-test.theteller.net/initiate';
const initUrlLive ='https://checkout.theteller.net/initiate';
class RemoverServices {
  Future<InitModel> initiate(
      {required String apiKey,
      required String userApi,required String platform,
      Map<String, dynamic>? body}) async {
    String basicAuth =
        'Basic ${base64.encode(utf8.encode('$userApi:$apiKey'))}';
    InitModel responseData = InitModel();
    await http.post(
        Uri.parse(
         platform.toLowerCase() == 'pro'? initUrlLive : initUrl,
        ),
        body: jsonEncode(body),
        headers: <String, String>{
          'authorization': basicAuth,
          "Content-Type": "application/json",
        }).then((value) {
      var decodedResponse = json.decode(value.body);
      // debugPrint(decodedResponse.toString());
      if (decodedResponse['code'] == 200) {
        responseData = InitModel.fromJson(decodedResponse);
      }
    });
    return responseData;
  }
}
