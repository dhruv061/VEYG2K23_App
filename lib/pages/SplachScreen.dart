import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:vegy2023/pages/FirstPage.dart';
import '../Pages/HomePage.dart';
import 'BootomNevBar.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: AnimatedSplashScreen(
            splash: Image.asset("assets/icons/logo.png"),

            nextScreen: FirstPage(),
            //for image size
            splashIconSize: 250,
            splashTransition: SplashTransition.fadeTransition,
            backgroundColor: HexColor("#F0F0F2"),
            duration: 3000,
          ),
        ),
      ),
    );
  }
}
