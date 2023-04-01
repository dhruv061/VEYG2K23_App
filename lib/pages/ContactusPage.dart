import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:vegy2023/pages/SnackBar.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({super.key});

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  //for RoundedLoadingButton Controller
  final RoundedLoadingButtonController emailBtnController =
      RoundedLoadingButtonController();

  //method for check internet conection
  void checkInternetConnection(
      ConnectivityResult internetConnection, String url) {
    // inside if condition is true then Internet is off otherwise is on
    if (internetConnection == ConnectivityResult.none) {
      openSnackbar(context, "Check your internet connection", Colors.red);
    } else {
      //open all the link
      launchUrlString(url);
    }
  }

  @override
  Widget build(BuildContext context) {
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
          padding: EdgeInsets.only(left: 50),
          child: Text(
            "Contact Us",
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
      body: Column(
        children: [
          SizedBox(height: 5),

          //Image
          Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              height: height / 1.2,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 8,
                  ),
                ],
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    //VEYG logo and first Heading Box
                    Padding(
                      padding: const EdgeInsets.only(top: 13),
                      child: Center(
                        child: Container(
                          height: height / 3,
                          width: width / 1.5,
                          decoration: BoxDecoration(
                            image: const DecorationImage(
                              image: AssetImage("assets/icons/contactus.gif"),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Container(),
                        ),
                      ),
                    ),

                    //heading --> "We are always here to help you."
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text(
                          "We are always here to help you",
                          style: TextStyle(
                            fontFamily: 'OpenSanse',
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                            color: HexColor("#11145A"),
                          ),
                        ),
                      ),
                    ),

                    // heading-2
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 25, top: 10),
                        child: Text(
                          "If you encounter any issues, please don't hesitate to contact us. We will do our best to assist you in resolving them",
                          style: TextStyle(
                            fontFamily: 'OpenSanse',
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 30),

                    //Email Button
                    RoundedLoadingButton(
                      onPressed: () {
                        //open email
                        launchUrlString(
                            'mailto:mavanidhruv132@gmail.com?subject=VEYG-2K23 Help-Center &body=How May I Help You?');
                      },
                      controller: emailBtnController,
                      successColor: HexColor("#22E183"),
                      loaderSize: 25,
                      loaderStrokeWidth: 2.5,
                      width: MediaQuery.of(context).size.width * 0.80,
                      elevation: 0,
                      borderRadius: 25,
                      color: HexColor("#11145A"),
                      valueColor: Colors.white,
                      child: Wrap(
                        children: [
                          Icon(Icons.email_outlined),
                          SizedBox(width: 10),
                          Padding(
                            padding: EdgeInsets.only(top: 1),
                            child: Text(
                              'Contact now',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'OpenSanse',
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 80),

                    //line
                    Divider(
                      color: Colors.grey,
                    ),

                    //Developed By Heading
                    Center(
                      child: Text(
                        "Developed By",
                        style: TextStyle(
                          fontFamily: 'OpenSanse',
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                    ),

                    //name
                    Center(
                      child: Text(
                        "Dhruv Mavani",
                        style: TextStyle(
                          fontFamily: 'OpenSanse',
                          fontWeight: FontWeight.w600,
                          fontSize: 30,
                          color: HexColor("#11145A"),
                        ),
                      ),
                    ),

                    //Privacy Policy
                    Center(
                      child: TextButton(
                        onPressed: () async {
                          //for check internet Conection
                          final internetConnection =
                              await Connectivity().checkConnectivity();
                          checkInternetConnection(internetConnection,
                              "https://www.freeprivacypolicy.com/live/8e804aa8-0017-4bcd-8c3a-d8c923a95bb0");
                        },
                        child: Text(
                          "Privacy Policy",
                          style: TextStyle(
                            fontFamily: 'OpenSanse',
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
