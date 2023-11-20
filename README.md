# :credit_card: TheTella Checkout Plugin for Flutter

A Flutter plugin for making payments via Paystack Payment Gateway. Fully
supports Android and iOS.

## :rocket: Installation
To use this plugin, add 
  
1.  the_teller_checkout:
    git:
      url: https://github.com/mccamo51/the_teller_checkout.git
  

2. http: ^0.13.6
3. webview_flutter: ^4.2.0



No other configuration required&mdash;the plugin works out of the box.

### 1. Create an instance of the class CheckoutRequest();
`Example:   final checkout= CheckoutRequest();`



### 2. :star: Initiate transaction
`Call the initRequest function and pass the required parameters`

            checkout.initRequest(context,
                                platform: 'pro',
                                amount: '000000000010',
                                apiKeys: "##############",
                                apiUser: "##############",
                                description: 'Hello',
                                email: 'theteller@payswitch.com.gh',
                                merchsntID: kmerchantId,
                                transactionID: '000000000052')

You can choose to initialize the payment locally or via your backend.

#### A. Initialize Via Your Backend (Recommended)

1.a. This starts by making a HTTP POST request to
<!-- [paystack](https://developers.paystack.co/reference#initialize-a-transaction) -->
on your backend.

1.b If everything goes well, the initialization request returns a response with an `access_code`.
You can then create a `Charge` object with the access code and card details. The `charge` is in turn passed to the `plugin.chargeCard()` function for payment:

```dart
  CheckoutRequest  checkout = CheckoutRequest();
  
          
   checkout.initRequest(
             context,
             platform: 'pro',
             amount: '000000000010',
             apiKeys: "##############",
             apiUser: "##############",
             description: 'Hello',
             email: 'theteller@payswitch.com.gh',
             merchsntID: kmerchantId,
             transactionID: '000000000052',
             );

 
```
The transaction is successful if `response.status` is 000. Please, see the documentation 
of [CheckoutResponse](https://theteller.net/documentation)
for more information. 



<!-- #### 2. Initialize Locally
Just send the payment details to  `plugin.chargeCard`
```dart
      // Set transaction params directly in app (note that these params
      // are only used if an access_code is not set. In debug mode,
      // setting them after setting an access code would throw an error
      Charge charge = Charge();
      charge.card = _getCardFromUI();
      charge
        ..amount = 2000
        ..email = 'user@email.com'
        ..reference = _getReference()
        ..putCustomField('Charged From', 'Flutter PLUGIN');
      _chargeCard();
``` -->



## :helicopter: Testing your implementation
Payswitch provides tons of [payment cards](https://theteller.net/documentation) for testing.

## :arrow_forward: Running Example project
For help getting started with Flutter, view the online [documentation](https://flutter.io/).

An [example project](https://github.com/mccamo51/the_teller_checkout/tree/master/example) has been provided in this plugin.
Clone this repo and navigate to the **example** folder. Open it with a supported IDE or execute `flutter run` from that folder in terminal.

## :pencil: Contributing, :disappointed: Issues and :bug: Bug Reports
The project is open to public contribution. Please feel very free to contribute.
Experienced an issue or want to report a bug? Please, [report it here](https://github.com/mccamo51/the_teller_checkout/issues). Remember to be as descriptive as possible.

## :trophy: Credits
Thanks to the authors of Thetella. I leveraged on their work to bring this plugin to fruition.

