// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';

import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:vegy2023/pages/CartBadge.dart';
import 'package:vegy2023/pages/CartPage.dart';
import 'package:vegy2023/pages/HomePage.dart';
import 'package:vegy2023/pages/ProfilePage.dart';
import 'package:vegy2023/pages/SignInPage.dart';

import '../Provider/userprovider.dart';
import '../Services/authServices.dart';

class BottonNevBar extends StatefulWidget {
  @override
  State<BottonNevBar> createState() => _BottonNevBarState();
}

class _BottonNevBarState extends State<BottonNevBar> {
  final AuthService authService = AuthService();

  @override
  void initState() {
    print("Init State Start");
    authService.getUserData(context);

    super.initState();
  }

  // final AuthService authService = AuthService();
  // // Provider.of<UserProvider>(context).user.token.isNotEmpty
  // String? token;
  // @override
  // void initState() {
  //   getToken();
  //   super.initState();
  // }

  //defult index
  int selectedindex = 0;

  // //check for user login or not
  // Future getToken() async {
  //   // Get the token from SharedPreferences
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var getToken = prefs.getString('x-auth-token');

  //   if (getToken == null) {
  //     setState(() {
  //       token = '';
  //     });
  //   } else {
  //     setState(() {
  //       token = getToken;
  //     });
  //   }

  //   print("Get token Value: " + getToken!);
  //   print("token is for bottom nev bar :" + token!);
  // }

  // ignore: prefer_final_fields
  static List<Widget> _widgetOptionsDefault = [
    const HomePage(),
    CartPage(),
    const SignInPage(),
  ];

  // static List<Widget> _widgetOptionsProfilePage = [
  //   HomePage(),
  //   CartPage(),
  //   ProfilePage(),
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptionsDefault.elementAt(selectedindex),
        // child: Provider.of<UserProvider>(context).user.token.isEmpty
        //     ? _widgetOptionsDefault.elementAt(selectedindex)
        //     : _widgetOptionsProfilePage.elementAt(selectedindex),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(9),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                color: Colors.black.withOpacity(.3),
              )
            ],
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(23),
                topRight: Radius.circular(23),
                bottomLeft: Radius.circular(23),
                bottomRight: Radius.circular(23)),
          ),
          child: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
              child: GNav(
                // rippleColor: HexColor("#"),
                hoverColor: HexColor("#8198AF"),
                gap: 12,
                activeColor: HexColor("#11145A"),
                iconSize: 24,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                duration: const Duration(milliseconds: 400),
                tabBackgroundColor: HexColor("#BBBDF0"),
                color: HexColor("#8198AF"),
                tabs: [
                  GButton(
                    icon: LineIcons.home,
                    text: 'Home',
                  ),
                  GButton(
                    icon: LineIcons.shoppingBag,
                    text: 'Cart',
                    leading: CartBadge(),
                  ),
                  GButton(
                    icon: LineIcons.user,
                    text: 'Profile',
                  ),
                ],
                selectedIndex: selectedindex,
                onTabChange: (index) {
                  setState(() {
                    selectedindex = index;
                  });
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
