import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:vegy2023/Provider/userprovider.dart';
import 'package:vegy2023/models/paymentHistoryModel.dart';
import 'package:vegy2023/models/paymentHistoryModel.dart';

import '../Services/authServices.dart';

class PaymentHistoryPage extends StatefulWidget {
  const PaymentHistoryPage({super.key});

  @override
  State<PaymentHistoryPage> createState() => _PaymentHistoryPageState();
}

class _PaymentHistoryPageState extends State<PaymentHistoryPage> {
  //for mfetching data for payment History
  final AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    //get userid from userprovider
    final user = Provider.of<UserProvider>(context).user;

    //height and width
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
            "Payment History",
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
          //expended because we use list and that display on screen and list size is big so expanded increse size
          Expanded(
            //for showing a API data we use future builder
            child: FutureBuilder(
              future: authService.getPaymentHistory(
                  context: context, userId: user.uid),
              builder: (context, snapshot) {
                //if data is not avalible
                if (!snapshot.hasData) {
                  return authService.paymenthistoryList.length == null
                      ? Column(
                          children: [
                            //image
                            Padding(
                              padding: const EdgeInsets.only(top: 50),
                              child: Container(
                                height: height / 2,
                                width: width / 1.2,
                                decoration: BoxDecoration(
                                  // color: Colors.yellow,

                                  image: const DecorationImage(
                                      image: AssetImage(
                                          "assets/images/nopayments.gif"),
                                      fit: BoxFit.cover),
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(23),
                                      topRight: Radius.circular(23),
                                      bottomLeft: Radius.circular(23),
                                      bottomRight: Radius.circular(23)),
                                ),
                              ),
                            ),

                            //text
                            Padding(
                              padding: const EdgeInsets.only(left: 25),
                              child: Text(
                                "you have not participated in any game",
                                style: TextStyle(
                                  fontFamily: 'OpenSanse',
                                  fontWeight: FontWeight.w300,
                                  fontSize: 18,
                                  color: HexColor("#110E0D"),
                                ),
                              ),
                            )
                          ],
                        )
                      : Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 4.5,
                            color: HexColor("#11145A"),
                          ),
                        );
                }

                //if data is avalible
                else {
                  //we have data in list that we store in postlist so we use Listeview builder
                  return ListView.builder(
                      itemCount: authService.paymenthistoryList.length,
                      itemBuilder: (context, index) {
                        //for showing index
                        // return Text(index.toString());

                        // //for showing title
                        // return Card(
                        //   child: Padding(
                        //     padding: const EdgeInsets.all(10.0),
                        //     child: Column(
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       children: [
                        //         const Text(
                        //           "Title",
                        //           style: TextStyle(fontSize: 23),
                        //         ),
                        //         Text(authService
                        //             .paymenthistoryList[index].amount
                        //             .toString()),
                        //         const SizedBox(height: 10),
                        //       ],
                        //     ),
                        //   ),
                        // );

                        //for shoring Payment History
                        return Column(
                          children: [
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 15),
                                child: Container(
                                  height: height / 4.3,
                                  width: width / 1.09,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 1.2,
                                        blurRadius: 5.5,
                                        offset: Offset(
                                            0, 1), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      //for recipt image and success title
                                      Center(
                                        child: Container(
                                          height: height / 4.3,
                                          width: width / 3.5,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(15),
                                                    bottomLeft:
                                                        Radius.circular(15)),
                                            color: Colors.green,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.2),
                                                spreadRadius: 1.2,
                                                blurRadius: 5.5,
                                                offset: Offset(0,
                                                    1), // changes position of shadow
                                              ),
                                            ],
                                          ),
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 30),
                                            child: Column(
                                              children: const [
                                                Icon(
                                                  Icons.receipt_long,
                                                  color: Colors.white,
                                                  size: 68,
                                                ),
                                                SizedBox(height: 8),
                                                Text(
                                                  "Success",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                    fontFamily: "OpenSanse",
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),

                                      //for payment Details
                                      Container(
                                        // color: Colors.yellow,
                                        width: width / 1.6,
                                        child: Column(
                                          children: [
                                            //for amount
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10, top: 10),
                                                child: Text(
                                                  '\u{20B9}' +
                                                      authService
                                                          .paymenthistoryList[
                                                              index]
                                                          .amount
                                                          .toString(),
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 30,
                                                    fontFamily: "OpenSanse",
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ),

                                            //for payment id
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10, top: 5),
                                                child: Text(
                                                  'Payment id: ' +
                                                      authService
                                                          .paymenthistoryList[
                                                              index]
                                                          .paymentId
                                                          .toString(),
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontFamily: "OpenSanse",
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            ),

                                            //for user id
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10, top: 5),
                                                child: Text(
                                                  'Payment id: ' +
                                                      authService
                                                          .paymenthistoryList[
                                                              index]
                                                          .userId
                                                          .toString(),
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontFamily: "OpenSanse",
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            ),

                                            //timeStemp
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10, top: 10),
                                                child: Text(
                                                  authService
                                                      .paymenthistoryList[index]
                                                      .timeDate
                                                      .toString(),
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontFamily: "OpenSanse",
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      });
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
