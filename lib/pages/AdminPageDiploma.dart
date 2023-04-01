import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

import '../Provider/InternetProvider.dart';
import '../Provider/userprovider.dart';
import '../Services/authServices.dart';
import '../models/PaymentDetailsDegree.dart';
import '../models/PaymentDetailsDiploma.dart';
import '../models/paymentHistoryModel.dart';
import 'FirstPage.dart';
import 'Nextscreen.dart';
import 'SnackBar.dart';

class AdminPageDiploma extends StatefulWidget {
  const AdminPageDiploma({super.key});

  @override
  State<AdminPageDiploma> createState() => _AdminPageDiplomaState();
}

class _AdminPageDiplomaState extends State<AdminPageDiploma> {
  //for loading indicator
  bool isLoading = false;
  bool isLoadingUpdatePaymentStautus = false;

  //for check validation
  final formKey = GlobalKey<FormState>();

  //Text Editing Controller
  final cuponCodeController = TextEditingController();

  @override
  void dispose() {
    cuponCodeController.dispose();

    super.dispose();
  }

  //for mongodb
  final AuthService authService = AuthService();

  //For Diploma
  //get Payment Details for Diploma method
  List<DiplomaPaymentDetails> paymentDetailsDiploma = [];
  void paymentsDetailsDiploma() async {
    final ip = context.read<InternetProvider>();
    await ip.checkInternetConnection();

    //for checking Internet
    if (ip.hasInternet == false) {
      openSnackbar(context, "Check your internet connection", Colors.red);
    } else {
      //Call API using that we fetch payments Details
      List<DiplomaPaymentDetails> paymentDetailsDiploma =
          await authService.getPaymentDetailsForAdminDiploma(
        context: context,
        cuponCode: cuponCodeController.text,
      );

      setState(() {
        this.paymentDetailsDiploma = paymentDetailsDiploma;
      });
    }
  }

