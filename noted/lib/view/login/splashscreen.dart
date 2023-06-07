import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:noted/view/login/login.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Noted',
      home: AnimatedSplashScreen(
        duration: 1500,
        splash: Column(
          children: [
            Image.asset(
              'assets/images/logo-white.png',
              width: 300,
            ),
            const SizedBox(height: 110),
          ],
        ),
        nextScreen: const Login(),
        backgroundColor: Colors.white,
        splashTransition: SplashTransition.fadeTransition,
        pageTransitionType: PageTransitionType.fade,
        splashIconSize: 410,
        animationDuration: const Duration(seconds: 1),
      ),
    );
  }
}
