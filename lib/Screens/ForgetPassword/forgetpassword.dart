import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/routes/routes.dart';

class PasswordResetController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final emailController = TextEditingController();

  var isLoading = false.obs;
  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    return emailRegex.hasMatch(email);
  }

  Future<void> forgetPassword(String email) async {
    if (email.isEmpty || !isValidEmail(email)) {
      Get.snackbar(
        'Error',
        'Please enter a valid email address',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
      );
      return;
    }

    try {
      isLoading.value = true;

      await _auth.sendPasswordResetEmail(email: email);

      isLoading.value = false;
      Get.snackbar(
        'Success',
        'Password reset email sent successfully.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
      );

      Get.offNamed(AppRoutes.SIGN_IN);
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      switch (e.code) {
        case 'user-not-found':
          Get.snackbar(
            'Error',
            'No user found with this email address.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
          );
          break;
        default:
          Get.snackbar(
            'Error',
            e.message ?? 'An unknown error occurred.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
          );
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        'Error',
        'Something went wrong. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
      );
    }
  }
}
