import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:vegy2023/pages/FirstPage.dart';
import 'package:vegy2023/pages/Nextscreen.dart';
import 'package:vegy2023/pages/SnackBar.dart';

import '../Provider/InternetProvider.dart';
import '../Provider/particpationData.dart';
import '../Provider/userprovider.dart';
import '../Services/authServices.dart';
import 'CartModel.dart';

class checkOutPage extends StatefulWidget {
  const checkOutPage({super.key});

  @override
  State<checkOutPage> createState() => _checkOutPageState();
}

class _checkOutPageState extends State<checkOutPage> {
  //razorpay instance
  late var _razorpay;

  double? PayingAmount;
  double? PayingAmounttodiplayHistoryPage;

  //for mongodb
  final AuthService authService = AuthService();

  //for getting total number game numbers and other details
  final participateData = ParticipateData();

  //userid that ftech from user provider --> help to fetch payment hostory from the db
  String? userid;
  String? userName;
  String? userEmail;
  String? userCollegeName;
  String? userEnNo;
  String? userContactNo;
  String? diplomaORdegree;

  //for store gameNAme in payments Collections
  //for degree game
  String isGameTalaash = "";
  String isGameTechTainment = "";
  String isGameTheCivilSafari = "";
  String isGameDekathon = "";
  String isOfficeTennis = "";

  @override
  void initState() {
    //this is razor pay lisners
    _razorpay = Razorpay();

    //all other method for razorpay
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }

  //payment succeds
  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
    //for get Current Date and Time
    DateTime today = DateTime.now();
    String dateTime =
        "${today.day}-${today.month}-${today.year} | ${today.hour}:${today.minute}:${today.second}";

    //set payment button that show in history page
    //we divide 100 because it's automativally multiply by 100
    PayingAmounttodiplayHistoryPage = PayingAmount! / 100;

    //after succfull payment add entry in respective db in mongo for participated students
    //for talassh
    if (participateData.isTalaash == true) {
      //for adding all game name in payment class
      setState(() {
        isGameTalaash = 'YES';
      });

      //add game with payment id in talassh game collection
      authService.talaashUser(
          context: context,
          timeDate: dateTime,
          transactionid: response.paymentId!,
          talaashUser1name: participateData.talaashUser1name!,
          talaashUser1email: participateData.talaashUser1email!,
          talaashUser1collegename: participateData.talaashUser1collegename!,
          talaashUser1enrollmentno: participateData.talaashUser1enrollmentnO!,
          talaashUser1sem: participateData.talaashUser1sem!,
          talaashUser1Branch: participateData.talaashUser1branch!,
          talaashUser1contactNo: participateData.talaashUser1contactNo!,
          talaashUser2name: participateData.talaashUser2name!,
          talaashUser2email: participateData.talaashUser2email!,
          talaashUser2collegename: participateData.talaashUser2collegename!,
          talaashUser2enrollmentno: participateData.talaashUser2enrollmentnO!,
          talaashUser2sem: participateData.talaashUser2sem!,
          talaashUser2Branch: participateData.talaashUser2branch!,
          talaashUser2contactNo: participateData.talaashUser2contactNo!);
    }

    //for Tech-tainment
    if (participateData.isTechTainment == true) {
      //for adding all game name in payment class
      setState(() {
        isGameTechTainment = 'YES';
      });

      //add game with payment id in TechTainment game collection
      authService.techTainmentUser(
        context: context,
        transactionid: response.paymentId!,
        timeDate: dateTime,
        techTainmentUser1name: participateData.techTainmentUser1name!,
        techTainmentUser1email: participateData.techTainmentUser2email!,
        techTainmentUser1collegename:
            participateData.techTainmentUser1collegename!,
        techTainmentUser1enrollmentno:
            participateData.techTainmentUser1enrollmentnO!,
        techTainmentUser1sem: participateData.techTainmentUser1sem!,
        techTainmentUser1Branch: participateData.techTainmentUser1branch!,
        techTainmentUser1contactNo: participateData.techTainmentUser1contactNo!,
        techTainmentUser2name: participateData.techTainmentUser2name!,
        techTainmentUser2email: participateData.techTainmentUser2email!,
        techTainmentUser2collegename:
            participateData.techTainmentUser1collegename!,
        techTainmentUser2enrollmentno:
            participateData.techTainmentUser2enrollmentnO!,
        techTainmentUser2sem: participateData.techTainmentUser2sem!,
        techTainmentUser2Branch: participateData.techTainmentUser2branch!,
        techTainmentUser2contactNo: participateData.techTainmentUser2contactNo!,
        techTainmentUser3name: participateData.techTainmentUser3name!,
        techTainmentUser3email: participateData.techTainmentUser3email!,
        techTainmentUser3collegename:
            participateData.techTainmentUser3collegename!,
        techTainmentUser3enrollmentno:
            participateData.techTainmentUser3enrollmentnO!,
        techTainmentUser3sem: participateData.techTainmentUser3sem!,
        techTainmentUser3Branch: participateData.techTainmentUser3branch!,
        techTainmentUser3contactNo: participateData.techTainmentUser3contactNo!,
      );
    }

