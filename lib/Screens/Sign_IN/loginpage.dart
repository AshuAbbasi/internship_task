
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
import 'login__controller.dart';



class Loginpage extends StatelessWidget {
  Loginpage({super.key});
final logincontroller=Get.find<LoginController>();
  @override
  Widget build(BuildContext context) {
    final Size size=MediaQuery.of(context).size;
    return Scaffold(

      backgroundColor:Colors.black ,
      body: SingleChildScrollView(
        child:Container(height: size.height,width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/images/bg_image.png"),fit: BoxFit.contain)
            ),
            child:Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Column(
                children: [ Align(alignment: Alignment.topRight,
                  child: Container(padding: EdgeInsets.only(top: 15,right: 20),
                    width: 300,height: size.height/3.78,decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage("assets/images/login_Illustration.png"),fit: BoxFit.cover)
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

                         Center(child: BigText(text: "Welcome Back!",size: 22,color: Colors.white,)),
                         SizedBox(height: size.height/80,),
                         Center(child: SmallText(text: "Well come back we missed you",size: 14,color: Colors.white.withOpacity(0.2),),),
                         SizedBox(height: size.height/60,),
                         SmallText(text:"Email Address",size: 15,color: Colors.white.withOpacity(0.3),),
                         SizedBox(height: size.height/90,),
                         SimpleTextField( textEditingController: logincontroller.emailController,lefticon: Icon(Icons.email),
                           hint: "yourname@gmail.com",type: TextInputType.emailAddress,),
                         SizedBox(height: size.height/80,),

                         SmallText(text:"Password",size: 15,color: Colors.white.withOpacity(0.3),),
                         SizedBox(height: 8,),
                         PasswordTextField(txt: "Password", textEditingController: logincontroller.passwordController,icons: Icon(Icons.key),),
                         SizedBox(height: 10,),
                         GestureDetector(onTap: (){
                           Get.toNamed(AppRoutes.Forgeot_Screen);
                         },
                           child: Align(alignment: Alignment.bottomRight,
                               child: BigText(text: "Forgot Password?",size: 16,color: Colors.white.withOpacity(0.3),)),
                         ),
                         SizedBox(height: size.height/25,),
                         Center(
                           child: Buttonlogin(onTab: (){
                             // loginIn();
                             logincontroller.loginUser();
                           }, text: "Login", color: Colors.indigo,width: 200,bcolor: Colors.indigo,
                               txtc: Colors.white,borderRadius: BorderRadius.circular(15)),
                         ),
                         SizedBox(height: size.height/30,),
                         Center(
                             child: Row(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
                               children: [Text(
                                 "Don't have an account? ",
                                 style: TextStyle(color: Colors.white.withOpacity(0.3),),
                               ),
                                 GestureDetector(
                                   onTap: () => Get.toNamed(AppRoutes.SIGN_UP),
                                   child: Text(
                                     "Sign UP ",
                                     style: TextStyle(color: Colors.indigo,fontSize: 15),
                                   ),
                                 ),
                               ],)
                         ),
                         SizedBox(height:8),
                         Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [Divider(thickness: 3,color: Colors.black,),SmallText(text: "or sign up with",size: 14,),Divider(thickness: 1,),],),
                         SizedBox(height:size.height/90,),
                         Row(mainAxisAlignment: MainAxisAlignment.center,
                           children: [GestureDetector(
                             child: Container(height: 60,width: 60,decoration: BoxDecoration(color: Colors.white24.withOpacity(0.1),
                                 borderRadius: BorderRadius.circular(20),border: Border.all(color: Colors.white10,width: 1),
                                 image: DecorationImage(image: AssetImage("assets/images/google_image.png"),)
                             ),),
                           ),SizedBox(width: 20,),
                             Container(height: 60,width: 60,decoration: BoxDecoration(color: Colors.white24.withOpacity(0.1),
                                 borderRadius: BorderRadius.circular(20),border: Border.all(color: Colors.white10,width: 1),
                                 image: DecorationImage(image: AssetImage("assets/images/facebook_image.png"),)
                             ),),SizedBox(width: 20,),
                             Container(height: 60,width: 60,decoration: BoxDecoration(color: Colors.white24.withOpacity(0.1),border: Border.all(color: Colors.white10,width: 1),
                                 borderRadius: BorderRadius.circular(20),
                                 image: DecorationImage(image: AssetImage("assets/images/apple_image.png"),)
                             ),),],)
                       ],
                      ),
                    ),
                  ),
                ],
              ),
            ))
        /* Padding(
          padding: const EdgeInsets.only(left: 10.0,right: 10.0,top: 60),
          child: Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.start,
          children: [

          Image.asset("assets/images/login.png",width: double.infinity
            ,height: size.height/5,),
          SizedBox(height: size.height/25,),
            Center(child: BigText(text: "Welcome Back!",size: 18,)),
            SizedBox(height: size.height/80,),
            Center(child: SmallText(text: "Well come back we missed you",size: 13,),),
            SizedBox(height: size.height/60,),
            SmallText(text:"Email Address",size: 16,),
            SizedBox(height: size.height/90,),
            SimpleTextField( textEditingController: logincontroller.emailController,lefticon: Icon(Icons.email),
              hint: "yourname@gmail.com",type: TextInputType.emailAddress,),
            SizedBox(height: size.height/80,),

            SmallText(text:"Password",size: 17,),
            SizedBox(height: 8,),
            PasswordTextField(txt: "Password", textEditingController: logincontroller.passwordController,icons: Icon(Icons.key),),
            SizedBox(height: 10,),
            GestureDetector(onTap: (){
              Get.toNamed(AppRoutes.Forgeot_Screen);
            },
              child: Align(alignment: Alignment.bottomRight,
                  child: BigText(text: "Forgot Password?",size: 16,)),
            ),
            SizedBox(height: size.height/25,),
            Center(
              child: Buttonlogin(onTab: (){
               // loginIn();
                logincontroller.loginUser();
              }, text: "Login", color: Colors.indigo,width: 200,bcolor: Colors.indigo,
                txtc: Colors.white,borderRadius: BorderRadius.circular(15)),
            ),
            SizedBox(height: size.height/30,),
            Center(
                child: Row(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
                  children: [Text(
                    "Don't have an account? ",
                    style: TextStyle(color: Colors.black),
                  ),
                    GestureDetector(
                      onTap: () => Get.toNamed(AppRoutes.SIGN_UP),
                      child: Text(
                        "Sign UP ",
                        style: TextStyle(color: Colors.indigo,fontSize: 15),
                      ),
                    ),
                  ],)
            ),
          ],),
        ),*/
      ),
    );
  }
}