  //Update Payment Stauts --> Degree
  void UpdatePaymentStutasDegree() async {
    final ip = context.read<InternetProvider>();
    await ip.checkInternetConnection();

    //for checking Internet
    if (ip.hasInternet == false) {
      openSnackbar(context, "Check your internet connection", Colors.red);
    } else {
      //Call API using that we can Update Payment Status for Degree
      authService.UpdatePaymentStatusDiploma(
        context: context,
        cuponCode: cuponCodeController.text,
        paymentStatus: "Success",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    //for get user data
    final user = Provider.of<UserProvider>(context).user;

    //height and width
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: HexColor("#F0F0F2"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Admin Page -heading Box
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
                      "Diploma Admin",
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

            //Get User PaymentDetails Using Coupen Code
            //form
            Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  children: [
                    //copon code
                    TextFormField(
                      controller: cuponCodeController,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: Icon(
                          LineIcons.code,
                          color: HexColor("#11145A"),
                        ),
                        hintText: "6 digit Copoun code",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(2)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: HexColor("#11145A")),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),

                      //for validation
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter coupon code";
                        } else if (value.length != 6) {
                          return " coupon code must be 6 characters long";
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 8),

                    //Get Payment Data Button
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(20),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: HexColor("#11145A"),
                          textStyle: const TextStyle(
                            fontFamily: 'OpenSanse',
                            fontWeight: FontWeight.w600,
                            fontSize: 28,
                            color: Colors.white,
                          ),
                          minimumSize: const Size.fromHeight(55),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: isLoading == true
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  SizedBox(
                                    height: 27,
                                    width: 27,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(width: 18),
                                  Text(
                                    "Please Wait",
                                    style: TextStyle(
                                      fontFamily: 'OpenSanse',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 23,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              )
                            : Text("Get Data"),
                        onPressed: () {
                          setState(() {
                            isLoading = true;
                          });

                          if (formKey.currentState!.validate()) {
                            Future.delayed(
                              Duration(seconds: 3),
                              () {
                                //fetch payment Datils from Database

                                paymentsDetailsDiploma();

                                //end loading
                                setState(() {
                                  isLoading = false;
                                });
                              },
                            );
                          }
                        },
                      ),
                    ),

                    //Payment Details & update Payment Status btn
                    Container(
                      height: 250,
                      child: ListView.builder(
                        itemCount: paymentDetailsDiploma.length,
                        itemBuilder: (context, index) {
                          DiplomaPaymentDetails paymentDetail =
                              paymentDetailsDiploma[index];

                          return Column(
                            children: [
                              //for payment Deatils -- For Degree

                              Container(
                                height: height / 1.8,
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
                                child: Stack(
                                  children: [
                                    //amount
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 20, top: 10),
                                      child: Text(
                                        "₹ ${paymentDetail.amount}",
                                        style: TextStyle(
                                          fontFamily: 'OpenSanse',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 28,
                                          color: HexColor("#11145A"),
                                        ),
                                      ),
                                    ),

                                    //cupon Code
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 20, top: 50),
                                      child: Text(
                                        "CopounCode: ${paymentDetail.cuponCode}",
                                        style: TextStyle(
                                          fontFamily: 'OpenSanse',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),

                                    //payment status
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 20, top: 70),
                                      child: Text(
                                        "paymentStatus: ${paymentDetail.paymentStatus}",
                                        style: TextStyle(
                                          fontFamily: 'OpenSanse',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),

                                    //Register date&time
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 20, top: 90),
                                      child: Text(
                                        "Registeration done at: ${paymentDetail.timeDate}",
                                        style: TextStyle(
                                          fontFamily: 'OpenSanse',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),

                                    //userId
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 20, top: 110),
                                      child: Text(
                                        "User id: ${paymentDetail.userId}",
                                        style: TextStyle(
                                          fontFamily: 'OpenSanse',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),

                                    //Divider
                                    Padding(
                                      padding: const EdgeInsets.only(top: 130),
                                      child: Divider(
                                        color: Colors.grey,
                                        thickness: 1,
                                      ),
                                    ),

                                    //leader name
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 20, top: 140),
                                      child: Text(
                                        "Leader name: ${paymentDetail.playername}",
                                        style: TextStyle(
                                          fontFamily: 'OpenSanse',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),

                                    //leader name
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 20, top: 140),
                                      child: Text(
                                        "Leader name: ${paymentDetail.playername}",
                                        style: TextStyle(
                                          fontFamily: 'OpenSanse',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),

                                    //leader email
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 20, top: 160),
                                      child: Text(
                                        "Leader email: ${paymentDetail.playeremail}",
                                        style: TextStyle(
                                          fontFamily: 'OpenSanse',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),

                                    //leader clg
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 20, top: 180),
                                      child: Text(
                                        "Leader collge: ${paymentDetail.playercollgename}",
                                        style: TextStyle(
                                          fontFamily: 'OpenSanse',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),

                                    //leader En.no
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 20, top: 200),
                                      child: Text(
                                        "Leader En.no: ${paymentDetail.playerenrollmentNo}",
                                        style: TextStyle(
                                          fontFamily: 'OpenSanse',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),

                                    //Divider
                                    Padding(
                                      padding: const EdgeInsets.only(top: 220),
                                      child: Divider(
                                        color: Colors.grey,
                                        thickness: 1,
                                      ),
                                    ),

                                    //Gully Cricket
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 20, top: 240),
                                      child: Text(
                                        "Gully Cricket: ${paymentDetail.GameGullyCricket}",
                                        style: TextStyle(
                                          fontFamily: 'OpenSanse',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),

                                    //Multimedia Prse
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 20, top: 260),
                                      child: Text(
                                        "Multimedia Prse.: ${paymentDetail.GameMultimediaPrse}",
                                        style: TextStyle(
                                          fontFamily: 'OpenSanse',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),

                                    //One Minute Game
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 20, top: 280),
                                      child: Text(
                                        "One Minute Game: ${paymentDetail.GameOneMinuteGame}",
                                        style: TextStyle(
                                          fontFamily: 'OpenSanse',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),

                                    //Poster Talk
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 20, top: 300),
                                      child: Text(
                                        "Poster Talk: ${paymentDetail.GamePosterTalk}",
                                        style: TextStyle(
                                          fontFamily: 'OpenSanse',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),

                                    //Project Expo
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 20, top: 320),
                                      child: Text(
                                        "Project Expo: ${paymentDetail.GameProjectExpo}",
                                        style: TextStyle(
                                          fontFamily: 'OpenSanse',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),

                                    //Shark Tank
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 20, top: 340),
                                      child: Text(
                                        "Project Expo: ${paymentDetail.GameSharkTank}",
                                        style: TextStyle(
                                          fontFamily: 'OpenSanse',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),

                                    //Tech O Model
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 20, top: 360),
                                      child: Text(
                                        "Project Expo: ${paymentDetail.GameTechOModel}",
                                        style: TextStyle(
                                          fontFamily: 'OpenSanse',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),

                                    //Techno Sketch
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 20, top: 380),
                                      child: Text(
                                        "Techno Sketch: ${paymentDetail.GameTechnoSketch}",
                                        style: TextStyle(
                                          fontFamily: 'OpenSanse',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),

                                    //Vadic Maths
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 20, top: 400),
                                      child: Text(
                                        "Vadic Maths: ${paymentDetail.GameVadicMaths}",
                                        style: TextStyle(
                                          fontFamily: 'OpenSanse',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              //Update Payment Satatus
                              Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(20),
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: HexColor("#11145A"),
                                      textStyle: const TextStyle(
                                        fontFamily: 'OpenSanse',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                      minimumSize: const Size.fromHeight(55),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    child: isLoadingUpdatePaymentStautus == true
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: const [
                                              SizedBox(
                                                height: 27,
                                                width: 27,
                                                child:
                                                    CircularProgressIndicator(
                                                  color: Colors.white,
                                                ),
                                              ),
                                              SizedBox(width: 18),
                                              Text(
                                                "Please Wait",
                                                style: TextStyle(
                                                  fontFamily: 'OpenSanse',
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 23,
                                                  color: Colors.white,
                                                ),
                                              )
                                            ],
                                          )
                                        : Text("Update Payment Status"),
                                    onPressed: () {
                                      setState(() {
                                        isLoadingUpdatePaymentStautus = true;
                                      });

                                      Future.delayed(
                                        Duration(seconds: 3),
                                        () {
                                          //fetch payment Datils from Database

                                          UpdatePaymentStutasDegree();

                                          //end loading
                                          setState(() {
                                            isLoadingUpdatePaymentStautus =
                                                false;
                                          });
                                        },
                                      );
                                    }),
                              ),
                            ],
                          );
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
                            color: Colors.black,
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
