import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const PhonePePaymentApp());
}

class PhonePePaymentApp extends StatelessWidget {
  const PhonePePaymentApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PhonePe UPI Payment',
      theme: ThemeData(primarySwatch: Colors.purple),
      home: const PaymentScreen(),
    );
  }
}

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  static const platform = MethodChannel('upi_payment');

  final amountController = TextEditingController(text: '100');
  final upiIdController = TextEditingController(text: 'yourupi@paytm');
  final nameController = TextEditingController(text: 'Merchant Name');

  bool isLoading = false;
  String statusMessage = '';

  @override
  void dispose() {
    amountController.dispose();
    upiIdController.dispose();
    nameController.dispose();
    super.dispose();
  }

  String generateTransactionId() {
    return 'TXN${DateTime.now().millisecondsSinceEpoch}';
  }

  // Method 1: Using UPI Deep Link (Works with any UPI app including PhonePe)
  Future<void> openPhonePeUPI() async {
    if (amountController.text.isEmpty || upiIdController.text.isEmpty) {
      setState(() {
        statusMessage = 'Please fill all fields';
      });
      return;
    }

    setState(() {
      isLoading = true;
      statusMessage = 'Opening PhonePe...';
    });

    try {
      final amount = amountController.text;
      final upiId = upiIdController.text;
      final name = nameController.text;
      final transactionId = generateTransactionId();
      final note = 'Payment for order';

      // UPI Deep Link format
      // final upiUrl = 'upi://pay?pa=$upiId&pn=$name&am=$amount&cu=INR&tn=$note&tr=$transactionId';
      final upiUrl =
          'upi://pay?pa=9014365835@axl&amp;pn=USHASHREE%20%20M&amp;mc=0000&amp;mode=02&amp;purpose=00';

      final uri = Uri.parse(upiUrl);

      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
        setState(() {
          statusMessage =
              'Payment initiated with Transaction ID: $transactionId';
          isLoading = false;
        });
      } else {
        setState(() {
          statusMessage = 'Could not launch PhonePe. Please install the app.';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        statusMessage = 'Error: $e';
        isLoading = false;
      });
    }
  }

  // Method 2: Using Android Intent (Specific to PhonePe)
  Future<void> openPhonePeIntent() async {
    if (amountController.text.isEmpty || upiIdController.text.isEmpty) {
      setState(() {
        statusMessage = 'Please fill all fields';
      });
      return;
    }

    setState(() {
      isLoading = true;
      statusMessage = 'Opening PhonePe...';
    });

    try {
      final result = await platform.invokeMethod('startPhonePePayment', {
        'amount': amountController.text,
        'upiId': upiIdController.text,
        'name': nameController.text,
        'transactionId': generateTransactionId(),
        'note': 'Payment for order',
      });

      setState(() {
        statusMessage = 'Payment Result: $result';
        isLoading = false;
      });
    } on PlatformException catch (e) {
      setState(() {
        statusMessage = 'Error: ${e.message}';
        isLoading = false;
      });
    }
  }

  // Method 3: Open PhonePe app directly
  Future<void> openPhonePeApp() async {
    try {
      final uri = Uri.parse('phonepe://');

      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
        setState(() {
          statusMessage = 'PhonePe app opened';
        });
      } else {
        // Try to open Play Store
        final playStoreUri = Uri.parse(
          'https://play.google.com/store/apps/details?id=com.phonepe.app',
        );
        await launchUrl(playStoreUri, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      setState(() {
        statusMessage = 'Error opening PhonePe: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PhonePe UPI Payment'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Image.network(
              'https://www.phonepe.com/webstatic/6.5.0/static/media/phonepe-logo.ac98e089.svg',
              height: 60,
              errorBuilder:
                  (context, error, stackTrace) =>
                      const Icon(Icons.payment, size: 60, color: Colors.purple),
            ),
            const SizedBox(height: 30),

            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Merchant Name',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 15),

            TextField(
              controller: upiIdController,
              decoration: const InputDecoration(
                labelText: 'UPI ID (Your receiving UPI)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.account_balance),
                hintText: 'example@paytm',
              ),
            ),
            const SizedBox(height: 15),

            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Amount (₹)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.currency_rupee),
              ),
            ),
            const SizedBox(height: 30),

            // Button to open with UPI Intent (Recommended)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: isLoading ? null : openPhonePeUPI,
                icon: const Icon(Icons.payment),
                label: const Text('Pay via UPI (Any App)'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: Colors.purple,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 15),

            // Button for Android Intent method
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: isLoading ? null : openPhonePeIntent,
                icon: const Icon(Icons.phonelink),
                label: const Text('Pay via Android Intent'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  foregroundColor: Colors.purple,
                ),
              ),
            ),
            const SizedBox(height: 15),

            // Button to just open PhonePe app
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: openPhonePeApp,
                icon: const Icon(Icons.apps),
                label: const Text('Open PhonePe App'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  foregroundColor: Colors.deepPurple,
                ),
              ),
            ),

            const SizedBox(height: 30),

            if (isLoading)
              const CircularProgressIndicator()
            else if (statusMessage.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  statusMessage,
                  style: const TextStyle(fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ),

            const SizedBox(height: 20),

            const Card(
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ℹ️ How it works:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '1. Enter your UPI ID (where you want to receive money)',
                    ),
                    Text('2. Enter the amount'),
                    Text('3. Click "Pay via UPI" button'),
                    Text('4. Select PhonePe from the app list'),
                    Text('5. Complete the payment'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*
SETUP INSTRUCTIONS:

1. Add dependency in pubspec.yaml:
   dependencies:
     url_launcher: ^6.2.1

2. Android Setup (android/app/src/main/AndroidManifest.xml):
   Add inside <manifest> tag:
   
   <queries>
       <intent>
           <action android:name="android.intent.action.VIEW" />
           <data android:scheme="upi" />
       </intent>
       <package android:name="com.phonepe.app" />
   </queries>

3. For Android Intent Method (Optional) - MainActivity.kt:

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.content.Intent
import android.net.Uri

class MainActivity: FlutterActivity() {
    private val CHANNEL = "upi_payment"
    private val UPI_PAYMENT_REQUEST = 123

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            call, result ->
            if (call.method == "startPhonePePayment") {
                val amount = call.argument<String>("amount")
                val upiId = call.argument<String>("upiId")
                val name = call.argument<String>("name")
                val transactionId = call.argument<String>("transactionId")
                val note = call.argument<String>("note")
                
                val uri = Uri.parse("upi://pay").buildUpon()
                    .appendQueryParameter("pa", upiId)
                    .appendQueryParameter("pn", name)
                    .appendQueryParameter("am", amount)
                    .appendQueryParameter("cu", "INR")
                    .appendQueryParameter("tn", note)
                    .appendQueryParameter("tr", transactionId)
                    .build()
                
                val intent = Intent(Intent.ACTION_VIEW, uri)
                intent.setPackage("com.phonepe.app")
                
                try {
                    startActivityForResult(intent, UPI_PAYMENT_REQUEST)
                    result.success("Payment initiated")
                } catch (e: Exception) {
                    result.error("ERROR", e.message, null)
                }
            } else {
                result.notImplemented()
            }
        }
    }
}

4. iOS Setup (ios/Runner/Info.plist):
   Add inside <dict> tag:
   
   <key>LSApplicationQueriesSchemes</key>
   <array>
       <string>phonepe</string>
       <string>upi</string>
   </array>

NOTE: This method uses UPI protocol which works with ANY UPI app,
not just PhonePe. The user can choose PhonePe when prompted.
*/
