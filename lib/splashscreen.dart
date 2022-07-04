import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/services.dart';
import 'package:flutterscanner/User/dashboard.dart';
import 'package:flutterscanner/User/dashdrawer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var emailPref;
  void getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var email = preferences.getString("email");
    if (email == null) {
      emailPref = null;
    } else {
      emailPref = email;
    }
  }

  @override
  void initState() {
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      duration: 3000,
      splashIconSize: 500,
      splash: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Icon(
            Icons.document_scanner_outlined,
            color: Colors.white,
            size: 80,
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            "Flutter Scanner",
            style: TextStyle(fontSize: 45, color: Colors.white),
          ),
        ],
      ),
      nextScreen: emailPref == null ? const HomePage() : const Dashboard(),
      splashTransition: SplashTransition.slideTransition,
      //pageTransitionType: PageTransitionType.leftToRightPop,
      backgroundColor: const Color.fromARGB(255, 212, 30, 17),
    );
  }
}
