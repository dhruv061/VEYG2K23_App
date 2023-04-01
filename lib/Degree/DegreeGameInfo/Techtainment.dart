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

class TechTainment extends StatefulWidget {
  const TechTainment({super.key});

  @override
  State<TechTainment> createState() => _TechTainmentState();
}

class _TechTainmentState extends State<TechTainment> {
  bool _isButtonDisabled = false;

  void _handleTap() {
    setState(() {
      _isButtonDisabled = true;
    });

    // Perform button action here
    //add to cart
    var cart = context.read<CartModel>();
    cart.addItem(
      CartItem(name: "Tech-Tainment", price: 60, quantity: 3),
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
            "Process",
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
                      "Tech-tainment",
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
                            "\nPrerequisites: \n1.basic of C language\n\n2.Not use smartphone or any other  electric device during game to find solution (except given pc) \n\n 3.Willingness to give a try",
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
                            "Round 1: Code Clash",
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
                            "In this round, the team will only have two players. They will be situated so they cannot see each other's faces.\n\nTask: Player 1 will be given a clue, which they must solve. Player 2 will locate the piece of code from a different GitHub repository and create one program in accordance with the outcomes of the clues.\n\nThis round is time base round. After the task is complete, the time will be recorded, and this round's time limit is 5 minutes.",
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
                            "Round 2: Code-Tainment",
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
                            "In this round, the game will be played by another 2 players (1 player new that not played in round-1).\n\nTask: Players 1 and 2 will work together to solve a clue for each team that contains three different numbers. Based on the results of the search, locate the pieces of code from several GitHub repositories and create a single program. This software outputs a single integer between the ranges of 1 and 10. After receiving the program's output, player 1 receives a cheat based on the number, and this includes a series or movie dialogue.\n\nPlayer-1 will inform Player-2 of the movie or series' name and the specific scene from which it is taken. Player-2 will then write this movie or series name in PC without spelling mistakes.",
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
                            "Round: 3 Geo-Coder",
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
                            "This will be a surprise for all.",
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
