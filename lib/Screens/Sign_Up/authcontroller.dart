
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:untitled/routes/routes.dart';

import '../../entities/userdata.dart';
import '../../store/user.dart';
GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
    'profile',
  ],
);
class SignUpController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();


  var isLoading = false.obs;

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    super.onClose();
  }

  bool isValidEmail(String email) {
    return RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+\.[a-zA-Z]{2,}$"
    ).hasMatch(email);
  }

  bool isValidPassword(String password) {
    return password.length >= 6;
  }

  Future<void> signUpUser() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String username = usernameController.text.trim();

    print('Email: "$email", Password: "$password", Username: "$username"');

    if (email.isEmpty || password.isEmpty || username.isEmpty) {
      Get.snackbar('Error', 'All fields are required',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }


    if (!isValidEmail(email)) {
      Get.snackbar('Error', 'Invalid email format',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    if (!isValidPassword(password)) {
      Get.snackbar('Error', 'Password must be at least 6 characters',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    isLoading.value = true;

    try {
      UserCredential userCredential =
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await userCredential.user?.sendEmailVerification();

      await _firestore.collection('users').doc(userCredential.user?.uid).set({
        'username': username,
        'email': email,
        'createdAt': FieldValue.serverTimestamp(),
        'emailVerified': false,
      });
      UserLoginResponseEntity userProfile = UserLoginResponseEntity(
        email: email,
        accessToken: userCredential.user?.uid,
        displayName: username,

      );

      UserStore.to.saveProfile(userProfile);
      Get.defaultDialog(
        title: 'Success',
        middleText:
        'A verification link has been sent to your email. Please verify your email to proceed.',
        barrierDismissible: false,
      );

      Future.delayed(Duration(seconds: 3), () {
        if (Get.isDialogOpen ?? false) {
          Get.back();
          Get.offNamed(AppRoutes.SIGN_IN);
        }
      });
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'email-already-in-use':
          errorMessage = 'This email is already registered.';
          break;
        case 'invalid-email':
          errorMessage = 'Invalid email address.';
          break;
        case 'weak-password':
          errorMessage = 'Your password is too weak.';
          break;
        default:
          errorMessage = 'An unknown error occurred. Please try again.';
      }
      Get.snackbar('Error', errorMessage,
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong: $e',
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
    } finally {
      isLoading.value = false;
    }
  }
/*
  late Rx<User?> firebaseUser;

  //late Rx<GoogleSignInAccount?> googleSignInAccount;

  @override
  void onReady() {
    super.onReady();


    firebaseUser = Rx<User?>(FirebaseAuth.instance.currentUser);
    // googleSignInAccount = Rx<GoogleSignInAccount?>(googleSignInAccount.currentUser);


    firebaseUser.bindStream(FirebaseAuth.instance.userChanges());
    ever(firebaseUser, _setInitialScreen);
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print("User signed out");
        Get.offAllNamed(AppRoutes.SIGN_IN);
      } else {
        print("User signed in: ${user.email}");
        Get.offAllNamed(AppRoutes.USER_SCREEN);
      }
    });

    // googleSignInAccount.bindStream(googleSign.onCurrentUserChanged);

    // ever(googleSignInAccount, _setInitialScreenGoogle);
  }

  _setInitialScreen(User? user) {
    if (user == null) {

      Get.offAllNamed(AppRoutes.SIGN_IN);

    } else {

      Get.offAllNamed(AppRoutes.USER_SCREEN);

    }
  }*/

  /*_setInitialScreenGoogle(GoogleSignInAccount? googleSignInAccount) {
    print(googleSignInAccount);
    if (googleSignInAccount == null) {  // if the user is not found then the user is navigated to the Register Screen
      Get.offAll(() =>  Googlesignin);

    } else {

// if the user exists and logged in the the user is navigated to the Home Screen
      Get.offAllNamed(AppRoutes.APPLICATION);

    }
  }*/

  Future<void> handleSign() async {
    try {
      // Initiate Google Sign-In
      var user = await _googleSignIn.signIn();

      // If user signs in successfully
      if (user != null) {
        final googleAuth = await user.authentication;

        // Check if authentication tokens are valid
        /* if (googleAuth.idToken == null || googleAuth.accessToken == null) {
          print("Google Authentication tokens are null.");
          return;
        }*/

        // Create Firebase credential using Google authentication tokens
        final credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        );

        // Sign in to Firebase with Google credential
        UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

        // Fetch details from Firebase user
        String uid = userCredential.user!.uid; // Use Firebase Auth UID
        String displayName = user.displayName ?? user.email;
        String email = user.email;

        // Create the user profile
        UserLoginResponseEntity userProfile = UserLoginResponseEntity(
          email: email,
          accessToken: uid, // Use Firebase UID as access token
          displayName: displayName,

        );

        UserStore.to.saveProfile(userProfile);

        DocumentSnapshot userDoc = await _firestore.collection('users').doc(uid).get();

        if (!userDoc.exists) {
          // User doesn't exist, so create a new user document in Firestore
          final newUser = UserData(
            id: uid,
            name: displayName,
            email: email,

          );

          // Set the user document in Firestore under their UID
          await _firestore.collection('users').doc(uid).set(newUser.toFirestore());
        }

        // Navigate to the application main screen
        Get.offAndToNamed(AppRoutes.USER_SCREEN);
      }
    } catch (e) {
      // Handle any errors during sign-in
      print("Error during sign-in: $e");
      Get.snackbar('Error', 'Sign-in failed: $e');
    }
  }
}
