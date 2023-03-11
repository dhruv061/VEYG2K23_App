import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:vegy2023/pages/SnackBar.dart';

import '../../Provider/userprovider.dart';
import '../../pages/BootomNevBar.dart';
import '../../pages/CartBadge.dart';
import '../../pages/CartModel.dart';

import '../../pages/FirstPage.dart';
import '../../pages/Nextscreen.dart';

class Dekathone extends StatefulWidget {
  const Dekathone({super.key});

  @override
  State<Dekathone> createState() => _DekathoneState();
}

class _DekathoneState extends State<Dekathone> {
  bool _isButtonDisabled = false;

  void _handleTap() {
    setState(() {
      _isButtonDisabled = true;
    });
    // Perform button action here
    //add to cart
    var cart = context.read<CartModel>();
    cart.addItem(
      CartItem(name: "Dekathon", price: 50, quantity: 4),
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
                      "Dekathon",
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
                    children: [
                      //Team Size
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 18, top: 12),
                          child: Text(
                            "Team Size: 4",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),

                      //No. of Levels
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 18, top: 5),
                          child: Text(
                            "No. of Levels/Round: 4",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),

                      //Instructions/Rules
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 18, top: 5),
                          child: Text(
                            "Instructions/Rules: ",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),

                      //Instructions/Rules Details
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 18, top: 5),
                          child: Text(
                            "\n1.In a group of 4 the team can participate.\n\n2.In the First Round, in each game one member of the team will play. The member cannot be repeated.Five teams will play at a time.\n\n3.Maximum Time Limit for the First Round Games will be 80 Minutes,\ni.e. 20 minutes per 5 teams.\n\n4.1st Day is a First, Qualifying round. Groups qualifying will play on the 2 nd Day in the Final Round.",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              letterSpacing: 0.9,
                            ),
                          ),
                        ),
                      ),

                      //Rounds
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.only(left: 18, top: 18),
                          child: Text(
                            "Rounds ",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),

                      //Round-1 Title
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 18, top: 10),
                          child: Text(
                            "Round: 1",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w600,
                              color: HexColor("#11145A"),
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),

                      //Round-1 Info
                      const Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 18, top: 10),
                          child: Text(
                            "Round-1 has four games.\n\n1. All the participants will play this round separately.\n\n2. The first round has four games:\n\n(i) Sack race (One person)\n(ii)Lame race (One person)\n(iii) Cartons jump (One person)\n(iv) Lemon-Spoon (One person).\n\n3.This is a Group Competition.\n\n4.Each group must have 4 participants",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),

                      //Round-2 Title
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 18, top: 10),
                          child: Text(
                            "Round: 2",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w600,
                              color: HexColor("#11145A"),
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),

                      //Round-2 Info
                      const Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding:
                              EdgeInsets.only(left: 18, top: 10, bottom: 10),
                          child: Text(
                            "This will be a surprise for all",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
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
              padding: EdgeInsets.only(left: 12),
              child: Row(
                children: [
                  //Add Game Button
                  GestureDetector(
                    onTap: () {
                      if (user.token.isEmpty) {
                        openSnackbar(
                            context, 'Please first Signin', Colors.red);
                      } else if (user.diplomaORdegree == 'Degree') {
                        //check for button is alredy pressed or not
                        if (_isButtonDisabled == false) {
                          _handleTap();
                        } else {
                          return null;
                        }
                      } else {
                        openSnackbar(context,
                            "This game only for Degree students", Colors.red);
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
                        nextScreen(context,FirstPage());
                      },
                      icon: CartBadge(),
                      color: Colors.white,
                      iconSize: 40,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
