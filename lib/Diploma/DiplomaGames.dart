import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:vegy2023/Diploma/NonTechGame_Diploma.dart';
import 'package:vegy2023/Diploma/TechGame_Diploma.dart';

class DiplomaGames extends StatefulWidget {
  const DiplomaGames({super.key});

  @override
  State<DiplomaGames> createState() => _DiplomaGamesState();
}

class _DiplomaGamesState extends State<DiplomaGames> {
  // List of Tab Bar Item
  List<String> items = [
    "Tech Event",
    "Non-Tech Event",
  ];

  // List of body for Tab Bar
  List<Widget> TabPage = [TechGame_Diploma(), NonTechGame_Diploma()];

  int current = 0;

  //Use for in tab bar page changes
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: HexColor("#F0F0F2"),
      //appbar
      appBar: AppBar(
        backgroundColor: HexColor("#F0F0F2"),
        elevation: 0,
        title: const Padding(
          padding: EdgeInsets.only(left: 35),
          child: Text(
            "Diploma Events",
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
            //heading Box
            Padding(
              padding: const EdgeInsets.only(top: 13),
              child: Center(
                child: Container(
                  height: height / 9,
                  width: width / 1.1,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                        image:
                            AssetImage("assets/images/diplomagamebanner.jpg"),
                        fit: BoxFit.cover),
                    // color: HexColor("#11145A"),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.6),
                        spreadRadius: 3,
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Text(
                      "Let's play at VEYG",
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

            //Tab Bar
            Container(
              margin: const EdgeInsets.only(top: 13),
              height: 60,
              // alignment: Alignment.center,
              child: ListView.builder(
                  // physics: const BouncingScrollPhysics(),
                  itemCount: 2,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              current = index;
                              _pageController.jumpToPage(index);
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.all(5),
                            width: width / 2.1,
                            height: 45,
                            decoration: BoxDecoration(
                              color: current == index
                                  ? HexColor("#8488DF")
                                  : HexColor("#C9CBF3"),
                              borderRadius: current == index
                                  ? BorderRadius.circular(15)
                                  : BorderRadius.circular(10),
                              border: current == index
                                  ? Border.all(
                                      color: HexColor("#11145A"), width: 2)
                                  : null,
                            ),
                            child: Center(
                              child: Text(
                                items[index],
                                style: TextStyle(
                                  fontFamily: 'OpenSanse',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 17,
                                  color: current == index
                                      ? Colors.black
                                      : const Color.fromARGB(255, 99, 93, 93),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
            ),

            //body Part of Tab-1 and Tab-2
            Expanded(
              child: PageView(
                controller: _pageController,
                children: TabPage,
                onPageChanged: (index) {
                  setState(() {
                    current = index;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
