import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:vegy2023/Diploma/DiplomaGameInfo/GullyCricket.dart';
import 'package:vegy2023/Diploma/DiplomaGameInfo/OneMinuteGame.dart';
import 'package:vegy2023/Diploma/DiplomaGameInfo/VadicMaths.dart';

import '../pages/Nextscreen.dart';
import '../pages/ReusableContainer.dart';

class NonTechGame_Diploma extends StatefulWidget {
  const NonTechGame_Diploma({super.key});

  @override
  State<NonTechGame_Diploma> createState() => _NonTechGame_DiplomaState();
}

class _NonTechGame_DiplomaState extends State<NonTechGame_Diploma> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: HexColor("#F0F0F2"),
        body: Center(
          child: Container(
            // color: Colors.yellow,
            height: height,
            width: width / 1.05,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    //Game
                    //Gully Cricket
                    ReusableContainer(
                      image: "assets/images/diploma/gullyCricket.jpg",
                      title: "Gully Cricket",
                      entryfees: "20",
                      heading_peding_Left: 14,
                      heading_peding_Top: 110,
                      function: () {
                        nextScreen(context, GullyCricket());
                      },
                    ),

                    //VADIC MATHS
                    ReusableContainer(
                      image: "assets/images/diploma/vadicmath.jpg",
                      title: "Vedic Maths",
                      entryfees: "10",
                      heading_peding_Left: 14,
                      heading_peding_Top: 110,
                      function: () {
                        nextScreen(context, VadicMaths());
                      },
                    ),

                    //1-MINUTE GAME
                    ReusableContainer(
                      image: "assets/images/diploma/oneminutegame.jpg",
                      title: "1-Minute Game",
                      entryfees: "20",
                      heading_peding_Left: 14,
                      heading_peding_Top: 110,
                      function: () {
                        nextScreen(context, OneMinuteGame());
                      },
                    ),

                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
