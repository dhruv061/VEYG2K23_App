import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:vegy2023/pages/FirstPage.dart';
import 'package:vegy2023/pages/Nextscreen.dart';
import 'package:vegy2023/pages/SnackBar.dart';

import '../Provider/InternetProvider.dart';
import '../Provider/particpationData.dart';
import '../Provider/userprovider.dart';
import '../Services/authServices.dart';
import 'CartModel.dart';
import 'dart:math';

class checkOutPage extends StatefulWidget {
  const checkOutPage({super.key});

  @override
  State<checkOutPage> createState() => _checkOutPageState();
}

class _checkOutPageState extends State<checkOutPage> {
  //for loading indicator
  bool isLoading = false;

  //for payment amount
  double? PayingAmount;
  double? PayingAmounttodiplayHistoryPage;

  //copen code
  String? coupenCode;

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
  String isGameScavengerHunt = "";

  //for diploma games
  String isGameProjectExpo = "";
  String isGamePosterTalk = "";
  String isGameTechnoSketch = "";
  String isGameGullyCricket = "";
  String isGameVadicMaths = "";
  String isGameOneMinuteGame = "";
  String isGameTechOModel = "";
  String isGameMultimediaPrse = "";
  String isGameSharkTank = "";

  //for Genrate Uniq copen code
  String generateCouponCode(String userId) {
    final random = Random();
    final characters =
        'ABCDEFGHJKMNOPQRSTUVWXYZ0123456789abcdefghjkmnopqrstuvwxyz';
    final codeLength = 3;
    String code = '';

    // Add user ID as prefix
    code += userId.substring(0, 3); // Use first 3 characters of user ID

    // Generate random code as suffix
    for (int i = 0; i < codeLength; i++) {
      code += characters[random.nextInt(characters.length)];
    }
    return code;
  }

  //Check for copen code is not genrated before
  Map<String, List<String>> previousCodes =
      {}; // Map of user ID to list of previous codes

  String generateUniqueCouponCode(String userId) {
    if (!previousCodes.containsKey(userId)) {
      previousCodes[userId] = [];
    }

    String code = generateCouponCode(userId);

    while (previousCodes[userId]!.contains(code)) {
      code = generateCouponCode(userId);
    }

    previousCodes[userId]!.add(code);

    setState(() {
      coupenCode = code;
    });

    return code;
  }

  //RegisterGame Methos
  Future<void> _RegisterGame() async {
    try {
      //for get Current Date and Time
      DateTime today = DateTime.now();
      String dateTime =
          "${today.day}-${today.month}-${today.year} | ${today.hour}:${today.minute}:${today.second}";

      //genrate Coprn Code
      generateUniqueCouponCode(userid!);

      //set payment button that show in history page
      PayingAmounttodiplayHistoryPage = PayingAmount!;

      //after succfull register add entry in respective db in mongo for participated students
      //FOR Degree Games
      //for talassh
      if (participateData.isTalaash == true) {
        //for adding all game name in payment class
        setState(() {
          isGameTalaash = 'True';
        });

        //add game with payment id in talassh game collection
        authService.talaashUser(
            context: context,
            timeDate: dateTime,
            cuponCode: coupenCode!,
            paymentStatus: 'Pending',
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
          isGameTechTainment = 'True';
        });

        //add game with payment id in TechTainment game collection
        authService.techTainmentUser(
          context: context,
          cuponCode: coupenCode!,
          paymentStatus: 'Pending',
          timeDate: dateTime,
          techTainmentUser1name: participateData.techTainmentUser1name!,
          techTainmentUser1email: participateData.techTainmentUser1email!,
          techTainmentUser1collegename:
              participateData.techTainmentUser1collegename!,
          techTainmentUser1enrollmentno:
              participateData.techTainmentUser1enrollmentnO!,
          techTainmentUser1sem: participateData.techTainmentUser1sem!,
          techTainmentUser1Branch: participateData.techTainmentUser1branch!,
          techTainmentUser1contactNo:
              participateData.techTainmentUser1contactNo!,
          techTainmentUser2name: participateData.techTainmentUser2name!,
          techTainmentUser2email: participateData.techTainmentUser2email!,
          techTainmentUser2collegename:
              participateData.techTainmentUser1collegename!,
          techTainmentUser2enrollmentno:
              participateData.techTainmentUser2enrollmentnO!,
          techTainmentUser2sem: participateData.techTainmentUser2sem!,
          techTainmentUser2Branch: participateData.techTainmentUser2branch!,
          techTainmentUser2contactNo:
              participateData.techTainmentUser2contactNo!,
          techTainmentUser3name: participateData.techTainmentUser3name!,
          techTainmentUser3email: participateData.techTainmentUser3email!,
          techTainmentUser3collegename:
              participateData.techTainmentUser3collegename!,
          techTainmentUser3enrollmentno:
              participateData.techTainmentUser3enrollmentnO!,
          techTainmentUser3sem: participateData.techTainmentUser3sem!,
          techTainmentUser3Branch: participateData.techTainmentUser3branch!,
          techTainmentUser3contactNo:
              participateData.techTainmentUser3contactNo!,
        );
      }

      //for TheCivilSafari
      if (participateData.isTheCivilSafari == true) {
        //for adding all game name in payment class
        setState(() {
          isGameTheCivilSafari = 'True';
        });

        //add game with payment id in TheCivilSafari game collection
        authService.TheCivilSafari(
          context: context,
          cuponCode: coupenCode!,
          paymentStatus: 'Pending',
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
          isGameDekathon = 'True';
        });

        //add game with payment id in TechTainment game collection
        authService.DekathoneUser(
          context: context,
          cuponCode: coupenCode!,
          paymentStatus: 'Pending',
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
          DekathoneUser3enrollmentno:
              participateData.DekathonUser3enrollmentnO!,
          DekathoneUser3sem: participateData.DekathonUser3sem!,
          DekathoneUser3Branch: participateData.DekathonUser3branch!,
          DekathoneUser3contactNo: participateData.DekathonUser3contactNo!,
          DekathoneUser4name: participateData.DekathonUser4name!,
          DekathoneUser4email: participateData.DekathontUser4email!,
          DekathoneUser4collegename: participateData.DekathonUser4collegename!,
          DekathoneUser4enrollmentno:
              participateData.DekathonUser4enrollmentnO!,
          DekathoneUser4sem: participateData.DekathonUser4sem!,
          DekathoneUser4Branch: participateData.DekathonUser4branch!,
          DekathoneUser4contactNo: participateData.DekathonUser4contactNo!,
        );
      }

