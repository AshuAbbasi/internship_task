import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:untitled/Screens/UserProfile/userprofile_controller.dart';
import 'package:untitled/Widgets/big_text.dart';
import 'package:untitled/Widgets/buttonlogin.dart';
import 'package:untitled/Widgets/small_text.dart';

class Userprofile extends StatelessWidget {
   Userprofile({super.key});
  // final usercontroller=Get.find<UserController>();
final usercontroller=Get.put(UserController(),permanent: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
      appBar: AppBar(title: BigText(text: "User Profile",color: Colors.white,size: 22,),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
    ),
    body: Center(
      child: Obx(()=>Column(mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
         // SmallText(text: "User ID: ${usercontroller.uid.value}",size: 16,color: Colors.white.withOpacity(0.6),),
          SizedBox(height: 5,),
          SmallText(text: "User Name: ${usercontroller.userName.value}",size: 16,color: Colors.white.withOpacity(0.6),),
          SizedBox(height: 5,),
          SmallText(text: "User Email: ${usercontroller.userEmail}",size: 16,color: Colors.white.withOpacity(0.6),),
          SizedBox(height: 5,),
          SmallText(text: "Created At: ${usercontroller.createdat.value}",size: 16,color: Colors.white.withOpacity(0.6),),

          SizedBox(height: 5,),
          SmallText(text: "email Verified: ${usercontroller.verif.value}",size: 16,color: Colors.white.withOpacity(0.6),),

          SizedBox(height: 40,),

          Buttonlogin(onTab: (){usercontroller.logOut();}, text: "Log out", color:Colors.indigo,
            borderRadius: BorderRadius.circular(20),tsize: 20,txtc: Colors.white,height: 40,),

          /* Buttonlogin(onTab: (){usercontroller.deleteUserAccount();}, text: "Delete Account", color:Colors.indigoAccent,
            borderRadius: BorderRadius.circular(20),tsize: 20,txtc: Colors.white,height: 40,),
       */ ],
      ),)
    ));

  }
}