    //for TheCivilSafari
    if (participateData.isTheCivilSafari == true) {
      //for adding all game name in payment class
      setState(() {
        isGameTheCivilSafari = 'YES';
      });

      //add game with payment id in TheCivilSafari game collection
      authService.TheCivilSafari(
        context: context,
        transactionid: response.paymentId!,
        timeDate: dateTime,
        TheCivilSafariUser1name: participateData.TheCivilSafariUser1name!,
        TheCivilSafariUser1email: participateData.TheCivilSafariUser1email!,
        TheCivilSafariUser1collegename:
            participateData.TheCivilSafariUser1collegename!,
        TheCivilSafariUser1enrollmentno:
            participateData.TheCivilSafariUser1enrollmentnO!,
        TheCivilSafariUser1sem: participateData.TheCivilSafariUser1sem!,
        TheCivilSafariUser1Branch: participateData.TheCivilSafariUser1branch!,
        TheCivilSafariUser1contactNo:
            participateData.TheCivilSafariUser1contactNo!,
        TheCivilSafariUser2name: participateData.TheCivilSafariUser2name!,
        TheCivilSafariUser2email: participateData.TheCivilSafariUser2email!,
        TheCivilSafariUser2collegename:
            participateData.TheCivilSafariUser2collegename!,
        TheCivilSafariUser2enrollmentno:
            participateData.TheCivilSafariUser2enrollmentnO!,
        TheCivilSafariUser2sem: participateData.TheCivilSafariUser2sem!,
        TheCivilSafariUser2Branch: participateData.TheCivilSafariUser2branch!,
        TheCivilSafariUser2contactNo:
            participateData.TheCivilSafariUser2contactNo!,
        TheCivilSafariUser3name: participateData.TheCivilSafariUser3name!,
        TheCivilSafariUser3email: participateData.TheCivilSafariUser3email!,
        TheCivilSafariUser3collegename:
            participateData.TheCivilSafariUser3collegename!,
        TheCivilSafariUser3enrollmentno:
            participateData.TheCivilSafariUser3enrollmentnO!,
        TheCivilSafariUser3sem: participateData.TheCivilSafariUser3sem!,
        TheCivilSafariUser3Branch: participateData.TheCivilSafariUser3branch!,
        TheCivilSafariUser3contactNo:
            participateData.TheCivilSafariUser3contactNo!,
      );
    }

