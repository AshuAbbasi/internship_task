
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:untitled/Screens/UserProfile/userprofile.dart';
import '../Screens/ForgetPassword/forgotscreen.dart';
import '../Screens/Sign_IN/loginpage.dart';
import '../Screens/Sign_Up/signuppage.dart';
import '../Screens/splash_screen.dart';
import 'routes.dart';

class AppPages{
  static const INITIAL=AppRoutes.INITIAL;

      static final List<GetPage> routes=[
        GetPage(name: AppRoutes.INITIAL, page: ()=>SplashScreen(),

        ),
      /*  GetPage(name: AppRoutes.Auth_SCREENS, page: ()=>Googlesignin(),
          binding: SignUpBindings()
         ),*/
        /*GetPage(name: AppRoutes.APPLICATION, page: ()=>ApplicationPage(),
          binding: ApplicationBindings(),),*/
       GetPage(name: AppRoutes.Forgeot_Screen, page: ()=>PaswordResetScreen(),
         ),

        GetPage(name: AppRoutes.SIGN_IN, page: ()=>Loginpage(),
         ),
        GetPage(name: AppRoutes.SIGN_UP, page: ()=>RegisterPage(),
        ),

        GetPage(name: AppRoutes.USER_SCREEN, page: ()=>Userprofile(),
          //binding: UsersProfileBindings(),
        ),



      ];
}

