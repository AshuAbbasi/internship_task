import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:untitled/routes/routes.dart';

import '../../entities/userdata.dart';
import '../../store/user.dart';


class UserController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var userName = ''.obs;
  var userEmail = ''.obs;
  var createdat = ''.obs;
var verif=false.obs;
var uid;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserDetails();
  }

  Future<void> fetchUserDetails() async {
    try {
      User? user = _auth.currentUser;

      if (user != null) {
        DocumentSnapshot userDoc = await _firestore.collection('users').doc(user.uid).get();

        if (userDoc.exists) {
          print("user:${user.uid}");
          uid=user.uid;
           String username = userDoc['username'];
          print("email${userDoc['email']}");
          String email = userDoc['email'];
          bool verifed=userDoc['emailVerified'];
          DateTime createdAt = (userDoc['createdAt'] as Timestamp).toDate();
userName.value=username;
userEmail.value=email;
createdat.value=createdAt.toString();
verif.value=verifed;
print("this is user name${userName}");
          print('Username: $username, Email: $email, Created At: $createdAt');
        } else {
          print('User document not found in Firestore');
        }
      } else {
        print('User is not logged in');
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  Future<void> logOut() async {
    try {
      await _auth.signOut();
      Get.offNamed(AppRoutes.SIGN_IN);
      Get.snackbar('Success', 'Successfully logged out');
    } catch (e) {
      Get.snackbar('Error', 'Failed to log out: $e');
    }
  }
  Future<void> deleteUserAccount() async {
    isLoading.value = true;

    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).delete();

        await user.delete();

        Get.snackbar('Success', 'Account deleted successfully');
        Get.offAllNamed(AppRoutes.SIGN_IN); // Redirect to login screen
      } else {
        Get.snackbar('Error', 'No user is logged in');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete account: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> disableUserAccount() async {
    isLoading.value = true;

    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).update({
          'isDisabled': true,
        });
        await _auth.signOut();
        Get.snackbar('Success', 'Account disabled successfully');
        Get.offAllNamed('/login');
      } else {
        Get.snackbar('Error', 'No user is logged in');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to disable account: $e');
    } finally {
      isLoading.value = false;
    }
  }

}
