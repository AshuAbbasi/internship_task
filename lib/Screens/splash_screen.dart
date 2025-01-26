

import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../Widgets/big_text.dart';
import '../routes/routes.dart';
import 'Sign_Up/authcontroller.dart';
import 'Sign_Up/signuppage.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  //final SignUpController authController=Get.put( SignUpController ());
  late AnimationController _controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    animation=CurvedAnimation(parent: _controller, curve: Curves.linear);
    Future.delayed(Duration(seconds: 3),(){
     Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterPage()));
    });



    animation=CurvedAnimation(parent: _controller, curve: Curves.linear);
   /* Timer(
        Duration(seconds: 3),authController.onReady

       //  ()=>Navigator.push(context,MaterialPageRoute(builder: (context)=>SigninPage()))
    );*/
    /*FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        // User is not logged in, navigate to SignIn page
        Get.offNamed(AppRoutes.SIGN_IN);
      } else {
        // User is logged in, navigate to User screen
        Get.offNamed(AppRoutes.USER_SCREEN);
      }
    });*/


  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
           BigText(text: "Intership Task", size: 22, color: Colors.white,),

          ],
        ),
      ),
    );
  }
}
