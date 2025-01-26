
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled/routes/routes.dart';

class LoginController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;


  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var isLoading = false.obs;
  var canResendEmail = true.obs;
  Timer? resendTimer;
  RxString countdownText = '60'.obs;

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    resendTimer?.cancel();
    super.onClose();
  }


  Future<void> loginUser() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'Email and password are required',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    isLoading.value = true;

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      if (user != null && !user.emailVerified) {

        _showVerifyEmailDialog(user);
        _checkEmailVerification(user);
      } else if (user != null && user.emailVerified) {

        await _updateUserStatus(user);
        Get.offNamed(AppRoutes.USER_SCREEN);
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'No user found for this email.';
          break;
        case 'wrong-password':
          errorMessage = 'Incorrect password.';
          break;
        case 'invalid-email':
          errorMessage = 'Invalid email address.';
          break;
        default:
          errorMessage = 'An unknown error occurred. Please try again.';
      }
      Get.snackbar('Error', errorMessage,
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
    } finally {
      isLoading.value = false;
    }
  }

  void _checkEmailVerification(User user) {
    Timer.periodic(Duration(seconds: 5), (timer) async {
      await user.reload();
      if (user.emailVerified) {
        timer.cancel();
        await _updateUserStatus(user);
        Get.offNamed(AppRoutes.USER_SCREEN);
      }
    });
  }

  Future<void> _updateUserStatus(User user) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
        'emailVerified': true,
      });
    } catch (e) {
      Get.snackbar('Error', 'Failed to update user status in Firestore: $e',
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
    }
  }

  void _showVerifyEmailDialog(User user) {
    Get.defaultDialog(
      title: 'Verify Your Email',
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Your email is not verified. Please check your inbox for a verification link.',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8,),
            Obx(() {
              return Column(
                children: [
                  ElevatedButton(
                    onPressed: canResendEmail.value
                        ? () => _resendVerificationEmail(user)
                        : null,
                    child: Text(
                      canResendEmail.value
                          ? 'Resend Verification Email'
                          : 'Wait ${countdownText.value} seconds',
                    ),
                  ),
                  if (!canResendEmail.value)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        'Resend available in ${countdownText.value} seconds',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                ],
              );
            }),
          ],
        ),
      ),
      barrierDismissible: false,
      confirm: ElevatedButton(
        onPressed: () => Get.back(),
        child: const Text('Close'),
      ),
    );
  }

  Future<void> _resendVerificationEmail(User user) async {
    try {
      await user.sendEmailVerification();
      canResendEmail.value = false;
      _startResendCooldown();
      Get.snackbar('Success', 'Verification email resent successfully.',
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green);
    } catch (e) {
      Get.snackbar('Error', 'Failed to resend verification email: $e',
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
    }
  }

  void _startResendCooldown() {
    int countdown = 60;
    countdownText.value = '$countdown';
    resendTimer?.cancel();
    resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      countdown--;
      countdownText.value = '$countdown';
      if (countdown == 0) {
        canResendEmail.value = true;
        timer.cancel();
      }
    });
  }
}
