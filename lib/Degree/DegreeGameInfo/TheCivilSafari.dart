import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:vegy2023/pages/CartBadge.dart';
import 'package:vegy2023/pages/Nextscreen.dart';

import '../../Provider/userprovider.dart';
import '../../pages/BootomNevBar.dart';
import '../../pages/CartModel.dart';
import '../../pages/FirstPage.dart';
import '../../pages/SnackBar.dart';

class TheCivilSafari extends StatefulWidget {
  const TheCivilSafari({super.key});

  @override
  State<TheCivilSafari> createState() => _TheCivilSafariState();
}

class _TheCivilSafariState extends State<TheCivilSafari> {
  bool _isButtonDisabled = false;

  void _handleTap() {
    setState(() {
      _isButtonDisabled = true;
    });
    // Perform button action here
    //add to cart
    var cart = context.read<CartModel>();
    cart.addItem(
      CartItem(name: "TheCivilSafari", price: 60, quantity: 3),
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
                  child: Center(
                    child: Text(
                      "The Civil Safari",
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
                            "Team Size: 3",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),

                      //Entry Fee
                      const Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 18, top: 12),
                          child: Text(
                            "Entry Fee: 60",
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
                            "No. of Levels/Round: 3",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),

                      //prize money
                      const Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 18, top: 12),
                          child: Text(
                            "Prize money is based on the number of teams that have registered for any event.",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w600,
                              color: Colors.red,
                              fontSize: 15,
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
                            "\n1. Since this year’s VEYG theme is line with “Connecting with PEOPLE”, our focus will be on having Fun Without the Internet, cell phones, or any other digital gadgets and have deep discussions with our team members instead. Hence none of these will be permitted during all three rounds of The Civil Safari. \n\n2.Participants are free to ask volunteers and any other personnel on ground for help but only in level 1. No external help or suggestions are allowed in levels 2 & 3.",
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
                            "Round 1: Dhoondte reh jaoge",
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
                            "This round is our usual treasure hunt where teams will be given tasks on completion of which they shall recieve the clue of the next location and so on. There are a total of 14 locations that have been decided for the expected number of 20 teams. This level will be full of energy, enthusiasm, fun and healthy competition. \n\nThe treasure hunt will be designed in such a way that it shall finish in under 45 minutes.",
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
                            "Round 2: Quizzeria",
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
                          padding: EdgeInsets.only(left: 18, top: 10),
                          child: Text(
                            "In this level, the remaining 16 teams will be required to solve a quiz within 45 minutes. Each team will be presented with a set of questions that are intended to challenge their knowledge and expertise in the civil engineering field. \n\nTo successfully complete this level, teams will need to work together effectively and use their collective knowledge and skills to answer as many questions as possible within the allotted time. The 4 teams that score the highest number of points at the end of the Quizzeria round will advance to the next and the final level of the competition.",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),

                      //Round-3 Title
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 18, top: 10),
                          child: Text(
                            "Round: 3",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w600,
                              color: HexColor("#11145A"),
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),

                      //Round-3 Info
                      const Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding:
                              EdgeInsets.only(left: 18, top: 10, bottom: 15),
                          child: Text(
                            "Surprise Round \n\nWho doesn’t like surprises? The organizers have something exciting in store for this level, and they are keeping it a secret! The level name might give you a clue, but if you can't guess it, that's okay! It's all part of the fun and excitement of the competition. \n\nThis surprise level is designed to add an extra layer of excitement and unpredictability to the competition. It's a chance for the teams to show their flexibility and adaptability in the face of the unknown. Who knows what the organizers have in store? One thing is for sure, it's going to be an adventure that you won't want to miss! \n\nSo, are you ready to take on the challenge and see what surprises await you in this level? Get your game face on and register for the event now!",
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
              padding: const EdgeInsets.only(left: 12),
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
          ],
        ),
      ),
    );
  }
}