      //forOfficeTennis
      if (participateData.isOfficeTennis == true) {
        //for adding all game name in payment class
        setState(() {
          isOfficeTennis = 'True';
        });

        //add game with payment id in forOfficeTennis game collection
        authService.OfficeTennis(
          context: context,
          cuponCode: coupenCode!,
          paymentStatus: 'Pending',
          timeDate: dateTime,
          OfficeTennisUser1name: participateData.OfficeTennisUser1name!,
          OfficeTennisUser1email: participateData.OfficeTennisUser1email!,
          OfficeTennisUser1collegename:
              participateData.OfficeTennisUser1collegename!,
          OfficeTennisUser1enrollmentno:
              participateData.OfficeTennisUser1enrollmentnO!,
          OfficeTennisUser1sem: participateData.OfficeTennisUser1sem!,
          OfficeTennisUser1Branch: participateData.OfficeTennisUser1branch!,
          OfficeTennisUser1contactNo:
              participateData.OfficeTennisUser1contactNo!,
          OfficeTennisUser2name: participateData.OfficeTennisUser2name!,
          OfficeTennisUser2email: participateData.OfficeTennisUser2email!,
          OfficeTennisUser2collegename:
              participateData.OfficeTennisUser2collegename!,
          OfficeTennisUser2enrollmentno:
              participateData.OfficeTennisUser2enrollmentnO!,
          OfficeTennisUser2sem: participateData.OfficeTennisUser2sem!,
          OfficeTennisUser2Branch: participateData.OfficeTennisUser2branch!,
          OfficeTennisUser2contactNo:
              participateData.OfficeTennisUser2contactNo!,
        );
      }

      //ScavengerHunt
      if (participateData.isScavengerHunt == true) {
        //for adding all game name in payment class
        setState(() {
          isGameScavengerHunt = 'True';
        });

        //add game with payment id in MechanicalDroids game collection
        authService.ScavengerHunt(
          context: context,
          cuponCode: coupenCode!,
          paymentStatus: 'Pending',
          timeDate: dateTime,
          ScavengerHuntUser1name: participateData.ScavengerHuntUser1name!,
          ScavengerHuntUser1email: participateData.ScavengerHuntUser1email!,
          ScavengerHuntUser1collegename:
              participateData.ScavengerHuntUser1collegename!,
          ScavengerHuntUser1enrollmentno:
              participateData.ScavengerHuntUser1enrollmentnO!,
          ScavengerHuntUser1sem: participateData.ScavengerHuntUser1sem!,
          ScavengerHuntUser1Branch: participateData.ScavengerHuntUser1branch!,
          ScavengerHuntUser1contactNo:
              participateData.ScavengerHuntUser1contactNo!,
          ScavengerHuntUser2name: participateData.ScavengerHuntUser2name!,
          ScavengerHuntUser2email: participateData.ScavengerHuntUser2email!,
          ScavengerHuntUser2collegename:
              participateData.ScavengerHuntUser1collegename!,
          ScavengerHuntUser2enrollmentno:
              participateData.ScavengerHuntUser2enrollmentnO!,
          ScavengerHuntUser2sem: participateData.ScavengerHuntUser2sem!,
          ScavengerHuntUser2Branch: participateData.ScavengerHuntUser2branch!,
          ScavengerHuntUser2contactNo:
              participateData.ScavengerHuntUser2contactNo!,
          ScavengerHuntUser3name: participateData.ScavengerHuntUser3name!,
          ScavengerHuntUser3email: participateData.ScavengerHuntUser3email!,
          ScavengerHuntUser3collegename:
              participateData.ScavengerHuntUser3collegename!,
          ScavengerHuntUser3enrollmentno:
              participateData.ScavengerHuntUser3enrollmentnO!,
          ScavengerHuntUser3sem: participateData.ScavengerHuntUser3sem!,
          ScavengerHuntUser3Branch: participateData.ScavengerHuntUser3branch!,
          ScavengerHuntUser3contactNo:
              participateData.ScavengerHuntUser3contactNo!,
        );
      }

      //FOR Diploma Games
      //for GullyCricket
      if (participateData.isGullyCricket == true) {
        //for adding all game name in payment class
        setState(() {
          isGameGullyCricket = 'True';
        });

        //add game in GullyCricket collection
        authService.GullyCricket(
          context: context,
          cuponCode: coupenCode!,
          paymentStatus: 'Pending',
          timeDate: dateTime,
          GullyCricketUser1name: participateData.GullyCricketUser1name!,
          GullyCricketUser1email: participateData.GullyCricketUser1email!,
          GullyCricketUser1collegename:
              participateData.GullyCricketUser1collegename!,
          GullyCricketUser1enrollmentno:
              participateData.GullyCricketUser1enrollmentnO!,
          GullyCricketUser1sem: participateData.GullyCricketUser1sem!,
          GullyCricketUser1Branch: participateData.GullyCricketUser1branch!,
          GullyCricketUser1contactNo:
              participateData.GullyCricketUser1contactNo!,
        );
      }

