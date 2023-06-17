import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodly/screens/app/featured_partners.dart';

import 'screens/app/bottom_nav_screen.dart';
import 'screens/app/homepage.dart';
import 'screens/app/search_screen.dart';
import 'screens/authentication/adding_phone_number.dart';
import 'screens/authentication/forget_password.dart';
import 'screens/authentication/login_screen.dart';
import 'screens/authentication/register_screen.dart';
import 'screens/authentication/reset_password.dart';
import 'screens/authentication/restaurants_near.dart';
import 'screens/authentication/verify_phone_number.dart';
import 'screens/launch_screen.dart';
import 'screens/out_boarding/out_boarding_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // To hide the above bar ..
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/launch_screen",
      routes: {
        "/launch_screen": (context) => const LaunchScreen(),
        "/out_boarding_screen": (context) => const OutBoardingScreen(),
        "/login_screen": (context) => const LoginScreen(),
        "/register_screen": (context) => const RegisterScreen(),
        "/forget_password_screen": (context) => const ForgetPasswordScreen(),
        "/reset_password_screen": (context) => const ResetPasswordScreen(),
        "/adding_phone_number_screen": (context) =>
            const AddingPhoneNumberScreen(),
        "/verify_phone_number_screen": (context) =>
            const VerifyPhoneNumberScreen(),
        "/find_restaurants_near_screen": (context) =>
            const FindRestaurantsNearScreen(),
        "/bottom_nav_screen": (context) => const BottomNavScreen(),
        "/homepage_screen": (context) => const HomePageScreen(),
        "/search_screen": (context) => const SearchScreen(),
        "/featured_partners": (context) => const FeaturedPartners(),
        // "/your_orders": (context) => const YourOrders(),
      },
    );
  }
}
