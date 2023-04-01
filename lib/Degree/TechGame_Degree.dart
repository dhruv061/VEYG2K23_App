import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:vegy2023/Degree/DegreeGameInfo/ScavengerHunt.dart';
import 'package:vegy2023/Degree/DegreeGameInfo/TheCivilSafari.dart';

import '../pages/Nextscreen.dart';
import '../pages/ReusableContainer.dart';
import 'DegreeGameInfo/Talassh.dart';
import 'DegreeGameInfo/Techtainment.dart';

class TechGame_Degree extends StatefulWidget {
  const TechGame_Degree({super.key});

  @override
  State<TechGame_Degree> createState() => _TechGame_DegreeState();
}

class _TechGame_DegreeState extends State<TechGame_Degree> {
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
                    //Games
                    //techtainment
                    ReusableContainer(
                      image: "assets/images/techtainment.jpg",
                      title: "CE/IT- Tech-tainment",
                      entryfees: "60",
                      heading_peding_Left: 14,
                      heading_peding_Top: 110,
                      function: () {
                        nextScreen(context, TechTainment());
                      },
                    ),

                    //Talash
                    ReusableContainer(
                      image: "assets/images/talash.jpg",
                      title: "CE/IT- Talaash-the technical treasure hunt",
                      entryfees: "60",
                      heading_peding_Left: 14,
                      heading_peding_Top: 40,
                      function: () {
                        nextScreen(context, Talassh());
                      },
                    ),

                    //The civil Safari
                    ReusableContainer(
                      image: "assets/images/thecivilsafari.jpg",
                      title: "CL- The Civil Safari",
                      entryfees: "60",
                      heading_peding_Left: 14,
                      heading_peding_Top: 110,
                      function: () {
                        nextScreen(context, TheCivilSafari());
                      },
                    ),

                    //MechanicalDroids
                    ReusableContainer(
                      image: "assets/images/MechanicalDroids.jpg",
                      title: "ME- Scavenger Hunt",
                      entryfees: "60",
                      heading_peding_Left: 14,
                      heading_peding_Top: 110,
                      function: () {
                        nextScreen(context, ScavengerHunt());
                      },
                    ),

                    SizedBox(height: 50),
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
