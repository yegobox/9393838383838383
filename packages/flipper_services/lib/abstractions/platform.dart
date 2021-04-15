import 'package:flutter/material.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';

abstract class Platform {
  Future<void> createAccountWithPhone(
      {required String phone, required BuildContext context});
  signInWithGoogle();
  signInWithApple(
      {required String appleClientId, required String appleRedirectUri});
}
