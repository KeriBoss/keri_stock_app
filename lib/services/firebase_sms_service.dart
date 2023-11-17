import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:stock_market_project/core/extension/string%20_extension.dart';
import 'package:stock_market_project/data/static/app_value.dart';

import '../main.dart';

class FirebaseSmsService {
  static Future<void> verifyPhoneNumber(String phoneNumber) async {
    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber.formatPhoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        debugPrint('Verification done!');
      },
      verificationFailed: (FirebaseAuthException e) {
        debugPrint('Caught verification failed error');
        debugPrint(e.message);
      },
      codeSent: (String verificationId, int? resendToken) {
        debugPrint('Verification code has been sent: $verificationId');
        AppValue.verificationId = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        debugPrint('Verification code timed out');
      },
    );
  }
}