      //for MultiMediaPrse
      if (participateData.isMultiMediaPrse == true) {
        //for adding all game name in payment class
        setState(() {
          isGameMultimediaPrse = 'True';
        });

        //add game in MultiMediaPrse collection
        authService.MultiMediaPrse(
          context: context,
          cuponCode: coupenCode!,
          paymentStatus: 'Pending',
          timeDate: dateTime,
          MultiMediaPrseUser1name: participateData.MultiMediaPrseUser1name!,
          MultiMediaPrseUser1email: participateData.MultiMediaPrseUser1email!,
          MultiMediaPrseUser1collegename:
              participateData.MultiMediaPrseUser1collegename!,
          MultiMediaPrseUser1enrollmentno:
              participateData.MultiMediaPrseUser1enrollmentnO!,
          MultiMediaPrseUser1sem: participateData.MultiMediaPrseUser1sem!,
          MultiMediaPrseUser1Branch: participateData.MultiMediaPrseUser1branch!,
          MultiMediaPrseUser1contactNo:
              participateData.MultiMediaPrseUser1contactNo!,
          MultiMediaPrseUser2name: participateData.MultiMediaPrseUser2name!,
          MultiMediaPrseUser2email: participateData.MultiMediaPrseUser2email!,
          MultiMediaPrseUser2collegename:
              participateData.MultiMediaPrseUser2collegename!,
          MultiMediaPrseUser2enrollmentno:
              participateData.MultiMediaPrseUser2enrollmentnO!,
          MultiMediaPrseUser2sem: participateData.MultiMediaPrseUser2sem!,
          MultiMediaPrseUser2Branch: participateData.MultiMediaPrseUser2branch!,
          MultiMediaPrseUser2contactNo:
              participateData.MultiMediaPrseUser2contactNo!,
        );
      }

      //for OneMinuteGame
      if (participateData.isOneMinuteGame == true) {
        //for adding all game name in payment class
        setState(() {
          isGameOneMinuteGame = 'True';
        });
        //add game in OneMinuteGame collection
        authService.OneMinuteGame(
          context: context,
          cuponCode: coupenCode!,
          paymentStatus: 'Pending',
          timeDate: dateTime,
          OneMinuteGameUser1name: participateData.OneMinuteGameUser1name!,
          OneMinuteGameUser1email: participateData.OneMinuteGameUser1email!,
          OneMinuteGameUser1collegename:
              participateData.OneMinuteGameUser1collegename!,
          OneMinuteGameUser1enrollmentno:
              participateData.OneMinuteGameUser1enrollmentnO!,
          OneMinuteGameUser1sem: participateData.OneMinuteGameUser1sem!,
          OneMinuteGameUser1Branch: participateData.OneMinuteGameUser1branch!,
          OneMinuteGameUser1contactNo:
              participateData.OneMinuteGameUser1contactNo!,
        );
      }

      //for PosterTalk
      if (participateData.isPosterTalk == true) {
        //for adding all game name in payment class
        setState(() {
          isGamePosterTalk = 'True';
        });

        //add game in PosterTalk collection
        authService.PosterTalk(
          context: context,
          cuponCode: coupenCode!,
          paymentStatus: 'Pending',
          timeDate: dateTime,
          PosterTalkUser1name: participateData.PosterTalkUser1name!,
          PosterTalkUser1email: participateData.PosterTalkUser1email!,
          PosterTalkUser1collegename:
              participateData.PosterTalkUser1collegename!,
          PosterTalkUser1enrollmentno:
              participateData.PosterTalkUser1enrollmentnO!,
          PosterTalkUser1sem: participateData.PosterTalkUser1sem!,
          PosterTalkUser1Branch: participateData.PosterTalkUser1branch!,
          PosterTalkUser1contactNo: participateData.PosterTalkUser1contactNo!,
        );
      }

      //for ProjecExpo
      if (participateData.isProjecExpo == true) {
        //for adding all game name in payment class
        setState(() {
          isGameProjectExpo = 'True';
        });

        //add game in ProjecExpo collection
        authService.ProjecExpo(
          context: context,
          cuponCode: coupenCode!,
          paymentStatus: 'Pending',
          timeDate: dateTime,
          ProjecExpoUser1name: participateData.ProjecExpoUser1name!,
          ProjecExpoUser1email: participateData.ProjecExpoUser1email!,
          ProjecExpoUser1collegename:
              participateData.ProjecExpoUser1collegename!,
          ProjecExpoUser1enrollmentno:
              participateData.ProjecExpoUser1enrollmentnO!,
          ProjecExpoUser1sem: participateData.ProjecExpoUser1sem!,
          ProjecExpoUser1Branch: participateData.ProjecExpoUser1branch!,
          ProjecExpoUser1contactNo: participateData.ProjecExpoUser1contactNo!,
          ProjecExpoUser2name: participateData.ProjecExpoUser2name!,
          ProjecExpoUser2email: participateData.ProjecExpoUser2email!,
          ProjecExpoUser2collegename:
              participateData.ProjecExpoUser2collegename!,
          ProjecExpoUser2enrollmentno:
              participateData.ProjecExpoUser2enrollmentnO!,
          ProjecExpoUser2sem: participateData.ProjecExpoUser2sem!,
          ProjecExpoUser2Branch: participateData.ProjecExpoUser2branch!,
          ProjecExpoUser2contactNo: participateData.ProjecExpoUser2contactNo!,
          ProjecExpoUser3name: participateData.ProjecExpoUser3name!,
          ProjecExpoUser3email: participateData.ProjecExpoUser3email!,
          ProjecExpoUser3collegename:
              participateData.ProjecExpoUser3collegename!,
          ProjecExpoUser3enrollmentno:
              participateData.ProjecExpoUser3enrollmentnO!,
          ProjecExpoUser3sem: participateData.ProjecExpoUser3sem!,
          ProjecExpoUser3Branch: participateData.ProjecExpoUser3branch!,
          ProjecExpoUser3contactNo: participateData.ProjecExpoUser3contactNo!,
          ProjecExpoUser4name: participateData.ProjecExpoUser4name!,
          ProjecExpoUser4email: participateData.ProjecExpoUser4email!,
          ProjecExpoUser4collegename:
              participateData.ProjecExpoUser4collegename!,
          ProjecExpoUser4enrollmentno:
              participateData.ProjecExpoUser4enrollmentnO!,
          ProjecExpoUser4sem: participateData.ProjecExpoUser4sem!,
          ProjecExpoUser4Branch: participateData.ProjecExpoUser4branch!,
          ProjecExpoUser4contactNo: participateData.ProjecExpoUser4contactNo!,
        );
      }

