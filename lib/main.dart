import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:untitled/routes/pages.dart';
import 'package:get/get.dart';

import 'Screens/Sign_IN/login__controller.dart';
import 'Screens/Sign_Up/authcontroller.dart';
import 'Screens/UserProfile/userprofile_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure the binding is initialized
  await Firebase.initializeApp(); // Initialize Firebase
  Get.lazyPut(()=>SignUpController());
  Get.lazyPut(()=>LoginController());
  Get.lazyPut(()=>UserController(),);
  runApp(MyApp());

}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(

      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes, // Define the GetX routes
      //home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

