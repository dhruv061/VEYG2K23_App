import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vegy2023/models/paymentHistoryModel.dart';
import 'package:vegy2023/pages/AdminPage.dart';
import 'package:vegy2023/pages/AdminPageDegree.dart';
import 'package:vegy2023/pages/FirstPage.dart';
import 'package:vegy2023/pages/Nextscreen.dart';
import 'package:vegy2023/pages/paymentHistory.dart';
import '../Provider/userprovider.dart';
import 'SnackBar.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    //get Data From mongodb using StudentProvider Class
    final user = Provider.of<UserProvider>(context).user;

    //height and width
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: HexColor("#F0F0F2"),
        //appbar
        appBar: AppBar(
          backgroundColor: HexColor("#F0F0F2"),
          elevation: 0,
        ),

        //body part
        body: user.uid == "641f1ef410e9665b5a14fa85" ||
                user.uid == "641f1f3c10e9665b5a14fa88"
            ? AdminPage()
            : SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      //Profile -heading Box
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
                                  color: Colors.grey.withOpacity(0.6),
                                  spreadRadius: 3,
                                  blurRadius: 8,
                                ),
                              ],
                            ),
                            child: const Center(
                              child: Text(
                                "Profile",
                                style: TextStyle(
                                  fontFamily: 'OpenSanse',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 38,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      //user Data
                      Center(
                        child: Container(
                          height: height / 4,
                          width: width / 1.09,
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
                                spreadRadius: 3,
                                blurRadius: 7,
                                offset: Offset(8, 7),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  //for user Data
                                  Container(
                                    height: height / 4,
                                    width: width / 1.7,
                                    decoration: const BoxDecoration(
                                      // color: Colors.yellow,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(23),
                                        bottomLeft: Radius.circular(23),
                                      ),
                                    ),

                                    //data
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: Column(
                                        children: [
                                          //name
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 12, left: 17),
                                            child: Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                user.name,
                                                style: const TextStyle(
                                                  fontFamily: 'OpenSanse',
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 25,
                                                ),
                                              ),
                                            ),
                                          ),

                                          //email
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 3, left: 17),
                                            child: Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                user.email,
                                                style: const TextStyle(
                                                  fontFamily: 'OpenSanse',
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 17,
                                                ),
                                              ),
                                            ),
                                          ),

                                          //mobile No
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 3, left: 17),
                                            child: Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                user.phoneno,
                                                style: const TextStyle(
                                                  fontFamily: 'OpenSanse',
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 17,
                                                ),
                                              ),
                                            ),
                                          ),

                                          //uid
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 4, left: 17),
                                            child: Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                "uid : ${user.uid}",
                                                style: const TextStyle(
                                                  fontFamily: 'OpenSanse',
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 17,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  //for Logo
                                  Container(
                                    height: height / 4,
                                    width: width / 3.04,
                                    decoration: const BoxDecoration(
                                      // color: Colors.red,
                                      image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/person.png"),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(23),
                                        bottomRight: Radius.circular(23),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 15),

                      //Payment History Button
                      Container(
                        alignment: Alignment.center,
                        padding:
                            const EdgeInsets.only(top: 15, left: 15, right: 15),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: HexColor("#FF7F5D"),
                            textStyle: const TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w600,
                              fontSize: 26,
                              color: Colors.white,
                            ),
                            minimumSize: const Size.fromHeight(55),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 27,
                                width: 27,
                                child: Icon(
                                  Icons.history,
                                  size: 35,
                                ),
                              ),
                              SizedBox(width: 18),
                              Text(
                                "Payment History",
                                style: TextStyle(
                                  fontFamily: 'OpenSanse',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 23,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                          onPressed: () {
                            nextScreen(context, PaymentHistoryPage());
                          },
                        ),
                      ),

                      //Logout Button
                      Container(
                        alignment: Alignment.center,
                        padding:
                            const EdgeInsets.only(top: 10, left: 15, right: 15),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: HexColor("#11145A"),
                            textStyle: const TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w600,
                              fontSize: 26,
                              color: Colors.white,
                            ),
                            minimumSize: const Size.fromHeight(55),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              SizedBox(
                                height: 27,
                                width: 27,
                                child: Icon(
                                  Icons.logout,
                                  size: 35,
                                ),
                              ),
                              SizedBox(width: 18),
                              Text(
                                "Log out",
                                style: TextStyle(
                                  fontFamily: 'OpenSanse',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 23,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                          onPressed: () async {
                            //logout and clear token
                            try {
                              // clear user data when the user logs out
                              Provider.of<UserProvider>(context, listen: false)
                                  .clearUser();

                              // navigate back to the login screen
                              nextScreen(context, FirstPage());
                            } catch (e) {
                              openSnackbar(context, e.toString(), Colors.red);
                            }
                          },
                        ),
                      ),

                      SizedBox(height: 20),

                      // //Saffrony logo
                      // Image.asset("assets/icons/saffronylogo.png"),

                      //Saffrony logo
                      Padding(
                        padding: const EdgeInsets.only(top: 20, left: 8),
                        child: Center(
                          child: Container(
                            height: height / 9,
                            width: width / 1.5,
                            decoration: BoxDecoration(
                              image: const DecorationImage(
                                image:
                                    AssetImage("assets/icons/saffronylogo.png"),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Container(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
