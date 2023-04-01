import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hexcolor/hexcolor.dart';

import '../pages/Nextscreen.dart';
import '../pages/ReusableContainer.dart';
import 'DegreeGameInfo/Dekathon.dart';
import 'DegreeGameInfo/OfficeTennis.dart';

class NonTechGame_Degree extends StatefulWidget {
  const NonTechGame_Degree({super.key});

  @override
  State<NonTechGame_Degree> createState() => _NonTechGame_DegreeState();
}

class _NonTechGame_DegreeState extends State<NonTechGame_Degree> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: HexColor("#F0F0F2"),
      body: Center(
        child: Container(
          // color: Colors.yellow,
          height: height,
          width: width / 1.05,
          child: Center(
            child: Column(
              children: [
                //Dekathon
                ReusableContainer(
                  image: "assets/images/deckathon.png",
                  title: "Dekathon",
                  entryfees: "60",
                  heading_peding_Left: 14,
                  heading_peding_Top: 110,
                  function: () {
                    nextScreen(context, Dekathone());
                  },
                ),

                //office tennis
                ReusableContainer(
                  image: "assets/images/officetennis.jpg",
                  title: "Office Tennis",
                  entryfees: "60",
                  heading_peding_Left: 14,
                  heading_peding_Top: 110,
                  function: () {
                    nextScreen(context, OfficeTennis());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
