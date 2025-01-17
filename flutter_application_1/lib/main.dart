
import 'package:flutter/material.dart';
// import 'package:flutter_application_1/speed_pay_page.dart';
// import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key); // Fixed constructor

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title:"hi",
      home:const SpeedPayPage(),
      
    );
  }
}


class SpeedPayPage extends StatefulWidget {
  const SpeedPayPage({Key? key}) : super(key: key);

  @override
  State<SpeedPayPage> createState() => _SpeedPayPageState();
}

class _SpeedPayPageState extends State<SpeedPayPage> {
  late Razorpay _razorpay;
  TextEditingController amtController = TextEditingController();

  void openCheckout(amount) {
    amount = amount * 100; // Convert to paise
    var options = {
      'key': 'spd_test_1D5OPsss45',
      'amount': amount,
      'name': 'G&P',
      'prefill': {'contact': '1234567890', 'email': 'speed@gmail.com'},
      'externals': {
        'wallets': ['SpeedPay']
      }
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  void handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(
      msg: "Payment Successful: ${response.paymentId ?? 'Unknown ID'}",
      toastLength: Toast.LENGTH_SHORT,
    );
  }

  void handlePaymentFailure(PaymentFailureResponse response) {
    Fluttertoast.showToast(
      msg: "Payment Failed: ${response.message ?? 'Unknown Error'}",
      toastLength: Toast.LENGTH_SHORT,
    );
  }

  void handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
      msg: "External Wallet: ${response.walletName ?? 'Unknown Wallet'}",
      toastLength: Toast.LENGTH_SHORT,
    );
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose(); // Call parent dispose method
  }

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentFailure);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 145, 111, 57),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 100),
            Image.network(
                "https://speedpay.myumbbank.com/assets/SpeedPay%20Logo-Full%20Colour-83d519e4.png"),
            SizedBox(height: 10),
            Text(
              "Welcome To SpeedPay App!",
              style: TextStyle(
                  color: Colors.amber,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextFormField(
                cursorColor: Colors.white,
                autofocus: false,
                style: TextStyle(color: const Color.fromARGB(255, 228, 225, 219)),
                decoration: InputDecoration(
                    labelText: 'Enter Amount To be Paid',
                    labelStyle: TextStyle(fontSize: 15.0, color: Colors.white),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 1.0)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 1.0)),
                    errorStyle: TextStyle(color: Colors.redAccent, fontSize: 15)),
                controller: amtController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter Amount To Be Paid';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                if (amtController.text.isNotEmpty) {
                  try {
                    int amount = int.parse(amtController.text);
                    openCheckout(amount);
                  } catch (e) {
                    Fluttertoast.showToast(
                      msg: "Please enter a valid amount",
                      toastLength: Toast.LENGTH_SHORT,
                    );
                  }
                }
              },
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Make Payment'),
              ),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow),
            ),
          ],
        ),
      ),
    );
  }
}