    //for Dekathon
    if (participateData.isDekathon == true) {
      //for adding all game name in payment class
      setState(() {
        isGameDekathon = 'YES';
      });

      //add game with payment id in TechTainment game collection
      authService.DekathoneUser(
        context: context,
        transactionid: response.paymentId!,
        timeDate: dateTime,
        DekathoneUser1name: participateData.DekathonUser1name!,
        DekathoneUser1email: participateData.DekathonUser1email!,
        Dekathoneser1collegename: participateData.DekathonUser1collegename!,
        Dekathoneser1enrollmentno: participateData.DekathonUser1enrollmentnO!,
        Dekathoneser1sem: participateData.DekathonUser1sem!,
        Dekathoneser1Branch: participateData.DekathonUser1branch!,
        Dekathoneser1contactNo: participateData.DekathonUser1contactNo!,
        Dekathoneser2name: participateData.DekathonUser2name!,
        Dekathoneser2email: participateData.DekathonUser2email!,
        Dekathoneser2collegename: participateData.DekathonUser2collegename!,
        Dekathoneser2enrollmentno: participateData.DekathonUser2enrollmentnO!,
        Dekathoneser2sem: participateData.DekathonUser2sem!,
        Dekathoneser2Branch: participateData.DekathonUser2branch!,
        Dekathoneser2contactNo: participateData.DekathonUser2contactNo!,
        DekathoneUser3name: participateData.DekathonUser3name!,
        DekathoneUser3email: participateData.DekathontUser3email!,
        DekathoneUser3collegename: participateData.DekathonUser3collegename!,
        DekathoneUser3enrollmentno: participateData.DekathonUser3enrollmentnO!,
        DekathoneUser3sem: participateData.DekathonUser3sem!,
        DekathoneUser3Branch: participateData.DekathonUser3branch!,
        DekathoneUser3contactNo: participateData.DekathonUser3contactNo!,
        DekathoneUser4name: participateData.DekathonUser4name!,
        DekathoneUser4email: participateData.DekathontUser4email!,
        DekathoneUser4collegename: participateData.DekathonUser4collegename!,
        DekathoneUser4enrollmentno: participateData.DekathonUser4enrollmentnO!,
        DekathoneUser4sem: participateData.DekathonUser4sem!,
        DekathoneUser4Branch: participateData.DekathonUser4branch!,
        DekathoneUser4contactNo: participateData.DekathonUser4contactNo!,
      );
    }

    //forOfficeTennis
    if (participateData.isOfficeTennis == true) {
      //for adding all game name in payment class
      setState(() {
        isOfficeTennis = 'YES';
      });

      //add game with payment id in forOfficeTennis game collection
      authService.OfficeTennis(
        context: context,
        transactionid: response.paymentId!,
        timeDate: dateTime,
        OfficeTennisUser1name: participateData.OfficeTennisUser1name!,
        OfficeTennisUser1email: participateData.OfficeTennisUser1email!,
        OfficeTennisUser1collegename:
            participateData.OfficeTennisUser1collegename!,
        OfficeTennisUser1enrollmentno:
            participateData.OfficeTennisUser1enrollmentnO!,
        OfficeTennisUser1sem: participateData.OfficeTennisUser1sem!,
        OfficeTennisUser1Branch: participateData.OfficeTennisUser1branch!,
        OfficeTennisUser1contactNo: participateData.OfficeTennisUser1contactNo!,
        OfficeTennisUser2name: participateData.OfficeTennisUser2name!,
        OfficeTennisUser2email: participateData.OfficeTennisUser2email!,
        OfficeTennisUser2collegename:
            participateData.OfficeTennisUser2collegename!,
        OfficeTennisUser2enrollmentno:
            participateData.OfficeTennisUser2enrollmentnO!,
        OfficeTennisUser2sem: participateData.OfficeTennisUser2sem!,
        OfficeTennisUser2Branch: participateData.OfficeTennisUser2branch!,
        OfficeTennisUser2contactNo: participateData.OfficeTennisUser2contactNo!,
      );
    }

    // add payment in payment collection Of Db
    if (diplomaORdegree == 'Degree') {
      authService.addINTODegreePayment(
          context: context,
          userId: userid!,
          paymentId: response.paymentId.toString(),
          amount: PayingAmounttodiplayHistoryPage.toString(),
          timeDate: dateTime,
          GameTalaash: isGameTalaash,
          GameTechTainment: isGameTechTainment,
          GameTheCivilSafari: isGameTheCivilSafari,
          GameDekathon: isGameDekathon,
          GameOfficeTennis: isOfficeTennis,
          playername: userName!,
          playeremail: userEmail!,
          playercollgename: userCollegeName!,
          playerenrollmentNo: userEnNo!,
          playerContactNo: userContactNo!);
    } else {}

    //show pop-up box
    QuickAlert.show(
      context: context,
      type: QuickAlertType.success,
      title: "Payment Success",
      text: "See you at VEYG 2k23",
      confirmBtnText: "Thanks!",
      confirmBtnColor: Color.fromARGB(255, 47, 196, 52),
      width: 25,
    );

    //remove games from cart
    var cart = Provider.of<CartModel>(context, listen: false);
    cart.clearCart();

