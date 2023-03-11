import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:vegy2023/Diploma/DiplomaGameInfo/TechOModel.dart';
import 'package:vegy2023/Diploma/DiplomaGameInfo/TechnoSketch.dart';

import '../pages/Nextscreen.dart';
import '../pages/ReusableContainer.dart';

class TechGame_Diploma extends StatefulWidget {
  const TechGame_Diploma({super.key});

  @override
  State<TechGame_Diploma> createState() => _TechGame_DiplomaState();
}

class _TechGame_DiplomaState extends State<TechGame_Diploma> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: HexColor("#F0F0F2"),
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              // color: Colors.yellow,
              height: height,
              width: width / 1.05,
              child: Center(
                child: Column(
                  children: [
                    //Games

                    //Techno Sketch
                    ReusableContainer(
                      image: "assets/images/diploma/technosketch.jpg",
                      title: "Techno Sketch",
                      heading_peding_Left: 14,
                      heading_peding_Top: 110,
                      function: () {
                        nextScreen(context, TechnoSketch());
                      },
                    ),

                    //Tech-O-Model/Best From Waste
                    ReusableContainer(
                      image: "assets/images/diploma/TechOModel.jpg",
                      title: "Tech-O-Model/Best From Waste",
                      heading_peding_Left: 14,
                      heading_peding_Top: 78,
                      function: () {
                        nextScreen(context, TechOModel());
                      },
                    ),
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
