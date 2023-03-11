import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:vegy2023/Diploma/DiplomaGames.dart';
import 'package:vegy2023/Provider/userprovider.dart';

import 'package:vegy2023/pages/Nextscreen.dart';

import '../Degree/DegreeGames.dart';
import '../Provider/particpationData.dart';
import '../Services/authServices.dart';
import 'CartModel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthService authService = AuthService();

  @override
  void initState() {
    authService.getUserData(context);

    // Retrieve the user data from SharedPreferences
    Provider.of<UserProvider>(context, listen: false).getUserFromPrefs();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //get Data From mongodb using StudentProvider Class
    final user = Provider.of<UserProvider>(context).user;

    //height and width
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: HexColor("#ECECEC"),
        body: SingleChildScrollView(
          child: Column(
            children: [
              //firdt part
              Stack(
                children: [
                  //boottom colour
                  Container(
                    color: HexColor("#F0F0F2"),
                  ),

                  //top color
                  Container(
                    height: height / 3.9,
                    decoration: BoxDecoration(
                      color: HexColor("#11145A"),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(23),
                        bottomRight: Radius.circular(23),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(1),
                          spreadRadius: 2,
                          blurRadius: 8,
                        ),
                      ],
                    ),
                  ),

                  //all title and image in box
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        children: [
                          //Logo
                          Padding(
                            padding: EdgeInsets.only(top: 15, right: 220),
                            child: Container(
                              height: height / 12,
                              width: width / 3.5,
                              decoration: BoxDecoration(
                                // color: Colors.white,
                                image: const DecorationImage(
                                  image: AssetImage("assets/icons/logo2.png"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Container(),
                            ),
                          ),

                          //User Name
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 20, left: 18, right: 100),
                            child: Container(
                              height: height / 20,
                              width: width / 1.5,
                              // color: Colors.white,
                              child: Center(
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    user.token.isEmpty
                                        ? "Hello, User"
                                        : "Hello, ${user.name}",
                                    style: const TextStyle(
                                      fontFamily: 'OpenSanse',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 25,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              // child: Image.asset("assets/icons/logo.png"),
                            ),
                          ),

                          //Headlines
                          Padding(
                            padding: const EdgeInsets.only(right: 142),
                            child: Container(
                              height: height / 20,
                              width: width / 2,
                              // color: Colors.white,
                              child: const Center(
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Welcome to veyg 2k23 ",
                                    style: TextStyle(
                                      fontFamily: 'OpenSanse',
                                      fontWeight: FontWeight.w300,
                                      fontSize: 15,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              // child: Image.asset("assets/icons/logo.png"),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  //image
                  Padding(
                    padding: const EdgeInsets.only(left: 260, top: 15),
                    child: Container(
                      decoration: const BoxDecoration(
                        // color: Colors.white,
                        image: DecorationImage(
                            image: AssetImage("assets/images/person.png"),
                            fit: BoxFit.cover),
                      ),
                      height: height / 4.3,
                      width: width / 3.8,

                      // child: Image.asset("assets/images/person.png"),
                    ),
                  ),
                ],
              ),

              //secound part --> below the blue part
              Container(
                height: 725,
                child: Stack(
                  children: [
                    //Heading --> What will you get?
                    const Padding(
                      padding: EdgeInsets.only(left: 25, top: 20),
                      child: Text(
                        "What will you get?",
                        style: TextStyle(
                          fontFamily: 'OpenSanse',
                          fontWeight: FontWeight.w700,
                          fontSize: 23,
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    //3-boxes-- game - pricemoney - how
                    ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 425, left: 5, right: 10),
                          child: Row(
                            children: [
                              //game
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Container(
                                  height: height / 5,
                                  width: width / 2.7,
                                  decoration: BoxDecoration(
                                    color: HexColor("#FFFFFF"),
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(23),
                                        topRight: Radius.circular(23),
                                        bottomLeft: Radius.circular(23),
                                        bottomRight: Radius.circular(23)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 4,
                                        offset: Offset(1.4, 1.2),
                                      ),
                                    ],
                                  ),
                                  child: Stack(
                                    children: const [
                                      Image(
                                        image:
                                            AssetImage("assets/icons/game.gif"),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: 115, left: 35),
                                        child: Text(
                                          "Games",
                                          style: TextStyle(
                                            fontFamily: 'OpenSanse',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),

                              //price money
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Container(
                                  height: height / 5,
                                  width: width / 2.7,
                                  decoration: BoxDecoration(
                                    color: HexColor("#FFFFFF"),
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(23),
                                        topRight: Radius.circular(23),
                                        bottomLeft: Radius.circular(23),
                                        bottomRight: Radius.circular(23)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 4,
                                        offset: Offset(1.4, 1.2),
                                      ),
                                    ],
                                  ),
                                  child: Stack(
                                    children: const [
                                      Image(
                                        image: AssetImage(
                                            "assets/icons/trophy.gif"),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: 115, left: 13),
                                        child: Text(
                                          "Price money",
                                          style: TextStyle(
                                            fontFamily: 'OpenSanse',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),

                              //How?
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Container(
                                  height: height / 5,
                                  width: width / 2.7,
                                  decoration: BoxDecoration(
                                    color: HexColor("#FFFFFF"),
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(23),
                                        topRight: Radius.circular(23),
                                        bottomLeft: Radius.circular(23),
                                        bottomRight: Radius.circular(23)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 4,
                                        offset: Offset(1.4, 1.2),
                                      ),
                                    ],
                                  ),
                                  child: Stack(
                                    children: const [
                                      Image(
                                        image:
                                            AssetImage("assets/icons/how.gif"),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: 116, left: 39),
                                        child: Text(
                                          "How?",
                                          style: TextStyle(
                                            fontFamily: 'OpenSanse',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 19,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    //heading and all other parts
                    Padding(
                      padding: EdgeInsets.only(top: 250),
                      child: Column(
                        children: [
                          //heding --> Categories,
                          const Padding(
                            padding: EdgeInsets.only(right: 190),
                            child: Text(
                              "Categories",
                              style: TextStyle(
                                fontFamily: 'OpenSanse',
                                fontWeight: FontWeight.w700,
                                fontSize: 23,
                              ),
                            ),
                          ),

                          const SizedBox(height: 19),

                          //Degree Game
                          InkWell(
                            onTap: () {
                              nextScreen(context, const DegreeGames());
                            },
                            child: Center(
                              child: Container(
                                height: height / 4,
                                width: width / 1.09,
                                decoration: BoxDecoration(
                                  color: HexColor("#FFFFFF"),
                                  image: const DecorationImage(
                                      image: AssetImage(
                                          "assets/images/degreestudents.jpg"),
                                      fit: BoxFit.cover),
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(23),
                                      topRight: Radius.circular(23),
                                      bottomLeft: Radius.circular(23),
                                      bottomRight: Radius.circular(23)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 3,
                                      blurRadius: 7,
                                      offset: Offset(8, 7),
                                    ),
                                  ],
                                ),
                                child: Stack(
                                  children: const [
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 15, top: 100),
                                      child: Text(
                                        "Degree Students",
                                        style: TextStyle(
                                          fontFamily: 'OpenSanse',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 28,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 15, top: 140),
                                      child: Text(
                                        "Games that entertain you and combine fun, coding, and logic",
                                        style: TextStyle(
                                          fontFamily: 'OpenSanse',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),

                          //Diploma Game
                          InkWell(
                            onTap: () {
                              nextScreen(context, const DiplomaGames());
                            },
                            child: Center(
                              child: Container(
                                height: height / 4,
                                width: width / 1.09,
                                decoration: BoxDecoration(
                                  color: HexColor("#FFFFFF"),
                                  image: const DecorationImage(
                                      image: AssetImage(
                                          "assets/images/diplomastudents.jpg"),
                                      fit: BoxFit.cover),
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(23),
                                      topRight: Radius.circular(23),
                                      bottomLeft: Radius.circular(23),
                                      bottomRight: Radius.circular(23)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 3,
                                      blurRadius: 7,
                                      offset: Offset(8, 7),
                                    ),
                                  ],
                                ),
                                child: Stack(
                                  children: const [
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 15, top: 100),
                                      child: Text(
                                        "Diploma Students",
                                        style: TextStyle(
                                          fontFamily: 'OpenSanse',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 28,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 15, top: 140),
                                      child: Text(
                                        "A game with lots of pleasure and excitement that will make you nostalgic for your youth",
                                        style: TextStyle(
                                          fontFamily: 'OpenSanse',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 13.5,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // //test
              // TextButton(
              //   child: Text("Btn"),
              //   onPressed: () async {
              //     // // Get the token from SharedPreferences
              //     // SharedPreferences prefs =
              //     //     await SharedPreferences.getInstance();
              //     // var data = prefs.getString('degreeORDiploma');
              //     // // ignore: prefer_interpolation_to_compose_strings
              //     // print(" prefs token is: " + prefs.getString('x-auth-token')!);

              //     // // ignore: prefer_interpolation_to_compose_strings
              //     // print("check degrre or diploma: " + data!);
              //     // // Provider.of<UserProvider>(context, listen: false);

              //     // print("Check for Provider Token is empty : " +
              //     //     Provider.of<UserProvider>(context, listen: false)
              //     //         .user
              //     //         .token
              //     //         .isEmpty
              //     //         .toString());

              //     // print("Data is :");
              //     // final user =
              //     //     Provider.of<UserProvider>(context, listen: false).user;
              //     // print("user token : " + user.token);
              //     // print("user name : " + user.name);
              //     // print("user branch : " + user.branch);

              //     // print("call get user method");
              //     // authService.getUserData(context);
              //     // print("user token : " + user.token);
              //     // print("user name : " + user.name);
              //     // print("user branch : " + user.branch);

              //     // final participateData = ParticipateData();
              //     // print("Data");
              //     // print(participateData.talaashUser1email);
              //     // print(participateData.talaashUser1name);
              //     // print(participateData.talaashUser2email);
              //     // print(participateData.talaashUser2name);
              //     //for getting Total Price

              //     var cart = Provider.of<CartModel>(context, listen: false);
              //     int money = cart.totalPrice.round();
              //     double PayingAmount =
              //         double.parse("${cart.totalPrice}.round()");
              //     double PayingAmount2 = double.parse("${money}");

              //     print("Price is : " + PayingAmount.toString());
              //     print("after parse Price is : " + PayingAmount2.toString());
              //     print("Money Price is : " + money.toString());
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
