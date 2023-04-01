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
import '../../pages/CartPage.dart';
import '../../pages/FirstPage.dart';
import '../../pages/Nextscreen.dart';

class ScavengerHunt extends StatefulWidget {
  @override
  State<ScavengerHunt> createState() => _ScavengerHuntState();
}

class _ScavengerHuntState extends State<ScavengerHunt> {
  bool _isButtonDisabled = false;

  void _handleTap() {
    setState(() {
      _isButtonDisabled = true;
    });

    // Perform button action here
    //add to cart
    var cart = context.read<CartModel>();
    cart.addItem(
      CartItem(name: "ScavengerHunt", price: 60, quantity: 3),
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
                      "Scavenger Hunt",
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
                      const Align(
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
                      const Align(
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
                      const Align(
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
                      const Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 18, top: 5),
                          child: Text(
                            "\n● All the participating teams have to collect all the clues in a sequence.\n\n● There is no break in between the events.\n\n● All the teams have to solve the puzzles to find the next clue.\n\n● A Google form will be shared with all the Participants wherever required.\n\n● There will be an allocation of points for each round and the Highest Point group will be Declared the Winner.\n\n● Rest of the Two top teams will be declared as runner up.\n\n● A team of Volunteers will be there to help and will guide the participants through every event.",
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
                      const Align(
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
                            "Round 1: Crack the Idea (Quizz)",
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
                            "In this round, all the participants had to answer the questions that were asked in the quiz.The quizzes generally divided into sub categories ie (Technical, Aptitude, General knowledge, etc)",
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
                            "Round 2: Identify Me",
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
                            "In this round, all the teams of round 2 will have to identify the given phrase or audio/video and have to Suggest the correct company or Product.",
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
                            "Round: 3 Treasure Hunt",
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
                            "Initially they are given the first clue and thereafter solving it they have to find the remaining clues and solutions, whichever team finds all the clues in minimum time is declared a winner.\n\n● The last team will be Eliminated.\n\n● The top 3 teams with more points will declared as winners.",
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

                  //Cart Button
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
