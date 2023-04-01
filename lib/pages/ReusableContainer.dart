// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hexcolor/hexcolor.dart';

class ReusableContainer extends StatelessWidget {
  String image;
  String title;
  String entryfees;

  double heading_peding_Left;
  double heading_peding_Top;
  Function() function;
  ReusableContainer({
    Key? key,
    required this.image,
    required this.title,
    required this.entryfees,
    required this.heading_peding_Left,
    required this.heading_peding_Top,
    required this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //height and width
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        const SizedBox(height: 15),
        //Games
        InkWell(
          onTap: function,
          child: Center(
            child: Container(
              height: height / 4,
              width: width / 1.09,
              decoration: BoxDecoration(
                color: HexColor("#FFFFFF"),
                image: DecorationImage(
                    image: AssetImage(image), fit: BoxFit.cover),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomLeft: Radius.circular(23),
                    bottomRight: Radius.circular(23)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: Offset(8, 7),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: heading_peding_Left, top: heading_peding_Top),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontFamily: 'OpenSanse',
                        fontWeight: FontWeight.w600,
                        fontSize: 28,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15, top: 150),
                    child: Text(
                      "Entry fee : ₹${entryfees}",
                      style: TextStyle(
                        fontFamily: 'OpenSanse',
                        fontWeight: FontWeight.w400,
                        fontSize: 17,
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
    );
  }
}
