import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:vegy2023/Diploma/DiplomaGameInfo/MultiMediaPrse.dart';
import 'package:vegy2023/Diploma/DiplomaGameInfo/PosterTalk.dart';
import 'package:vegy2023/Diploma/DiplomaGameInfo/ProjectExpo.dart';
import 'package:vegy2023/Diploma/DiplomaGameInfo/SharkTank.dart';
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
                    //Techno Sketch
                    ReusableContainer(
                      image: "assets/images/diploma/technosketch.jpg",
                      title: "Techno Sketch",
                      entryfees: "30",
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
                      entryfees: "30",
                      heading_peding_Left: 14,
                      heading_peding_Top: 78,
                      function: () {
                        nextScreen(context, TechOModel());
                      },
                    ),

                    //PROJECT EXPO
                    ReusableContainer(
                      image: "assets/images/diploma/projectexpo.jpg",
                      title: "Project Expo",
                      entryfees: "40",
                      heading_peding_Left: 14,
                      heading_peding_Top: 110,
                      function: () {
                        nextScreen(context, ProjectExpo());
                      },
                    ),

                    //POSTER TALK
                    ReusableContainer(
                      image: "assets/images/diploma/posterTalk.jpg",
                      title: "Poster Talk",
                      entryfees: "30",
                      heading_peding_Left: 14,
                      heading_peding_Top: 110,
                      function: () {
                        nextScreen(context, PosterTalk());
                      },
                    ),

                    //SHARK TANK
                    ReusableContainer(
                      image: "assets/images/diploma/sharktank.jpg",
                      title: "Shark Tank",
                      entryfees: "20",
                      heading_peding_Left: 14,
                      heading_peding_Top: 110,
                      function: () {
                        nextScreen(context, SharkTank());
                      },
                    ),

                    //MULTI MEDIA PRESENTATION
                    ReusableContainer(
                      image: "assets/images/diploma/multimedia.jpg",
                      title: "Multi Media Presentation",
                      entryfees: "20",
                      heading_peding_Left: 14,
                      heading_peding_Top: 75,
                      function: () {
                        nextScreen(context, MultiMediaPrse());
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