      //for SharkTank
      if (participateData.isSharkTank == true) {
        //for adding all game name in payment class
        setState(() {
          isGameSharkTank = 'True';
        });

        //add game in SharkTank collection
        authService.SharkTank(
          context: context,
          cuponCode: coupenCode!,
          paymentStatus: 'Pending',
          timeDate: dateTime,
          SharkTankUser1name: participateData.SharkTankUser1name!,
          SharkTankUser1email: participateData.SharkTankUser1email!,
          SharkTankUser1collegename: participateData.SharkTankUser1collegename!,
          SharkTankUser1enrollmentno:
              participateData.SharkTankUser1enrollmentnO!,
          SharkTankUser1sem: participateData.SharkTankUser1sem!,
          SharkTankUser1Branch: participateData.SharkTankUser1branch!,
          SharkTankUser1contactNo: participateData.SharkTankUser1contactNo!,
          SharkTankUser2name: participateData.SharkTankUser2name!,
          SharkTankUser2email: participateData.SharkTankUser2email!,
          SharkTankUser2collegename: participateData.SharkTankUser2collegename!,
          SharkTankUser2enrollmentno:
              participateData.SharkTankUser2enrollmentnO!,
          SharkTankUser2sem: participateData.SharkTankUser2sem!,
          SharkTankUser2Branch: participateData.SharkTankUser2branch!,
          SharkTankUser2contactNo: participateData.SharkTankUser2contactNo!,
        );
      }

      //for TechnoSketch
      if (participateData.isTechnoSketch == true) {
        //for adding all game name in payment class
        setState(() {
          isGameTechnoSketch = 'True';
        });

        //add game in TechnoSketch collection
        authService.TechnoSketch(
          context: context,
          cuponCode: coupenCode!,
          paymentStatus: 'Pending',
          timeDate: dateTime,
          TechnoSketchUser1name: participateData.TechnoSketchUser1name!,
          TechnoSketchUser1email: participateData.TechnoSketchUser1email!,
          TechnoSketchUser1collegename:
              participateData.TechnoSketchUser1collegename!,
          TechnoSketchUser1enrollmentno:
              participateData.TechnoSketchUser1enrollmentnO!,
          TechnoSketchUser1sem: participateData.TechnoSketchUser1sem!,
          TechnoSketchUser1Branch: participateData.TechnoSketchUser1branch!,
          TechnoSketchUser1contactNo:
              participateData.TechnoSketchUser1contactNo!,
        );
      }

      //for TechOModel
      if (participateData.isTechOModel == true) {
        //for adding all game name in payment class
        setState(() {
          isGameTechOModel = 'True';
        });

        //add game in TechOModel collection
        authService.TechOModel(
          context: context,
          cuponCode: coupenCode!,
          paymentStatus: 'Pending',
          timeDate: dateTime,
          TechOModelUser1name: participateData.TechOModelUser1name!,
          TechOModelUser1email: participateData.TechOModelUser1email!,
          TechOModelUser1collegename:
              participateData.TechOModelUser1collegename!,
          TechOModelUser1enrollmentno:
              participateData.TechOModelUser1enrollmentnO!,
          TechOModelUser1sem: participateData.TechOModelUser1sem!,
          TechOModelUser1Branch: participateData.TechOModelUser1branch!,
          TechOModelUser1contactNo: participateData.TechOModelUser1contactNo!,
          TechOModelUser2name: participateData.TechOModelUser2name!,
          TechOModelUser2email: participateData.TechOModelUser2email!,
          TechOModelUser2collegename:
              participateData.TechOModelUser2collegename!,
          TechOModelUser2enrollmentno:
              participateData.TechOModelUser2enrollmentnO!,
          TechOModelUser2sem: participateData.TechOModelUser2sem!,
          TechOModelUser2Branch: participateData.TechOModelUser2branch!,
          TechOModelUser2contactNo: participateData.TechOModelUser2contactNo!,
        );
      }

      //for VadicMaths
      if (participateData.isVadicMaths == true) {
        //for adding all game name in payment class
        setState(() {
          isGameVadicMaths = 'True';
        });

        //add game in VadicMaths collection
        authService.VadicMaths(
          context: context,
          cuponCode: coupenCode!,
          paymentStatus: 'Pending',
          timeDate: dateTime,
          VadicMathsUser1name: participateData.VadicMathsUser1name!,
          VadicMathsUser1email: participateData.VadicMathsUser1email!,
          VadicMathsUser1collegename:
              participateData.VadicMathsUser1collegename!,
          VadicMathsUser1enrollmentno:
              participateData.VadicMathsUser1enrollmentnO!,
          VadicMathsUser1sem: participateData.VadicMathsUser1sem!,
          VadicMathsUser1Branch: participateData.VadicMathsUser1branch!,
          VadicMathsUser1contactNo: participateData.VadicMathsUser1contactNo!,
        );
      }

      // add payment in payment collection Of Db
      //for degree
      if (diplomaORdegree == 'Degree') {
        authService.addINTODegreePayment(
          context: context,
          userId: userid!,
          cuponCode: coupenCode!,
          paymentStatus: 'Pending',
          amount: PayingAmounttodiplayHistoryPage.toString(),
          timeDate: dateTime,
          GameTalaash: isGameTalaash,
          GameTechTainment: isGameTechTainment,
          GameTheCivilSafari: isGameTheCivilSafari,
          GameDekathon: isGameDekathon,
          GameOfficeTennis: isOfficeTennis,
          GameScavengerHunt: isGameScavengerHunt,
          playername: userName!,
          playeremail: userEmail!,
          playercollgename: userCollegeName!,
          playerenrollmentNo: userEnNo!,
          playerContactNo: userContactNo!,
        );
      }

