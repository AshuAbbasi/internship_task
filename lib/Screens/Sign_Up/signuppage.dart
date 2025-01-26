/*

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Widgets/big_text.dart';
import '../../Widgets/buttonlogin.dart';
import '../../Widgets/small_text.dart';
import '../../Widgets/snackbar.dart';
import '../../Widgets/textfield.dart';
import '../../routes/routes.dart';

class  SignUpPage extends StatefulWidget {
  SignUpPage  ({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool isloading=false;
  final emailtext=TextEditingController();
  final passwordtext=TextEditingController();
  final usernametext=TextEditingController();

  */
/*void signUp() async {


    String res = await Sign_Up().signupUser(
      emails: emailtext.text,
      password: passwordtext.text,
      username: usernametext.text,
      // Use the imageUrl when signing up
    );

    if (res == "successfully") {
      Get.toNamed(AppRoutes.APPLICATION);
    } else {
      showSnackBar(context, res);
    }
  }
*//*


  void dispose(){
    super.dispose();
    emailtext.dispose();
    passwordtext.dispose();
    usernametext.dispose();

  }
  @override
  Widget build(BuildContext context) {


    return Scaffold(
backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0,right: 15,top: 30),
          child: Column(mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(onTap: (){
                Get.back();
              },
                  child: Icon(Icons.clear,size: 30,color: Colors.black,)),
              SizedBox(height: 90,),
              Column(mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  BigText(text: "Sign Up",size: 26,),
                  */
/*Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.purpleAccent,
                      image: DecorationImage(image: NetworkImage(""))
                    ),

                  ),
                  SizedBox(height: 10,),
                Buttonlogin(onTab: (){
                  pickImage();
                }, text:"Pick Picture", color:Colors.white,bcolor: Colors.black,
                width: 130.w,height: 40,txtc: Colors.black,borderRadius: BorderRadius.circular(20),),*//*

                  SizedBox(height: 80,),
                  SmallText(text:"Email Address"),
                  SimpleTextField(txt: "Email", textEditingController: emailtext,lefticon: Icon(Icons.email),
                    hint: "yourname@gmail.com",type: TextInputType.emailAddress,),
                  SizedBox(height: 10,),
                  SimpleTextField(txt: "User name", textEditingController: usernametext,lefticon: Icon(Icons.person),
                    hint: "your name",type: TextInputType.text,),
                  SizedBox(height: 10,),
                  PasswordTextField(txt: "Password", textEditingController: passwordtext,icons: Icon(Icons.key),),
                  SizedBox(height: 40,),
                  Buttonlogin(onTab: (){
                   // signUp();
                  }, text: "Sign up", color: Colors.indigo,txtc: Colors.white,
                  borderRadius: BorderRadius.circular(10),width: 300,
                  height: 50,),
                  SizedBox(height: 30,),
                  Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [ SmallText(text: "Already Have an account?",size: 17,),

                    GestureDetector(onTap: (){
                      Get.toNamed(AppRoutes.SIGN_IN);    },
                        child: SmallText(text: "Sign In here",color: Colors.indigoAccent,size: 16,))],)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
*/
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/Widgets/big_text.dart';
import 'package:untitled/Widgets/buttonlogin.dart';
import 'package:untitled/routes/routes.dart';
import '../../Widgets/small_text.dart';
import '../../Widgets/textfield.dart';
import 'authcontroller.dart';

class RegisterPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    //final authController = Get.find<SignUpController>();
    final authController= Get.put(SignUpController(), permanent: true);
final Size size=MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Container(height: size.height,width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/images/bg_image.png"),fit: BoxFit.contain)
        ),
        child:Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Column(
            children: [  Align(alignment: Alignment.topRight,
              child: Container(padding: EdgeInsets.only(top: 15,right: 20),
                width: 300,height: size.height/3.78,decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage("assets/images/sign_up_ilustration.png"),fit: BoxFit.cover)
                ),),
            ),


              Container(
                height: size.height/1.4,width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.purpleAccent.withOpacity(0.1),
borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40))
                ),
                child:  Padding(
                  padding: const EdgeInsets.only(top: 20,left: 30,right: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Center(child: BigText(text: "Get Started Free",size: 24,color: Colors.white,)),
                      SizedBox(height: 6,),
                      Center(child: SmallText(text: "free forever. No credit card Neede",size: 14,color: Colors.white.withOpacity(0.2),)),
                      SizedBox(height: size.height/27,),
                      SmallText(text:"Email Address",size: 15,color: Colors.white.withOpacity(0.3),),
                      SizedBox(height:size.height/90,),
                      SimpleTextField( textEditingController: authController.emailController,lefticon: Icon(Icons.email),
                        hint: "yourname@gmail.com",type: TextInputType.emailAddress,),
                      SizedBox(height:size.height/90,),
                      SmallText(text:"User Name",size: 15,color: Colors.white.withOpacity(0.3),),
                      SizedBox(height:size.height/90,),
                      SimpleTextField( textEditingController: authController.usernameController,lefticon: Icon(Icons.person),
                        hint: "your name",type: TextInputType.text,),
                      SizedBox(height:size.height/90,),
                      SmallText(text:"Password",size: 15,color: Colors.white.withOpacity(0.3),),
                      SizedBox(height:size.height/90,),
                      PasswordTextField(txt: "Password", textEditingController: authController.passwordController,icons: Icon(Icons.key),),
                      SizedBox(height:size.height/30,),

                      Obx(() => authController.isLoading.value
                          ? Center(child: CircularProgressIndicator())
                          : Center(
                        child: Buttonlogin(onTab: (){
                          authController.signUpUser();
                        }, text: "Sign up", color: Colors.indigo,borderRadius: BorderRadius.circular(15),txtc: Colors.white,width: 300,height: 50,),
                      ),),
                     /* SizedBox(height:size.height/30,),
                      Center(
                          child: Row(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
                            children: [Text(
                              "Already have an account? ",
                              style: TextStyle(color: Colors.black),
                            ),
                              GestureDetector(
                                onTap: () => Get.toNamed(AppRoutes.SIGN_IN),
                                child: Text(
                                  "Sign IN ",
                                  style: TextStyle(color: Colors.indigo,fontSize: 15),
                                ),
                              ),
                            ],)
                      ),*/
                      SizedBox(height:8),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Divider(thickness: 3,color: Colors.black,),SmallText(text: "or sign up with",size: 14,),Divider(thickness: 1,),],),
                      SizedBox(height:size.height/90,),
                      Row(mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                         Obx(()=> GestureDetector(onTap: (){authController.handleSign();},child: Container(height: 60,width: 60,decoration: BoxDecoration(color: Colors.white24.withOpacity(0.1),
                             borderRadius: BorderRadius.circular(20),border: Border.all(color: Colors.white10,width: 1),
                             image: DecorationImage(image: AssetImage("assets/images/google_image.png"),)
                         ),) ,),
                         ),
                          SizedBox(width: 20,),
                          Container(height: 60,width: 60,decoration: BoxDecoration(color: Colors.white24.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),border: Border.all(color: Colors.white10,width: 1),
                              image: DecorationImage(image: AssetImage("assets/images/facebook_image.png"),)
                          ),),SizedBox(width: 20,),
                          Container(height: 60,width: 60,decoration: BoxDecoration(color: Colors.white24.withOpacity(0.1),border: Border.all(color: Colors.white10,width: 1),
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(image: AssetImage("assets/images/apple_image.png"),)
                          ),),],),


                    ],
                  ),
                ),
              ),
            ],
          ),
        ))
      )
    );
  }
}