    nextScreen(context, FirstPage());
  }

  //payment Fail
  void _handlePaymentError(PaymentFailureResponse response) {
    print("Payment Fail");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }

  void lunchRazorPay() {
    ///Make payment
    var options = {
      'key': "rzp_test_qxUSQdChEGjDpj",
      'amount': "${PayingAmount}",
      'name': 'VEYG-2k23',
      'description': 'Entrys fees',
      'timeout': 300, // in seconds
      'prefill': {'contact': '7383791771', 'email': 'mavanidhruv32@gmail.com'}
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      print(e);
      openSnackbar(context, e.toString(), Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    //height and width
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    //get current user User Id --> that help to store payment data and fetch payment data in history page
    final user = Provider.of<UserProvider>(context).user;

    //for getting Total Price
    var cart = context.watch<CartModel>();

    return SafeArea(
      child: Scaffold(
        backgroundColor: HexColor("#F0F0F2"),
        //appbar
        appBar: AppBar(
          backgroundColor: HexColor("#F0F0F2"),
          elevation: 0,
          title: const Padding(
            padding: EdgeInsets.only(left: 65),
            child: Text(
              "Checkout",
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 25),

              //for Game Talaash
              if (participateData.isTalaash == true) ...[
                Center(
                  child: Container(
                    height: height / 1.7,
                    width: width / 1.07,
                    decoration: BoxDecoration(
                      color: HexColor("#FFFFFF"),
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15)),
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
                        //heading
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 15),
                          child: Text(
                            "Team-Talaash",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w600,
                              fontSize: 30,
                            ),
                          ),
                        ),

                        //for user-1
                        //leader name
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 65),
                          child: Text(
                            "Leader name: ${participateData.talaashUser1name}",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        //leader email
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 85),
                          child: Text(
                            "Leader email: ${participateData.talaashUser1email}",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        //leader college name
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 105),
                          child: Text(
                            "Leader college: ${participateData.talaashUser1collegename}",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        //leader enrollment no
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 125),
                          child: Text(
                            "Leader En.No: ${participateData.talaashUser1enrollmentnO}",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        //leader sem
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 145),
                          child: Text(
                            "Leader Sem: ${participateData.talaashUser1sem}",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        //leader branch
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 165),
                          child: Text(
                            "Leader Branch: ${participateData.talaashUser1branch}",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        //leader contact no
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 185),
                          child: Text(
                            "Leader Contact No: ${participateData.talaashUser1contactNo}",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        //Horizontal Line
                        Padding(
                          padding: const EdgeInsets.only(top: 215),
                          child: Divider(
                            color: Colors.black,
                            height: 4,
                          ),
                        ),

                        //for user-2
                        //player-2 name
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 235),
                          child: Text(
                            "player-2 name: ${participateData.talaashUser2name}",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        //player-2  email
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 255),
                          child: Text(
                            "player-2  email: ${participateData.talaashUser2email}",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        //player-2  college name
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 275),
                          child: Text(
                            "player-2 college: ${participateData.talaashUser2collegename}",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        //player-2  enrollment no
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 295),
                          child: Text(
                            "player-2  En.No: ${participateData.talaashUser2enrollmentnO}",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        //player-2  sem
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 315),
                          child: Text(
                            "player-2  Sem: ${participateData.talaashUser2sem}",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        //player-2  branch
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 335),
                          child: Text(
                            "player-2  Branch: ${participateData.talaashUser2branch}",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        //player-2  contact no
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 355),
                          child: Text(
                            "player-2  Contact No: ${participateData.talaashUser2contactNo}",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        //note
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 390),
                          child: Text(
                            "Note: 2.5% tax inculded for each player fees",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],

              SizedBox(height: 15),

              //for Game Tech Tainment
              if (participateData.isTechTainment == true) ...[
                Center(
                  child: Container(
                    height: height / 1.3,
                    width: width / 1.07,
                    decoration: BoxDecoration(
                      color: HexColor("#FFFFFF"),
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15)),
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
                        //heading
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 15),
                          child: Text(
                            "Team-TechTainment",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w600,
                              fontSize: 30,
                            ),
                          ),
                        ),

                        //for user-1
                        //leader name
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 65),
                          child: Text(
                            "Leader name: ${participateData.techTainmentUser1name}",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        //leader email
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 85),
                          child: Text(
                            "Leader email: ${participateData.techTainmentUser1email}",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        //leader college name
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 105),
                          child: Text(
                            "Leader college: ${participateData.techTainmentUser1collegename}",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        //leader enrollment no
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 125),
                          child: Text(
                            "Leader En.No: ${participateData.techTainmentUser1enrollmentnO}",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        //leader sem
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 145),
                          child: Text(
                            "Leader Sem: ${participateData.techTainmentUser1sem}",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        //leader branch
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 165),
                          child: Text(
                            "Leader Branch: ${participateData.techTainmentUser1branch}",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        //leader contact no
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 185),
                          child: Text(
                            "Leader Contact No: ${participateData.techTainmentUser1contactNo}",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        //Horizontal Line
                        Padding(
                          padding: const EdgeInsets.only(top: 215),
                          child: Divider(
                            color: Colors.black,
                            height: 4,
                          ),
                        ),

                        //for user-2
                        //player-2 name
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 225),
                          child: Text(
                            "player-2 name: ${participateData.techTainmentUser2name}",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        //player-2  email
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 245),
                          child: Text(
                            "player-2  email: ${participateData.techTainmentUser2email}",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        //player-2  college name
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 265),
                          child: Text(
                            "player-2 college: ${participateData.techTainmentUser2collegename}",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        //player-2  enrollment no
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 285),
                          child: Text(
                            "player-2  En.No: ${participateData.techTainmentUser2enrollmentnO}",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        //player-2  sem
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 300),
                          child: Text(
                            "player-2  Sem: ${participateData.techTainmentUser2sem}",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        //player-2  branch
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 320),
                          child: Text(
                            "player-2  Branch: ${participateData.techTainmentUser2branch}",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        //player-2  contact no
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 340),
                          child: Text(
                            "player-2  Contact No: ${participateData.techTainmentUser2contactNo}",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        //Horizontal Line
                        Padding(
                          padding: const EdgeInsets.only(top: 370),
                          child: Divider(
                            color: Colors.black,
                            height: 4,
                          ),
                        ),

                        //for user-3
                        //player-3 name
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 390),
                          child: Text(
                            "player-3 name: ${participateData.techTainmentUser3name}",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        //player-3  email
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 410),
                          child: Text(
                            "player-3  email: ${participateData.techTainmentUser3email}",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        //player-3 college name
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 430),
                          child: Text(
                            "player-3 college: ${participateData.techTainmentUser3collegename}",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        //player-3  enrollment no
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 450),
                          child: Text(
                            "player-3  En.No: ${participateData.techTainmentUser3enrollmentnO}",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        //player-3  sem
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 470),
                          child: Text(
                            "player-3  Sem: ${participateData.techTainmentUser3sem}",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        //player-3  branch
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 490),
                          child: Text(
                            "player-3  Branch: ${participateData.techTainmentUser3branch}",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        //player-3 contact no
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 510),
                          child: Text(
                            "player-3  Contact No: ${participateData.techTainmentUser3contactNo}",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        //note
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 540),
                          child: Text(
                            "Note: 2.5% tax inculded for each player fees",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],

              SizedBox(height: 15),

              //for Game The civil Safari
              if (participateData.isTheCivilSafari == true) ...[
                Center(
                  child: Container(
                    height: height / 1.3,
                    width: width / 1.07,
                    decoration: BoxDecoration(
                      color: HexColor("#FFFFFF"),
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15)),
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
                        //heading
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 15),
                          child: Text(
                            "Team-The Civil Safari",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w600,
                              fontSize: 30,
                            ),
                          ),
                        ),

                        //for user-1
                        //leader name
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 65),
                          child: Text(
                            "Leader name: ${participateData.TheCivilSafariUser1name}",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        //leader email
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 85),
                          child: Text(
                            "Leader email: ${participateData.TheCivilSafariUser1email}",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        //leader college name
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 105),
                          child: Text(
                            "Leader college: ${participateData.TheCivilSafariUser1collegename}",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        //leader enrollment no
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 125),
                          child: Text(
                            "Leader En.No: ${participateData.TheCivilSafariUser1enrollmentnO}",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        //leader sem
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 145),
                          child: Text(
                            "Leader Sem: ${participateData.TheCivilSafariUser1sem}",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        //leader branch
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 165),
                          child: Text(
                            "Leader Branch: ${participateData.TheCivilSafariUser1branch}",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        //leader contact no
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 185),
                          child: Text(
                            "Leader Contact No: ${participateData.TheCivilSafariUser1contactNo}",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        //Horizontal Line
                        Padding(
                          padding: const EdgeInsets.only(top: 215),
                          child: Divider(
                            color: Colors.black,
                            height: 4,
                          ),
                        ),

                        //for user-2
                        //player-2 name
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 225),
                          child: Text(
                            "player-2 name: ${participateData.TheCivilSafariUser2name}",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        //player-2  email
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 245),
                          child: Text(
                            "player-2  email: ${participateData.TheCivilSafariUser2email}",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        //player-2  college name
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 265),
                          child: Text(
                            "player-2 college: ${participateData.techTainmentUser2collegename}",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        //player-2  enrollment no
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 285),
                          child: Text(
                            "player-2  En.No: ${participateData.TheCivilSafariUser2enrollmentnO}",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        //player-2  sem
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 300),
                          child: Text(
                            "player-2  Sem: ${participateData.TheCivilSafariUser2sem}",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        //player-2  branch
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 320),
                          child: Text(
                            "player-2  Branch: ${participateData.TheCivilSafariUser2branch}",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        //player-2  contact no
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 340),
                          child: Text(
                            "player-2  Contact No: ${participateData.TheCivilSafariUser2contactNo}",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        //Horizontal Line
                        Padding(
                          padding: const EdgeInsets.only(top: 370),
                          child: Divider(
                            color: Colors.black,
                            height: 4,
                          ),
                        ),

                        //for user-3
                        //player-3 name
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 390),
                          child: Text(
                            "player-3 name: ${participateData.TheCivilSafariUser3name}",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        //player-3  email
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 410),
                          child: Text(
                            "player-3  email: ${participateData.TheCivilSafariUser3email}",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        //player-3 college name
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 430),
                          child: Text(
                            "player-3 college: ${participateData.TheCivilSafariUser3collegename}",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        //player-3  enrollment no
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 450),
                          child: Text(
                            "player-3  En.No: ${participateData.TheCivilSafariUser3enrollmentnO}",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        //player-3  sem
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 470),
                          child: Text(
                            "player-3  Sem: ${participateData.TheCivilSafariUser3sem}",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        //player-3  branch
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 490),
                          child: Text(
                            "player-3  Branch: ${participateData.TheCivilSafariUser3branch}",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        //player-3 contact no
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 510),
                          child: Text(
                            "player-3  Contact No: ${participateData.TheCivilSafariUser3contactNo}",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        //note
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 540),
                          child: Text(
                            "Note: 2.5% tax inculded for each player fees",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],

              SizedBox(height: 15),

              //for Game Dekathon
              if (participateData.isDekathon == true) ...[
                Center(
                  child: Container(
                    height: height / 1,
                    width: width / 1.07,
                    decoration: BoxDecoration(
                      color: HexColor("#FFFFFF"),
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15)),
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
                        //heading
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 15),
                          child: Text(
                            "Team-Dekathon",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w600,
                              fontSize: 30,
                            ),
                          ),
                        ),

                        //for user-1
                        //leader name
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 65),
                          child: Text(
                            "Leader name: ${participateData.DekathonUser1name}",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        //leader email
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 85),
                          child: Text(
                            "Leader email: ${participateData.DekathonUser1email}",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        //leader college name
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 105),
                          child: Text(
                            "Leader college: ${participateData.DekathonUser1collegename}",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        //leader enrollment no
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 125),
                          child: Text(
                            "Leader En.No: ${participateData.DekathonUser1enrollmentnO}",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        //leader sem
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 145),
                          child: Text(
                            "Leader Sem: ${participateData.DekathonUser1sem}",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        //leader branch
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 165),
                          child: Text(
                            "Leader Branch: ${participateData.DekathonUser1branch}",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        //leader contact no
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 185),
                          child: Text(
                            "Leader Contact No: ${participateData.DekathonUser1contactNo}",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        //Horizontal Line
                        Padding(
                          padding: const EdgeInsets.only(top: 215),
                          child: Divider(
                            color: Colors.black,
                            height: 4,
                          ),
                        ),

                        //for user-2
                        //player-2 name
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 225),
                          child: Text(
                            "player-2 name: ${participateData.DekathonUser2name}",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        //player-2  email
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 245),
                          child: Text(
                            "player-2  email: ${participateData.DekathonUser2email}",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        //player-2  college name
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 265),
                          child: Text(
                            "player-2 college: ${participateData.DekathonUser2collegename}",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        //player-2  enrollment no
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 285),
                          child: Text(
                            "player-2  En.No: ${participateData.DekathonUser2enrollmentnO}",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        //player-2  sem
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 300),
                          child: Text(
                            "player-2  Sem: ${participateData.DekathonUser2sem}",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        //player-2  branch
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 320),
                          child: Text(
                            "player-2  Branch: ${participateData.DekathonUser2branch}",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        //player-2  contact no
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 340),
                          child: Text(
                            "player-2  Contact No: ${participateData.DekathonUser2contactNo}",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        //Horizontal Line
                        Padding(
                          padding: const EdgeInsets.only(top: 370),
                          child: Divider(
                            color: Colors.black,
                            height: 4,
                          ),
                        ),

                        //for user-3
                        //player-3 name
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 390),
                          child: Text(
                            "player-3 name: ${participateData.DekathonUser3name}",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        //player-3  email
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 410),
                          child: Text(
                            "player-3  email: ${participateData.DekathontUser3email}",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        //player-3 college name
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 430),
                          child: Text(
                            "player-3 college: ${participateData.DekathonUser3collegename}",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        //player-3  enrollment no
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 450),
                          child: Text(
                            "player-2  En.No: ${participateData.DekathonUser3enrollmentnO}",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        //player-3  sem
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 470),
                          child: Text(
                            "player-2  Sem: ${participateData.DekathonUser3sem}",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        //player-3  branch
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 490),
                          child: Text(
                            "player-2  Branch: ${participateData.DekathonUser3branch}",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        //player-3 contact no
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 510),
                          child: Text(
                            "player-2  Contact No: ${participateData.DekathonUser3contactNo}",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        //Horizontal Line
                        Padding(
                          padding: const EdgeInsets.only(top: 530),
                          child: Divider(
                            color: Colors.black,
                            height: 4,
                          ),
                        ),

                        //for user-4
                        //player-4 name
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 550),
                          child: Text(
                            "player-4 name: ${participateData.DekathonUser4name}",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        //player-4  email
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 570),
                          child: Text(
                            "player-4  email: ${participateData.DekathontUser4email}",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        //player-4 college name
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 590),
                          child: Text(
                            "player-4 college: ${participateData.DekathonUser4collegename}",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        //player-4  enrollment no
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 610),
                          child: Text(
                            "player-4  En.No: ${participateData.DekathonUser4enrollmentnO}",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        //player-4  sem
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 630),
                          child: Text(
                            "player-4  Sem: ${participateData.DekathonUser4sem}",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        //player-4  branch
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 650),
                          child: Text(
                            "player-4  Branch: ${participateData.DekathonUser4branch}",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        //player-4 contact no
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 670),
                          child: Text(
                            "player-4  Contact No: ${participateData.DekathonUser4contactNo}",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        //note
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 700),
                          child: Text(
                            "Note: 2.5% tax inculded for each player fees",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],

              SizedBox(height: 15),

              //for Game Office Tennis
              if (participateData.isOfficeTennis == true) ...[
                Center(
                  child: Container(
                    height: height / 1.7,
                    width: width / 1.07,
                    decoration: BoxDecoration(
                      color: HexColor("#FFFFFF"),
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15)),
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
                        //heading
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 15),
                          child: Text(
                            "Team-Talaash",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w600,
                              fontSize: 30,
                            ),
                          ),
                        ),

                        //for user-1
                        //leader name
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 65),
                          child: Text(
                            "Leader name: ${participateData.OfficeTennisUser1name}",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        //leader email
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 85),
                          child: Text(
                            "Leader email: ${participateData.OfficeTennisUser1email}",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        //leader college name
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 105),
                          child: Text(
                            "Leader college: ${participateData.OfficeTennisUser1collegename}",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        //leader enrollment no
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 125),
                          child: Text(
                            "Leader En.No: ${participateData.OfficeTennisUser1enrollmentnO}",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        //leader sem
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 145),
                          child: Text(
                            "Leader Sem: ${participateData.OfficeTennisUser1sem}",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        //leader branch
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 165),
                          child: Text(
                            "Leader Branch: ${participateData.OfficeTennisUser1branch}",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        //leader contact no
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 185),
                          child: Text(
                            "Leader Contact No: ${participateData.OfficeTennisUser1contactNo}",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        //Horizontal Line
                        Padding(
                          padding: const EdgeInsets.only(top: 215),
                          child: Divider(
                            color: Colors.black,
                            height: 4,
                          ),
                        ),

                        //for user-2
                        //player-2 name
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 235),
                          child: Text(
                            "player-2 name: ${participateData.OfficeTennisUser2name}",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        //player-2  email
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 255),
                          child: Text(
                            "player-2  email: ${participateData.OfficeTennisUser2email}",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        //player-2  college name
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 275),
                          child: Text(
                            "player-2 college: ${participateData.OfficeTennisUser2collegename}",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        //player-2  enrollment no
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 295),
                          child: Text(
                            "player-2  En.No: ${participateData.OfficeTennisUser2enrollmentnO}",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        //player-2  sem
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 315),
                          child: Text(
                            "player-2  Sem: ${participateData.OfficeTennisUser2sem}",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        //player-2  branch
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 335),
                          child: Text(
                            "player-2  Branch: ${participateData.OfficeTennisUser2branch}",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        //player-2  contact no
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 355),
                          child: Text(
                            "player-2  Contact No: ${participateData.OfficeTennisUser2contactNo}",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        //note
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 390),
                          child: Text(
                            "Note: 2.5% tax inculded for each player fees",
                            style: TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],

              //payment Box
              Container(
                margin: EdgeInsets.only(bottom: 15, top: 15),
                height: height / 14,
                width: width / 1.1,
                decoration: BoxDecoration(
                  color: HexColor("#11145A"),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 7,
                      offset: Offset(8, 7),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 18),
                      child: Text(
                        "₹${cart.totalPrice.round()}",
                        style: const TextStyle(
                          fontFamily: 'OpenSanse',
                          fontWeight: FontWeight.w600,
                          fontSize: 28,
                          color: Colors.white,
                        ),
                      ),
                    ),

                    //payment Button
                    InkWell(
                      onTap: () async {
                        //check internet is on or not
                        final ip = context.read<InternetProvider>();
                        await ip.checkInternetConnection();

                        //for checking Internet
                        if (ip.hasInternet == false) {
                          openSnackbar(
                              context,
                              'Please check your internet connectivity',
                              Colors.red);
                        } else {
                          setState(() {
                            //set details for storing DB anad that use inpayment history page
                            userid = user.uid;
                            userName = user.name;
                            userEmail = user.email;
                            userCollegeName = user.collagename;
                            userEnNo = user.EnNO;
                            userContactNo = user.phoneno;
                            diplomaORdegree = user.diplomaORdegree;

                            //for razor pay converts

                            //get total price in int and round --> if money is 2.5 then take 3
                            int money = cart.totalPrice.round();

                            //convert to double
                            //convert paisa to ₹ --> so we multiple by 100
                            PayingAmount = double.parse("${money}") * 100;

                            // PayingAmount =
                            //     double.parse("${cart.totalPrice}") * 100;
                          });

                          //lanch RozerPay
                          lunchRazorPay();
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 110),
                        height: height / 16.5,
                        width: width / 3,
                        decoration: BoxDecoration(
                          color: HexColor("#FEBD2F"),
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 0.2,
                              blurRadius: 0.2,
                              offset: Offset(0.5, 0.2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Icon(
                                LineIcons.wallet,
                                size: 35,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 6, bottom: 5),
                              child: Text(
                                "Pay",
                                style: TextStyle(
                                  fontFamily: 'OpenSanse',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 28,
                                  color: HexColor("#110E0D"),
                                ),
                              ),
                            ),
                          ],
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
    );
  }

  //claer all data fromm state
  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }
}
