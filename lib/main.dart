import 'package:flutter/material.dart';
import 'package:vegy2023/pages/BootomNevBar.dart';
import 'package:vegy2023/pages/CartModel.dart';
import 'package:vegy2023/pages/CartPage.dart';
import 'package:vegy2023/pages/FirstPage.dart';
import 'package:vegy2023/pages/HomePage.dart';
import 'package:provider/provider.dart';
import 'package:vegy2023/pages/ProfilePage.dart';
import 'package:vegy2023/pages/SignInPage.dart';
import 'package:vegy2023/pages/SplachScreen.dart';

import 'Provider/InternetProvider.dart';

import 'Provider/userprovider.dart';
import 'Services/authServices.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //for add to cart system
        ChangeNotifierProvider(
          create: (_) => CartModel(),
        ),

        //for check internet connectivity
        ChangeNotifierProvider(
          create: ((context) => InternetProvider()),
        ),

        //for cget user data when user login
        ChangeNotifierProvider(
          create: ((context) => UserProvider()),
        ),
      ],

      //for home page
      child: MaterialApp(
        home: SplashScreen(),
      ),
    );
  }
}
