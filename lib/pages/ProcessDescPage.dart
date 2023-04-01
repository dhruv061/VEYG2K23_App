import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hexcolor/hexcolor.dart';

class ProcessDescPage extends StatefulWidget {
  const ProcessDescPage({super.key});

  @override
  State<ProcessDescPage> createState() => _ProcessDescPageState();
}

class _ProcessDescPageState extends State<ProcessDescPage> {
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
          padding: EdgeInsets.only(left: 10),
          child: Text(
            "Registration Process",
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
          SizedBox(height: 10),

          //Process Desc. Box
          Padding(
            padding: const EdgeInsets.all(12),
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
                          height: height / 8,
                          width: width / 2.8,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            image: const DecorationImage(
                              image: AssetImage("assets/icons/logo2.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Container(),
                        ),
                      ),
                    ),

                    //First Desc.
                    Padding(
                      padding: const EdgeInsets.only(left: 15, top: 25),
                      child: Center(
                        child: Text(
                          "Hello Enthusiasts,\nAre you confused about how to register in our event?\nConfused about making the payment?, and so on…\n\nDon't worry, read the FAQs below and then ask our volunteers for more help or call us on our contact number.",
                          style: const TextStyle(
                            fontFamily: 'OpenSanse',
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),

                    //FAQ title
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20, left: 20),
                        child: Text(
                          "FAQs",
                          style: TextStyle(
                            fontFamily: 'OpenSanse',
                            fontWeight: FontWeight.w700,
                            fontSize: 17,
                            color: HexColor("#11145A"),
                          ),
                        ),
                      ),
                    ),

                    //Q.1
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20, left: 15),
                        child: Text(
                          "Q.1: Does every member of a team event have to register separately?",
                          style: const TextStyle(
                            fontFamily: 'OpenSanse',
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Color.fromARGB(255, 225, 17, 83),
                          ),
                        ),
                      ),
                    ),

                    //Ans.1
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8, left: 15),
                        child: Text(
                          "Ans: No, in case of a Team event, ONLY ONE member from the team needs to register for the event on the VEYG mobile application.",
                          style: const TextStyle(
                            fontFamily: 'OpenSanse',
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),

                    //Q.2
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20, left: 15),
                        child: Text(
                          "Q.2: Can we register for multiple events together?",
                          style: const TextStyle(
                            fontFamily: 'OpenSanse',
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Color.fromARGB(255, 225, 17, 83),
                          ),
                        ),
                      ),
                    ),

                    //Ans.2
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8, left: 15),
                        child: Text(
                          "Ans: Yes, you can register for more than one event together. OR you can even logon to the app some other day and register in a new event again.",
                          style: const TextStyle(
                            fontFamily: 'OpenSanse',
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),

                    //Q.3
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20, left: 15),
                        child: Text(
                          "Q.3: Do we have to make the payment on the mobile app? What proof will we get that our registration is successful?",
                          style: const TextStyle(
                            fontFamily: 'OpenSanse',
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Color.fromARGB(255, 225, 17, 83),
                          ),
                        ),
                      ),
                    ),

                    //Ans.3
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8, left: 15),
                        child: Text(
                          "Ans: No. You ONLY have to REGISTER your team on the mobile application. You need to add the events to the cart and then fill out details of each player on clicking on CHECKOUT. After all details are entered, you will be able to see the final amount that is to be paid. Then click on the REGISTER button.\n\nBUT REMEMBER, YOUR REGISTRATION DOES NOT COUNT YET!\n\nGo to your Payment history, you will be able to see that a TICKET has been generated. On the ticket you will be able to see your final amount payable, a COUPON CODE below the amount and also the PENDING status on the left. Give your MONEY and coupon code to our VOLUNTEER. The volunteer will log into the admin panel, approve your payment and ONLY then your REGISTRATION WILL BE COMPLETE. You can also verify your completed registration by going to payment history and checking your ticket again. It would’ve now turned GREEN and pending status would’ve turned to “SUCCESS”.",
                          style: const TextStyle(
                            fontFamily: 'OpenSanse',
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ), //Q.3

                    //Q.4
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20, left: 15),
                        child: Text(
                          "Q.4: What is the cost of each event?",
                          style: const TextStyle(
                            fontFamily: 'OpenSanse',
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Color.fromARGB(255, 225, 17, 83),
                          ),
                        ),
                      ),
                    ),

                    //Ans.4
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8, left: 15),
                        child: Text(
                          "Ans: The cost of EACH EVENT for EACH PLAYER is INR 60/-",
                          style: const TextStyle(
                            fontFamily: 'OpenSanse',
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),

                    //Mention Below point Heading
                    //All points
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20, left: 15),
                        child: Text(
                          "Follow the below Steps and register your team in VEYG.",
                          style: TextStyle(
                            fontFamily: 'OpenSanse',
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: HexColor("#11145A"),
                          ),
                        ),
                      ),
                    ),

                    //Step-1
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20, left: 15),
                        child: Text(
                          "Step 1: create an account in the VEYG App by filling in some basic details.",
                          style: const TextStyle(
                            fontFamily: 'OpenSanse',
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Color.fromARGB(255, 253, 7, 118),
                          ),
                        ),
                      ),
                    ),

                    //Step-2
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20, left: 15),
                        child: Text(
                          "Step 2: Sign-in in the App",
                          style: const TextStyle(
                            fontFamily: 'OpenSanse',
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Color.fromARGB(255, 253, 7, 118),
                          ),
                        ),
                      ),
                    ),

                    //Step-3
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20, left: 15),
                        child: Text(
                          "Step 3: Select the event in which you  want to participate from Degree/Diploma and click on ADD-TO-CART.",
                          style: const TextStyle(
                            fontFamily: 'OpenSanse',
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Color.fromARGB(255, 253, 7, 118),
                          ),
                        ),
                      ),
                    ),

                    //Step-3 --> Image
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Center(
                        child: Container(
                          height: height / 13,
                          width: width / 1,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            image: const DecorationImage(
                              image: AssetImage(
                                  "assets/images/process/process_addbtn.jpg"),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Container(),
                        ),
                      ),
                    ),

                    //Step-4
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 30, left: 15),
                        child: Text(
                          "Step 4: Go to the CART page and fill up Game details (All details about all the players & this is to be filled up by only the ONE PERSON aka the Team Leader). Once done, click to the add students button.",
                          style: const TextStyle(
                            fontFamily: 'OpenSanse',
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Color.fromARGB(255, 253, 7, 118),
                          ),
                        ),
                      ),
                    ),

                    //Step-4 --> Image
                    Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: Center(
                        child: Container(
                          height: height / 13,
                          width: width / 1,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            image: const DecorationImage(
                              image: AssetImage(
                                  "assets/images/process/process_cartpage.jpg"),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Container(),
                        ),
                      ),
                    ),

                    //Step-5
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 30, left: 15),
                        child: Text(
                          "Step 5: Click the to CHECKOUT button after all students added in all selected games.",
                          style: const TextStyle(
                            fontFamily: 'OpenSanse',
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Color.fromARGB(255, 253, 7, 118),
                          ),
                        ),
                      ),
                    ),

                    //Step-5 --> Image
                    Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: Center(
                        child: Container(
                          height: height / 6,
                          width: width / 1,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            image: const DecorationImage(
                              image: AssetImage(
                                  "assets/images/process/process_checkout.jpg"),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Container(),
                        ),
                      ),
                    ),

                    //Step-6
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 30, left: 15),
                        child: Text(
                          "Step 6: check your team details one final time (because e-certificate will be generated with this name) and click into the REGISTER button and the FIRST STEP of your team registration will be done.",
                          style: const TextStyle(
                            fontFamily: 'OpenSanse',
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Color.fromARGB(255, 253, 7, 118),
                          ),
                        ),
                      ),
                    ),

                    //Step-6 --> Image
                    Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: Center(
                        child: Container(
                          height: height / 13,
                          width: width / 1,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            image: const DecorationImage(
                              image: AssetImage(
                                  "assets/images/process/process_register.jpg"),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Container(),
                        ),
                      ),
                    ),

                    //Step-7
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 30, left: 15),
                        child: Text(
                          "Step 7: Go to Payment history and give the written amount/money and the COUPON CODE to our VOLUNTEER",
                          style: const TextStyle(
                            fontFamily: 'OpenSanse',
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Color.fromARGB(255, 253, 7, 118),
                          ),
                        ),
                      ),
                    ),

                    //Step-8
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 30, left: 15),
                        child: Text(
                          "Step 8: Once the volunteer updates your payment status, check your Payment History again and now you will be able to see that your REGISTRATION is a SUCCESS.",
                          style: const TextStyle(
                            fontFamily: 'OpenSanse',
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Color.fromARGB(255, 253, 7, 118),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 10),

                    //Saffrony logo
                    Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: Center(
                        child: Container(
                          height: height / 12,
                          width: width / 2,
                          decoration: BoxDecoration(
                            color: Colors.white,
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

                    SizedBox(height: 30),
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
