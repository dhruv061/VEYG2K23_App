import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

import '../../Provider/userprovider.dart';
import '../../pages/BootomNevBar.dart';
import '../../pages/CartBadge.dart';
import '../../pages/CartModel.dart';
import '../../pages/FirstPage.dart';
import '../../pages/Nextscreen.dart';
import '../../pages/SnackBar.dart';

class PosterTalk extends StatefulWidget {
  const PosterTalk({super.key});

  @override
  State<PosterTalk> createState() => _PosterTalkState();
}

class _PosterTalkState extends State<PosterTalk> {
  bool _isButtonDisabled = false;

  void _handleTap() {
    setState(() {
      _isButtonDisabled = true;
    });
    // Perform button action here
    //add to cart
    var cart = context.read<CartModel>();
    cart.addItem(
      CartItem(name: "PosterTalk", price: 30, quantity: 1),
    );
  }

  @override
  void initState() {
    // Retrieve the user data from SharedPreferences
    Provider.of<UserProvider>(context, listen: false).getUserFromPrefs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //get Data From mongodb using StudentProvider Class --> check for is student degrre or diploma
    final user = Provider.of<UserProvider>(context).user;
    //height and width
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: HexColor("#F0F0F2"),
      //appbar
      appBar: AppBar(
        backgroundColor: HexColor("#F0F0F2"),
        elevation: 0,
        title: const Padding(
          padding: EdgeInsets.only(left: 35),
          child: Text(
            "Game Details",
            style: TextStyle(
                fontFamily: 'OpenSanse',
                fontWeight: FontWeight.w600,
                fontSize: 23,
                color: Colors.black),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 30,
            color: Colors.black,
          ),
        ),
      ),

      //body part
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 15),

            //first Heading Box
            Padding(
              padding: const EdgeInsets.only(top: 13),
              child: Center(
                child: Container(
                  height: height / 9,
                  width: width / 1.1,
                  decoration: BoxDecoration(
                    color: HexColor("#11145A"),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Text(
                      "Poster Talk",
                      style: TextStyle(
                        fontFamily: 'OpenSanse',
                        fontWeight: FontWeight.w600,
                        fontSize: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 15),

            //Info Box
            Center(
              child: Container(
                height: height / 1.70,
                width: width / 1.1,
                decoration: BoxDecoration(
                  color: HexColor("#D9D9D9"),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 229, 224, 224)
                          .withOpacity(0.9),
                      spreadRadius: 2,
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(top: 150, left: 8),
                        child: Text(
                          "In this event student make the poster on any Technical or non technical topic and topic would be selected  by studnents them self . student also give presentaion on their poster",
                          style: TextStyle(
                            fontFamily: 'OpenSanse',
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 15),

            //Add to cart Button & Add Game Button
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Row(
                children: [
                  //Add Game Button
                  GestureDetector(
                    onTap: () {
                      if (user.token.isEmpty) {
                        openSnackbar(
                            context, 'Please first Signin', Colors.red);
                      } else if (user.diplomaORdegree == 'Diploma') {
                        if (user.sem == '02' || user.sem == '2') {
                          //check for button is alredy pressed or not
                          if (_isButtonDisabled == false) {
                            _handleTap();
                          } else {
                            return null;
                          }
                        } else {
                          openSnackbar(
                              context,
                              "This game only for Diploma 2 Sem students",
                              Colors.red);
                        }
                      } else {
                        openSnackbar(context,
                            "This game only for Diploma students", Colors.red);
                      }
                    },
                    child: Container(
                      height: height / 14,
                      width: width / 1.4,
                      decoration: BoxDecoration(
                        color: _isButtonDisabled
                            ? HexColor("#F4A28D")
                            : HexColor("#FF7F5D"),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            spreadRadius: 2,
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 35),
                            height: 38,
                            width: 38,
                            // color: Colors.yellow,
                            child: Image.asset("assets/icons/addgame.gif"),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              "Add Game",
                              style: TextStyle(
                                fontFamily: 'OpenSanse',
                                fontWeight: FontWeight.w600,
                                fontSize: 25,
                                color: HexColor("#252B3B"),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(width: 11),

                  //Add to Cart Button
                  Container(
                    height: height / 14,
                    width: width / 5,
                    decoration: BoxDecoration(
                      color: HexColor("#252B3B"),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.4),
                          spreadRadius: 2,
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: IconButton(
                      onPressed: () {
                        nextScreen(context, FirstPage());
                      },
                      icon: CartBadge(),
                      color: Colors.white,
                      iconSize: 40,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
