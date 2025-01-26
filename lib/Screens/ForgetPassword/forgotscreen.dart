import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Widgets/big_text.dart';
import '../../Widgets/buttonlogin.dart';
import '../../Widgets/small_text.dart';
import '../../Widgets/textfield.dart';
import 'forgetpassword.dart';
// Import the controller

class PaswordResetScreen extends StatelessWidget {
  PaswordResetScreen({super.key});

  final PasswordResetController controller = Get.put(PasswordResetController());
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(Icons.clear, color: Colors.white, size: 35),
        ),
        backgroundColor: Colors.indigo,
        title: BigText(text: "Reset Password", size: 22, color: Colors.white),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(
                  child: SmallText(
                    text: "Enter your email address below\n          to reset password",
                    size: 17,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 20),
                SimpleTextField(
                 hint:  "Email",
                  textEditingController: emailController,
                ),
                SizedBox(height: 50),
                Obx(() {
                  return Buttonlogin(
                    onTab:(){
                   //   controller.forgetPassword(emailController.text);
                     controller.isLoading.value
                          ? CircularProgressIndicator
                          : () => controller.forgetPassword(emailController.text);
                    },
                    text: controller.isLoading.value
                        ? 'Sending...'
                        : 'Reset Email Send',
                    color: Colors.indigo,
                    bcolor: Colors.indigo,
                    txtc: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    width: 300,
                    height: 60,
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