      //for diploma
      if (diplomaORdegree == "Diploma") {
        authService.addINTODiplomaPayment(
          context: context,
          userId: userid!,
          cuponCode: coupenCode!,
          paymentStatus: 'Pending',
          amount: PayingAmounttodiplayHistoryPage.toString(),
          timeDate: dateTime,
          GameProjectExpo: isGameProjectExpo,
          GamePosterTalk: isGamePosterTalk,
          GameTechnoSketch: isGameTechnoSketch,
          GameSharkTank: isGameSharkTank,
          GameGullyCricket: isGameGullyCricket,
          GameVadicMaths: isGameVadicMaths,
          GameOneMinuteGame: isGameOneMinuteGame,
          GameTechOModel: isGameTechOModel,
          GameMultimediaPrse: isGameMultimediaPrse,
          playername: userName!,
          playeremail: userEmail!,
          playercollgename: userCollegeName!,
          playerenrollmentNo: userEnNo!,
          playerContactNo: userContactNo!,
        );
      }

      //for Showing Loaing Indicator
      Future.delayed(
        Duration(seconds: 6),
        () {
          //show pop-up box
          QuickAlert.show(
            context: context,
            type: QuickAlertType.success,
            title: "Register Success",
            text: "Please do payment offline using coupen code",
            confirmBtnText: "Thanks!",
            confirmBtnColor: Color.fromARGB(255, 47, 196, 52),
            width: 25,
          );

          nextScreen(context, FirstPage());
        },
      );

