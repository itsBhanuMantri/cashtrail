package com.example.cashtrail

import android.content.Intent
import android.net.Uri
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
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
