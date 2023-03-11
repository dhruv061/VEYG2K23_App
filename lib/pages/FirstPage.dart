//this is first page show after splach screen
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:vegy2023/Services/authServices.dart';

import '../Provider/userprovider.dart';
import 'BootomNevBar.dart';
import 'BootomNevBarAfterLogin.dart';

class FirstPage extends StatefulWidget {
  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  final AuthService authService = AuthService();

  @override
  void initState() {
    print("Init State Start");
    authService.getUserData(context);

    // Retrieve the user data from SharedPreferences
    Provider.of<UserProvider>(context, listen: false).getUserFromPrefs();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Provider.of<UserProvider>(context).user.token.isNotEmpty
          ? BottonNevBarAfterLogin()
          : BottonNevBar(),
    );
  }
}