      //after register in game remove games from cart
      var cart = Provider.of<CartModel>(context, listen: false);
      cart.clearCart();
    } catch (e) {
      //show pop-up box
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: "Register Failed",
        text: e.toString(),
        confirmBtnText: "Try Again!",
        confirmBtnColor: Color.fromARGB(255, 255, 13, 13),
        width: 25,
      );
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
        body: isLoading
            ? Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Image(
                      image: AssetImage("assets/icons/pleasewait.gif"),
                    ),
                  ),
                  Text(
                    "Wait a moment",
                    style: TextStyle(
                      fontFamily: 'OpenSanse',
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontSize: 30,
                    ),
                  ),
                  Text(
                    "We are register your team",
                    style: TextStyle(
                      fontFamily: 'OpenSanse',
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ],
              )
            : SingleChildScrollView(
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 15),
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 65),
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 85),
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 105),
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 125),
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 145),
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 165),
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 185),
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 235),
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 255),
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 275),
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 295),
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 315),
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 335),
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 355),
                                child: Text(
                                  "player-2  Contact No: ${participateData.talaashUser2contactNo}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 15),
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 65),
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 85),
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 105),
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 125),
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 145),
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 165),
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 185),
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 225),
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 245),
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 265),
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 285),
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 300),
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 320),
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 340),
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 390),
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 410),
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 430),
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 450),
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 470),
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 490),
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 510),
                                child: Text(
                                  "player-3  Contact No: ${participateData.techTainmentUser3contactNo}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 15),
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 65),
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 85),
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 105),
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 125),
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 145),
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 165),
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 185),
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 225),
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 245),
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 265),
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 285),
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 300),
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 320),
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 340),
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 390),
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 410),
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 430),
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 450),
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 470),
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 490),
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 510),
                                child: Text(
                                  "player-3  Contact No: ${participateData.TheCivilSafariUser3contactNo}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 15),
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 65),
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 85),
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 105),
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 125),
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 145),
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 165),
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 185),
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 225),
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 245),
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 265),
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 285),
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 300),
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 320),
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 340),
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 390),
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 410),
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 430),
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 450),
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 470),
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 490),
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 510),
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 550),
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 570),
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 590),
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 610),
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 630),
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 650),
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 670),
                                child: Text(
                                  "player-4  Contact No: ${participateData.DekathonUser4contactNo}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 15),
                                child: Text(
                                  "Team-Office Tennis",
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 65),
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 85),
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 105),
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 125),
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 145),
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 165),
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 185),
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 235),
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 255),
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 275),
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 295),
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 315),
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 335),
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 355),
                                child: Text(
                                  "player-2  Contact No: ${participateData.OfficeTennisUser2contactNo}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],

                    SizedBox(height: 15),

                    //for Game MechanicalDroids
                    if (participateData.isScavengerHunt == true) ...[
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 15),
                                child: Text(
                                  "Team-Scavenger Hunt",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 25,
                                  ),
                                ),
                              ),

                              //for user-1
                              //leader name
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 65),
                                child: Text(
                                  "Leader name: ${participateData.ScavengerHuntUser1name}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //leader email
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 85),
                                child: Text(
                                  "Leader email: ${participateData.ScavengerHuntUser1email}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //leader college name
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 105),
                                child: Text(
                                  "Leader college: ${participateData.ScavengerHuntUser1collegename}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //leader enrollment no
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 125),
                                child: Text(
                                  "Leader En.No: ${participateData.ScavengerHuntUser1enrollmentnO}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //leader sem
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 145),
                                child: Text(
                                  "Leader Sem: ${participateData.ScavengerHuntUser1sem}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //leader branch
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 165),
                                child: Text(
                                  "Leader Branch: ${participateData.ScavengerHuntUser1branch}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //leader contact no
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 185),
                                child: Text(
                                  "Leader Contact No: ${participateData.ScavengerHuntUser1contactNo}",
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 225),
                                child: Text(
                                  "player-2 name: ${participateData.ScavengerHuntUser2name}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //player-2  email
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 245),
                                child: Text(
                                  "player-2  email: ${participateData.ScavengerHuntUser2email}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //player-2  college name
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 265),
                                child: Text(
                                  "player-2 college: ${participateData.ScavengerHuntUser2collegename}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //player-2  enrollment no
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 285),
                                child: Text(
                                  "player-2  En.No: ${participateData.ScavengerHuntUser2enrollmentnO}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //player-2  sem
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 300),
                                child: Text(
                                  "player-2  Sem: ${participateData.ScavengerHuntUser2sem}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //player-2  branch
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 320),
                                child: Text(
                                  "player-2  Branch: ${participateData.ScavengerHuntUser2branch}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //player-2  contact no
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 340),
                                child: Text(
                                  "player-2  Contact No: ${participateData.ScavengerHuntUser2contactNo}",
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 390),
                                child: Text(
                                  "player-3 name: ${participateData.ScavengerHuntUser3name}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //player-3  email
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 410),
                                child: Text(
                                  "player-3  email: ${participateData.ScavengerHuntUser3email}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //player-3 college name
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 430),
                                child: Text(
                                  "player-3 college: ${participateData.ScavengerHuntUser3collegename}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //player-3  enrollment no
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 450),
                                child: Text(
                                  "player-3  En.No: ${participateData.ScavengerHuntUser3enrollmentnO}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //player-3  sem
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 470),
                                child: Text(
                                  "player-3  Sem: ${participateData.ScavengerHuntUser3sem}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //player-3  branch
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 490),
                                child: Text(
                                  "player-3  Branch: ${participateData.ScavengerHuntUser3branch}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //player-3 contact no
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 510),
                                child: Text(
                                  "player-3  Contact No: ${participateData.ScavengerHuntUser3contactNo}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],

                    SizedBox(height: 15),

                    //*********************************************************************/
                    //For Diploma Games
                    //For GullyCricket
                    if (participateData.isGullyCricket == true) ...[
                      Center(
                        child: Container(
                          height: height / 3.4,
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 15),
                                child: Text(
                                  "Gully Cricket",
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 65),
                                child: Text(
                                  "Leader name: ${participateData.GullyCricketUser1name}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //leader email
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 85),
                                child: Text(
                                  "Leader email: ${participateData.GullyCricketUser1email}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //leader college name
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 105),
                                child: Text(
                                  "Leader college: ${participateData.GullyCricketUser1collegename}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //leader enrollment no
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 125),
                                child: Text(
                                  "Leader En.No: ${participateData.GullyCricketUser1enrollmentnO}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //leader sem
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 145),
                                child: Text(
                                  "Leader Sem: ${participateData.GullyCricketUser1sem}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //leader branch
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 165),
                                child: Text(
                                  "Leader Branch: ${participateData.GullyCricketUser1branch}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //leader contact no
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 185),
                                child: Text(
                                  "Leader Contact No: ${participateData.GullyCricketUser1contactNo}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],

                    SizedBox(height: 15),

                    //For One Minute Game
                    if (participateData.isOneMinuteGame == true) ...[
                      Center(
                        child: Container(
                          height: height / 3.4,
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 15),
                                child: Text(
                                  "One Minute Game",
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 65),
                                child: Text(
                                  "Leader name: ${participateData.OneMinuteGameUser1name}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //leader email
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 85),
                                child: Text(
                                  "Leader email: ${participateData.OneMinuteGameUser1email}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //leader college name
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 105),
                                child: Text(
                                  "Leader college: ${participateData.OneMinuteGameUser1collegename}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //leader enrollment no
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 125),
                                child: Text(
                                  "Leader En.No: ${participateData.OneMinuteGameUser1enrollmentnO}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //leader sem
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 145),
                                child: Text(
                                  "Leader Sem: ${participateData.OneMinuteGameUser1sem}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //leader branch
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 165),
                                child: Text(
                                  "Leader Branch: ${participateData.OneMinuteGameUser1branch}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //leader contact no
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 185),
                                child: Text(
                                  "Leader Contact No: ${participateData.OneMinuteGameUser1contactNo}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],

                    SizedBox(height: 15),

                    //For Poster Talk
                    if (participateData.isPosterTalk == true) ...[
                      Center(
                        child: Container(
                          height: height / 3.4,
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 15),
                                child: Text(
                                  "Poster Talk",
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 65),
                                child: Text(
                                  "Leader name: ${participateData.PosterTalkUser1name}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //leader email
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 85),
                                child: Text(
                                  "Leader email: ${participateData.PosterTalkUser1email}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //leader college name
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 105),
                                child: Text(
                                  "Leader college: ${participateData.PosterTalkUser1collegename}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //leader enrollment no
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 125),
                                child: Text(
                                  "Leader En.No: ${participateData.PosterTalkUser1enrollmentnO}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //leader sem
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 145),
                                child: Text(
                                  "Leader Sem: ${participateData.PosterTalkUser1sem}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //leader branch
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 165),
                                child: Text(
                                  "Leader Branch: ${participateData.PosterTalkUser1branch}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //leader contact no
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 185),
                                child: Text(
                                  "Leader Contact No: ${participateData.PosterTalkUser1contactNo}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],

                    SizedBox(height: 15),

                    //For Techno Sketch
                    if (participateData.isTechnoSketch == true) ...[
                      Center(
                        child: Container(
                          height: height / 3.4,
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 15),
                                child: Text(
                                  "Techno Sketch",
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 65),
                                child: Text(
                                  "Leader name: ${participateData.TechnoSketchUser1name}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //leader email
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 85),
                                child: Text(
                                  "Leader email: ${participateData.TechnoSketchUser1email}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //leader college name
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 105),
                                child: Text(
                                  "Leader college: ${participateData.TechnoSketchUser1collegename}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //leader enrollment no
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 125),
                                child: Text(
                                  "Leader En.No: ${participateData.TechnoSketchUser1enrollmentnO}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //leader sem
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 145),
                                child: Text(
                                  "Leader Sem: ${participateData.TechnoSketchUser1sem}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //leader branch
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 165),
                                child: Text(
                                  "Leader Branch: ${participateData.TechnoSketchUser1branch}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //leader contact no
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 185),
                                child: Text(
                                  "Leader Contact No: ${participateData.TechnoSketchUser1contactNo}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],

                    SizedBox(height: 15),

                    //For Vadic Maths
                    if (participateData.isVadicMaths == true) ...[
                      Center(
                        child: Container(
                          height: height / 3.4,
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 15),
                                child: Text(
                                  "Vadic-Maths",
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 65),
                                child: Text(
                                  "Leader name: ${participateData.VadicMathsUser1name}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //leader email
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 85),
                                child: Text(
                                  "Leader email: ${participateData.VadicMathsUser1email}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //leader college name
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 105),
                                child: Text(
                                  "Leader college: ${participateData.VadicMathsUser1collegename}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //leader enrollment no
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 125),
                                child: Text(
                                  "Leader En.No: ${participateData.VadicMathsUser1enrollmentnO}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //leader sem
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 145),
                                child: Text(
                                  "Leader Sem: ${participateData.VadicMathsUser1sem}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //leader branch
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 165),
                                child: Text(
                                  "Leader Branch: ${participateData.VadicMathsUser1branch}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //leader contact no
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 185),
                                child: Text(
                                  "Leader Contact No: ${participateData.VadicMathsUser1contactNo}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],

                    SizedBox(height: 15),

                    //for Game MultiMediaPrse
                    if (participateData.isMultiMediaPrse == true) ...[
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 15),
                                child: Text(
                                  "Multi Media Prse.",
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 65),
                                child: Text(
                                  "Leader name: ${participateData.MultiMediaPrseUser1name}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //leader email
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 85),
                                child: Text(
                                  "Leader email: ${participateData.MultiMediaPrseUser1email}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //leader college name
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 105),
                                child: Text(
                                  "Leader college: ${participateData.MultiMediaPrseUser1collegename}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //leader enrollment no
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 125),
                                child: Text(
                                  "Leader En.No: ${participateData.MultiMediaPrseUser1enrollmentnO}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //leader sem
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 145),
                                child: Text(
                                  "Leader Sem: ${participateData.MultiMediaPrseUser1sem}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //leader branch
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 165),
                                child: Text(
                                  "Leader Branch: ${participateData.MultiMediaPrseUser1branch}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //leader contact no
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 185),
                                child: Text(
                                  "Leader Contact No: ${participateData.MultiMediaPrseUser1contactNo}",
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 235),
                                child: Text(
                                  "player-2 name: ${participateData.MultiMediaPrseUser2name}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //player-2  email
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 255),
                                child: Text(
                                  "player-2  email: ${participateData.MultiMediaPrseUser2email}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //player-2  college name
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 275),
                                child: Text(
                                  "player-2 college: ${participateData.MultiMediaPrseUser2collegename}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //player-2  enrollment no
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 295),
                                child: Text(
                                  "player-2  En.No: ${participateData.MultiMediaPrseUser2enrollmentnO}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //player-2  sem
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 315),
                                child: Text(
                                  "player-2  Sem: ${participateData.MultiMediaPrseUser2sem}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //player-2  branch
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 335),
                                child: Text(
                                  "player-2  Branch: ${participateData.MultiMediaPrseUser2branch}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //player-2  contact no
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 355),
                                child: Text(
                                  "player-2  Contact No: ${participateData.MultiMediaPrseUser2contactNo}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],

                    SizedBox(height: 15),

                    //for Game Shark Tank
                    if (participateData.isSharkTank == true) ...[
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 15),
                                child: Text(
                                  "Shark Tank",
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 65),
                                child: Text(
                                  "Leader name: ${participateData.SharkTankUser1name}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //leader email
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 85),
                                child: Text(
                                  "Leader email: ${participateData.SharkTankUser1email}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //leader college name
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 105),
                                child: Text(
                                  "Leader college: ${participateData.SharkTankUser1collegename}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //leader enrollment no
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 125),
                                child: Text(
                                  "Leader En.No: ${participateData.SharkTankUser1enrollmentnO}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //leader sem
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 145),
                                child: Text(
                                  "Leader Sem: ${participateData.SharkTankUser1sem}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //leader branch
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 165),
                                child: Text(
                                  "Leader Branch: ${participateData.SharkTankUser1branch}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //leader contact no
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 185),
                                child: Text(
                                  "Leader Contact No: ${participateData.SharkTankUser1contactNo}",
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 235),
                                child: Text(
                                  "player-2 name: ${participateData.SharkTankUser2name}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //player-2  email
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 255),
                                child: Text(
                                  "player-2  email: ${participateData.SharkTankUser2email}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //player-2  college name
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 275),
                                child: Text(
                                  "player-2 college: ${participateData.SharkTankUser2collegename}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //player-2  enrollment no
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 295),
                                child: Text(
                                  "player-2  En.No: ${participateData.SharkTankUser2enrollmentnO}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //player-2  sem
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 315),
                                child: Text(
                                  "player-2  Sem: ${participateData.SharkTankUser2sem}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //player-2  branch
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 335),
                                child: Text(
                                  "player-2  Branch: ${participateData.SharkTankUser2branch}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //player-2  contact no
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 355),
                                child: Text(
                                  "player-2  Contact No: ${participateData.SharkTankUser2contactNo}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],

                    SizedBox(height: 15),

                    //for Game Tech-O-Model
                    if (participateData.isTechOModel == true) ...[
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 15),
                                child: Text(
                                  "Tech-O-Model",
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 65),
                                child: Text(
                                  "Leader name: ${participateData.TechOModelUser1name}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //leader email
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 85),
                                child: Text(
                                  "Leader email: ${participateData.TechOModelUser1email}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //leader college name
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 105),
                                child: Text(
                                  "Leader college: ${participateData.TechOModelUser1collegename}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //leader enrollment no
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 125),
                                child: Text(
                                  "Leader En.No: ${participateData.TechOModelUser1enrollmentnO}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //leader sem
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 145),
                                child: Text(
                                  "Leader Sem: ${participateData.TechOModelUser1sem}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //leader branch
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 165),
                                child: Text(
                                  "Leader Branch: ${participateData.TechOModelUser1branch}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //leader contact no
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 185),
                                child: Text(
                                  "Leader Contact No: ${participateData.TechOModelUser1contactNo}",
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 235),
                                child: Text(
                                  "player-2 name: ${participateData.TechOModelUser2name}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //player-2  email
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 255),
                                child: Text(
                                  "player-2  email: ${participateData.TechOModelUser2email}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //player-2  college name
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 275),
                                child: Text(
                                  "player-2 college: ${participateData.TechOModelUser2collegename}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //player-2  enrollment no
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 295),
                                child: Text(
                                  "player-2  En.No: ${participateData.TechOModelUser2enrollmentnO}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //player-2  sem
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 315),
                                child: Text(
                                  "player-2  Sem: ${participateData.TechOModelUser2sem}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //player-2  branch
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 335),
                                child: Text(
                                  "player-2  Branch: ${participateData.TechOModelUser2branch}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //player-2  contact no
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 355),
                                child: Text(
                                  "player-2  Contact No: ${participateData.TechOModelUser2contactNo}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],

                    SizedBox(height: 15),

                    //for Projec Expo
                    if (participateData.isProjecExpo == true) ...[
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 15),
                                child: Text(
                                  "Projec Expo.",
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 65),
                                child: Text(
                                  "Leader name: ${participateData.ProjecExpoUser1name}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //leader email
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 85),
                                child: Text(
                                  "Leader email: ${participateData.ProjecExpoUser1email}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //leader college name
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 105),
                                child: Text(
                                  "Leader college: ${participateData.ProjecExpoUser1collegename}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //leader enrollment no
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 125),
                                child: Text(
                                  "Leader En.No: ${participateData.ProjecExpoUser1enrollmentnO}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //leader sem
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 145),
                                child: Text(
                                  "Leader Sem: ${participateData.ProjecExpoUser1sem}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //leader branch
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 165),
                                child: Text(
                                  "Leader Branch: ${participateData.ProjecExpoUser1branch}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //leader contact no
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 185),
                                child: Text(
                                  "Leader Contact No: ${participateData.ProjecExpoUser1contactNo}",
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 225),
                                child: Text(
                                  "player-2 name: ${participateData.ProjecExpoUser2name}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //player-2  email
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 245),
                                child: Text(
                                  "player-2  email: ${participateData.ProjecExpoUser2email}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //player-2  college name
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 265),
                                child: Text(
                                  "player-2 college: ${participateData.ProjecExpoUser2collegename}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //player-2  enrollment no
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 285),
                                child: Text(
                                  "player-2  En.No: ${participateData.ProjecExpoUser2enrollmentnO}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //player-2  sem
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 300),
                                child: Text(
                                  "player-2  Sem: ${participateData.ProjecExpoUser2sem}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //player-2  branch
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 320),
                                child: Text(
                                  "player-2  Branch: ${participateData.ProjecExpoUser2branch}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //player-2  contact no
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 340),
                                child: Text(
                                  "player-2  Contact No: ${participateData.ProjecExpoUser2contactNo}",
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 390),
                                child: Text(
                                  "player-3 name: ${participateData.ProjecExpoUser3name}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //player-3  email
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 410),
                                child: Text(
                                  "player-3  email: ${participateData.ProjecExpoUser3email}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //player-3 college name
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 430),
                                child: Text(
                                  "player-3 college: ${participateData.ProjecExpoUser3collegename}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //player-3  enrollment no
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 450),
                                child: Text(
                                  "player-2  En.No: ${participateData.ProjecExpoUser3enrollmentnO}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //player-3  sem
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 470),
                                child: Text(
                                  "player-2  Sem: ${participateData.ProjecExpoUser3sem}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //player-3  branch
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 490),
                                child: Text(
                                  "player-2  Branch: ${participateData.ProjecExpoUser3branch}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //player-3 contact no
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 510),
                                child: Text(
                                  "player-2  Contact No: ${participateData.ProjecExpoUser3contactNo}",
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
                                padding:
                                    const EdgeInsets.only(left: 25, top: 550),
                                child: Text(
                                  "player-4 name: ${participateData.ProjecExpoUser4name}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //player-4  email
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 570),
                                child: Text(
                                  "player-4  email: ${participateData.ProjecExpoUser4email}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //player-4 college name
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 590),
                                child: Text(
                                  "player-4 college: ${participateData.ProjecExpoUser4collegename}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //player-4  enrollment no
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 610),
                                child: Text(
                                  "player-4  En.No: ${participateData.ProjecExpoUser4enrollmentnO}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //player-4  sem
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 630),
                                child: Text(
                                  "player-4  Sem: ${participateData.ProjecExpoUser4sem}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //player-4  branch
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 650),
                                child: Text(
                                  "player-4  Branch: ${participateData.ProjecExpoUser4branch}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              //player-4 contact no
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 670),
                                child: Text(
                                  "player-4  Contact No: ${participateData.ProjecExpoUser4contactNo}",
                                  style: TextStyle(
                                    fontFamily: 'OpenSanse',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],

                    SizedBox(height: 15),

                    //RegisterGame Box
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

                          //RegisterGame Button
                          InkWell(
                            onTap: () async {
                              setState(() {
                                isLoading = true;
                              });

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

                                  //get total price in int and round
                                  int money = cart.totalPrice.round();

                                  //convert to double
                                  PayingAmount = double.parse("${money}");
                                });

                                Future.delayed(
                                  Duration(seconds: 10),
                                  () {
                                    //RegisterGame Game
                                    _RegisterGame();
                                  },
                                );
                              }
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 80),
                              height: height / 16.5,
                              width: width / 2.5,
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
                                      LineIcons.gamepad,
                                      size: 35,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 6, bottom: 5),
                                    child: Text(
                                      "Register",
                                      style: TextStyle(
                                        fontFamily: 'OpenSanse',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20,
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
}
