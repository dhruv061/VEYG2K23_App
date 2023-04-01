//Using MongoDb Api
//all authnticate user in this file
// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vegy2023/models/PaymentDetailsDiploma.dart';
import 'package:vegy2023/models/paymentHistoryModel.dart';

import '../Database/error_handling.dart';
import '../Database/user.dart';
import 'package:http/http.dart' as http;

import '../Provider/userprovider.dart';
import '../models/PaymentDetailsDegree.dart';
import '../pages/BootomNevBar.dart';

import '../pages/FirstPage.dart';
import '../pages/Nextscreen.dart';
import '../pages/SnackBar.dart';

//API link
String uri = 'https://veyg-backend.onrender.com';

class AuthService {
  //sign-up user
  void signUpUser({
    required BuildContext context,
    required String name,
    required String email,
    required String phoneno,
    required String diplomaORdegree,
    required String collagename,
    required String branch,
    required String sem,
    required String EnNO,
    required String visiblepassword,
    required String password,
  }) async {
    try {
      //use User Model avliavble in Database folder
      User user = User(
        uid: '',
        name: name,
        email: email,
        phoneno: phoneno,
        diplomaORdegree: diplomaORdegree,
        collagename: collagename,
        branch: branch,
        sem: sem,
        EnNO: EnNO,
        password: password,
        visiblepassword: visiblepassword,
        token: '',
      );

      //store Response
      http.Response res;

      //call API from Node.js
      if (diplomaORdegree == "Degree") {
        //call degree api
        res = await http.post(
          Uri.parse('$uri/api/Degree/signup'),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=utf-8',
          },
        );
      } else {
        //call diploma api
        res = await http.post(
          Uri.parse('$uri/api/Diploma/signup'),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=utf-8',
          },
        );
      }

      hhtpErrorHanle(
        response: res,
        context: context,
        onSuccess: () {
          //show pop-up box
          QuickAlert.show(
            context: context,
            type: QuickAlertType.confirm,
            title: "Account Created",
            text: "Please SignIn to add game",
            confirmBtnText: "okay",
            confirmBtnColor: Color.fromARGB(255, 31, 213, 223),
            width: 25,
          );

          nextScreen(context, BottonNevBar());

          // openSnackbar(
          //     context, 'Account Created!', Color.fromARGB(255, 100, 212, 103));
        },
      );

      print(res.body);
    } catch (e) {
      openSnackbar(context, e.toString(), Color.fromARGB(255, 240, 16, 0));
    }
  }

  //this use in get data and signin user
  String? degreeOrdiplomaForGetUserData;

  //sign-in user
  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
    required String diplomaORdegree,
  }) async {
    try {
      //store result
      http.Response res;

      //call API from Node.js
      if (diplomaORdegree == 'Degree') {
        //this helpfull for getting user data
        degreeOrdiplomaForGetUserData = 'Degree';

        //call degree signin api
        res = await http.post(
          Uri.parse('$uri/api/Degree/signin'),
          body: jsonEncode({
            'email': email,
            'password': password,
          }),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=utf-8',
          },
        );
      } else {
        //this helpfull for getting user data
        degreeOrdiplomaForGetUserData = 'Diploma';

        //call diploma signin api
        res = await http.post(
          Uri.parse('$uri/api/Diploma/sigin'),
          body: jsonEncode({
            'email': email,
            'password': password,
          }),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=utf-8',
          },
        );
      }

      print("User Loged in : " + res.body);

      hhtpErrorHanle(
        response: res,
        context: context,
        onSuccess: () async {
          //shared preferances --> save token in app memeory
          SharedPreferences pref = await SharedPreferences.getInstance();

          //User provider --> save user data
          Provider.of<UserProvider>(context, listen: false).setUser(res.body);

          //shared preffreance
          await pref.setString('x-auth-token', jsonDecode(res.body)['token']);

          //store value of degree or diploma
          await pref.setString(
              'degreeORDiploma', degreeOrdiplomaForGetUserData!);

          nextScreen(context, FirstPage());

          //show succuful log-in meesage
          openSnackbar(
              context, "Log-in Successfull", Color.fromARGB(255, 70, 213, 92));
        },
      );
    } catch (e) {
      openSnackbar(context, e.toString(), Color.fromARGB(255, 246, 17, 0));
    }
  }

  //get user Data
  void getUserData(
    BuildContext context,
  ) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? token = pref.getString('x-auth-token');

      //if user is first time login
      if (token == null) {
        pref.setString('x-auth-token', '');
      }

      //call API from Node.js
      var tokenRes = await http.post(
        Uri.parse('$uri/tokenIsValid'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=utf-8',
          'x-auth-token': token!
        },
      );

      var response = jsonDecode(tokenRes.body);

      //store data
      // http.Response userRes;

      if (response == true) {
        var checkDegreeORdiploma = pref.getString('degreeORDiploma');
        // //check degree or Diploma
        // if (degreeOrdiplomaForGetUserData == 'Degree') {
        //   //get the user data
        //   userRes = await http.get(
        //     Uri.parse('$uri/api/Degree/GetUserData'),
        //     headers: <String, String>{
        //       'Content-Type': 'application/json; charset=utf-8',
        //       'x-auth-token': token
        //     },
        //   );
        // } else {
        //   //get the user data
        //   userRes = await http.get(
        //     Uri.parse('$uri/api/Diploma/GetUserData'),
        //     headers: <String, String>{
        //       'Content-Type': 'application/json; charset=utf-8',
        //       'x-auth-token': token
        //     },
        //   );
        // }

        //check degree or Diploma
        if (checkDegreeORdiploma == 'Degree') {
          //get the user data
          http.Response userResDegree = await http.get(
            Uri.parse('$uri/api/Degree/GetUserData'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=utf-8',
              'x-auth-token': token
            },
          );

          var userProvider = Provider.of<UserProvider>(context, listen: false);
          userProvider.setUser(userResDegree.body);
        } else {
          //get the user data
          http.Response userResDiploma = await http.get(
            Uri.parse('$uri/api/Diploma/GetUserData'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=utf-8',
              'x-auth-token': token
            },
          );

          var userProvider = Provider.of<UserProvider>(context, listen: false);
          userProvider.setUser(userResDiploma.body);
        }

        // var userProvider = Provider.of<UserProvider>(context, listen: false);
        // userProvider.setUser(userRes.body);

        print("APi response :" + response.toString());
        // print("Get user data method" + userRes.body);
      }
    } catch (e) {
      openSnackbar(context, e.toString(), Color.fromARGB(255, 253, 17, 0));
    }
  }

  //*************************************************************************************************/

  //For Degree
  //This all for showing payment history
  //add payment in class
  void addINTODegreePayment(
      {required BuildContext context,
      required String userId,
      required String cuponCode,
      required String paymentStatus,
      required String amount,
      required String timeDate,
      required String GameTalaash,
      required String GameTechTainment,
      required String GameTheCivilSafari,
      required String GameDekathon,
      required String GameOfficeTennis,
      required String GameScavengerHunt,
      required String playername,
      required String playeremail,
      required String playercollgename,
      required String playerenrollmentNo,
      required String playerContactNo}) async {
    try {
      // Convert request data to JSON string
      final data = {
        "userId": userId,
        "cuponCode": cuponCode,
        "paymentStatus": paymentStatus,
        "amount": amount,
        "timeDate": timeDate,
        "GameTalaash": GameTalaash,
        "GameTechTainment": GameTechTainment,
        "GameTheCivilSafari": GameTheCivilSafari,
        "GameDekathon": GameDekathon,
        "GameOfficeTennis": GameOfficeTennis,
        "ScavengerHunt": GameScavengerHunt,
        "playername": playername,
        "playeremail": playeremail,
        "playercollgename": playercollgename,
        "playerenrollmentNo": playerenrollmentNo,
        "playerContectNo": playerContactNo,
      };
      final body = jsonEncode(data);

      //call API
      http.Response res = await http.post(
        Uri.parse('$uri/Degree/payments/add'),
        body: utf8.encode(body),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=utf-8',
        },
      );

      hhtpErrorHanle(
        response: res,
        context: context,
        onSuccess: () {},
      );

      print(res.body);
    } catch (e) {
      openSnackbar(context, e.toString(), Color.fromARGB(255, 240, 16, 0));
    }
  }

  //get payment History --> in payment History page
  //here userId is current user login id
  List<PaymentHistory> paymenthistoryList = [];
  getPaymentHistory({
    required BuildContext context,
    required String userId,
  }) async {
    try {
      //crete future function because we don't have data in intially state
      // Future<List<PaymentHistory>> getPostApi() async {s
      //here we pass url where we fetch the data
      final response =
          await http.get(Uri.parse('$uri/Degree/payments/${userId}'));

      //decode the json response
      var data = jsonDecode(response.body.toString());

      //code 200 means -- data fetch is done
      if (response.statusCode == 200) {
        for (Map i in data) {
          paymenthistoryList.add(PaymentHistory.fromJson(i));
        }
        return paymenthistoryList;
      } else {
        return paymenthistoryList;
      }
    } catch (e) {
      openSnackbar(context, e.toString(), Color.fromARGB(255, 240, 16, 0));
    }
  }

  //Get Payment Details Using Coupen Code --> Show Payment and all other details to ADMIN
  getPaymentDetailsForAdmin({
    required BuildContext context,
    required String cuponCode,
  }) async {
    try {
      //crete future function because we don't have data in intially state
      // Future<List<PaymentHistory>> getPostApi() async {s
      //here we pass url where we fetch the data
      final response = await http
          .get(Uri.parse('$uri/Degree/PaymentDetailsForAdmin/${cuponCode}'));

      // //decode the json response
      // var data = jsonDecode(response.body);

      //code 200 means -- data fetch is done
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        List<DegreePaymentDetails> paymentDetails =
            List<DegreePaymentDetails>.from(
                data.map((i) => DegreePaymentDetails.fromJson(i)));
        return paymentDetails;
      } else {
        return [];
      }
    } catch (e) {
      openSnackbar(context, e.toString(), Color.fromARGB(255, 240, 16, 0));
    }
  }

  //Update Payment Status Using Coupn Code
  //Enable attendace --> ON/OFF attendace
  void UpdatePaymentStatus({
    required BuildContext context,
    required String cuponCode,
    required String paymentStatus,
  }) async {
    try {
      //Call API
      http.Response res = await http.patch(
        Uri.parse('$uri/Degree/EditPaymentStatus/${cuponCode}'),
        body: jsonEncode({
          'paymentStatus': paymentStatus,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=utf-8',
        },
      );

      hhtpErrorHanle(
        response: res,
        context: context,
        onSuccess: () {
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

          nextScreen(context, FirstPage());
          // openSnackbar(context, 'Updated', Color.fromARGB(255, 100, 212, 103));
        },
      );

      print(res.body);
    } catch (e) {
      //show pop-up box
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: "Payment Failed",
        text: "Try Again!",
        confirmBtnText: "Thanks!",
        confirmBtnColor: Color.fromARGB(255, 255, 38, 5),
        width: 25,
      );
      // openSnackbar(context, e.toString(), Color.fromARGB(255, 241, 79, 67));
    }
  }

  //*************************************************************************************************/
  //For Diploma
  void addINTODiplomaPayment(
      {required BuildContext context,
      required String userId,
      required String cuponCode,
      required String paymentStatus,
      required String amount,
      required String timeDate,
      required String GameProjectExpo,
      required String GamePosterTalk,
      required String GameTechnoSketch,
      required String GameSharkTank,
      required String GameGullyCricket,
      required String GameVadicMaths,
      required String GameOneMinuteGame,
      required String GameTechOModel,
      required String GameMultimediaPrse,
      required String playername,
      required String playeremail,
      required String playercollgename,
      required String playerenrollmentNo,
      required String playerContactNo}) async {
    try {
      // Convert request data to JSON string
      final data = {
        "userId": userId,
        "cuponCode": cuponCode,
        "paymentStatus": paymentStatus,
        "amount": amount,
        "timeDate": timeDate,
        "GameProjectExpo": GameProjectExpo,
        "GamePosterTalk": GamePosterTalk,
        "GameTechnoSketch": GameTechnoSketch,
        "GameSharkTank": GameSharkTank,
        "GameGullyCricket": GameGullyCricket,
        "GameVadicMaths": GameVadicMaths,
        "GameOneMinuteGame": GameOneMinuteGame,
        "GameTechOModel": GameTechOModel,
        "GameMultimediaPrse": GameMultimediaPrse,
        "playername": playername,
        "playeremail": playeremail,
        "playercollgename": playercollgename,
        "playerenrollmentNo": playerenrollmentNo,
        "playerContectNo": playerContactNo,
      };
      final body = jsonEncode(data);

      //call API
      http.Response res = await http.post(
        Uri.parse('$uri/Diploma/payments/add'),
        body: utf8.encode(body),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=utf-8',
        },
      );

      hhtpErrorHanle(
        response: res,
        context: context,
        onSuccess: () {},
      );

      print(res.body);
    } catch (e) {
      openSnackbar(context, e.toString(), Color.fromARGB(255, 240, 16, 0));
    }
  }

  //Get Payment Details Using Coupen Code --> Show Payment and all other details to ADMIN
  getPaymentDetailsForAdminDiploma({
    required BuildContext context,
    required String cuponCode,
  }) async {
    try {
      //crete future function because we don't have data in intially state
      // Future<List<PaymentHistory>> getPostApi() async {s
      //here we pass url where we fetch the data
      final response = await http
          .get(Uri.parse('$uri/Diploma/PaymentDetailsForAdmin/${cuponCode}'));

      //code 200 means -- data fetch is done
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        List<DiplomaPaymentDetails> paymentDetails =
            List<DiplomaPaymentDetails>.from(
                data.map((i) => DiplomaPaymentDetails.fromJson(i)));
        return paymentDetails;
      } else {
        return [];
      }
    } catch (e) {
      openSnackbar(context, e.toString(), Color.fromARGB(255, 240, 16, 0));
    }
  }

  //get payment History --> in payment History page
  //here userId is current user login id
  List<PaymentHistory> paymenthistoryListDiploma = [];
  getPaymentHistoryDiploma({
    required BuildContext context,
    required String userId,
  }) async {
    try {
      //crete future function because we don't have data in intially state
      // Future<List<PaymentHistory>> getPostApi() async {s
      //here we pass url where we fetch the data
      final response =
          await http.get(Uri.parse('$uri/Diploma/payments/${userId}'));

      //decode the json response
      var data = jsonDecode(response.body.toString());

      //code 200 means -- data fetch is done
      if (response.statusCode == 200) {
        for (Map i in data) {
          paymenthistoryListDiploma.add(PaymentHistory.fromJson(i));
        }
        return paymenthistoryListDiploma;
      } else {
        return paymenthistoryListDiploma;
      }
    } catch (e) {
      openSnackbar(context, e.toString(), Color.fromARGB(255, 240, 16, 0));
    }
  }

  //Update Payment Status Using Coupn Code
  void UpdatePaymentStatusDiploma({
    required BuildContext context,
    required String cuponCode,
    required String paymentStatus,
  }) async {
    try {
      //Call API
      http.Response res = await http.patch(
        Uri.parse('$uri/Diploma/EditPaymentStatus/${cuponCode}'),
        body: jsonEncode({
          'paymentStatus': paymentStatus,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=utf-8',
        },
      );

      hhtpErrorHanle(
        response: res,
        context: context,
        onSuccess: () {
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

          nextScreen(context, FirstPage());
          // openSnackbar(context, 'Updated', Color.fromARGB(255, 100, 212, 103));
        },
      );

      print(res.body);
    } catch (e) {
      //show pop-up box
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: "Payment Failed",
        text: "Try Again!",
        confirmBtnText: "Thanks!",
        confirmBtnColor: Color.fromARGB(255, 255, 38, 5),
        width: 25,
      );
      // openSnackbar(context, e.toString(), Color.fromARGB(255, 241, 79, 67));
    }
  }

  //*************************************************************************************************/
  //For Degree
  //Talaash
  void talaashUser({
    required BuildContext context,
    required String cuponCode,
    required String paymentStatus,
    required String timeDate,
    required String talaashUser1name,
    required String talaashUser1email,
    required String talaashUser1collegename,
    required String talaashUser1enrollmentno,
    required String talaashUser1sem,
    required String talaashUser1Branch,
    required String talaashUser1contactNo,
    required String talaashUser2name,
    required String talaashUser2email,
    required String talaashUser2collegename,
    required String talaashUser2enrollmentno,
    required String talaashUser2sem,
    required String talaashUser2Branch,
    required String talaashUser2contactNo,
  }) async {
    try {
      // Convert request data to JSON string
      final data = {
        "cuponCode": cuponCode,
        "paymentStatus": paymentStatus,
        "timeDate": timeDate,
        "leadername": talaashUser1name,
        "leaderemail": talaashUser1email,
        "leadercollgename": talaashUser1collegename,
        "leaderenrollmentNo": talaashUser1enrollmentno,
        "leaderSem": talaashUser1sem,
        "leaderBranch": talaashUser1Branch,
        "leaderContactNo": talaashUser1contactNo,
        "player2name": talaashUser2name,
        "player2email": talaashUser2email,
        "player2collgename": talaashUser2collegename,
        "player2enrollmentNo": talaashUser2enrollmentno,
        "player2Sem": talaashUser2sem,
        "player2Branch": talaashUser2Branch,
        "player2ContactNo": talaashUser2contactNo,
      };
      final body = jsonEncode(data);

      //call API
      http.Response res = await http.post(
        Uri.parse('$uri/api/Degree/Games/Talaash'),
        body: utf8.encode(body),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=utf-8',
        },
      );

      hhtpErrorHanle(
        response: res,
        context: context,
        onSuccess: () {},
      );

      print(res.body);
    } catch (e) {
      openSnackbar(context, e.toString(), Color.fromARGB(255, 240, 16, 0));
    }
  }

  //TechTainment
  void techTainmentUser({
    required BuildContext context,
    required String cuponCode,
    required String paymentStatus,
    required String timeDate,
    required String techTainmentUser1name,
    required String techTainmentUser1email,
    required String techTainmentUser1collegename,
    required String techTainmentUser1enrollmentno,
    required String techTainmentUser1sem,
    required String techTainmentUser1Branch,
    required String techTainmentUser1contactNo,
    required String techTainmentUser2name,
    required String techTainmentUser2email,
    required String techTainmentUser2collegename,
    required String techTainmentUser2enrollmentno,
    required String techTainmentUser2sem,
    required String techTainmentUser2Branch,
    required String techTainmentUser2contactNo,
    required String techTainmentUser3name,
    required String techTainmentUser3email,
    required String techTainmentUser3collegename,
    required String techTainmentUser3enrollmentno,
    required String techTainmentUser3sem,
    required String techTainmentUser3Branch,
    required String techTainmentUser3contactNo,
  }) async {
    try {
      // Convert request data to JSON string
      final data = {
        "cuponCode": cuponCode,
        "paymentStatus": paymentStatus,
        "timeDate": timeDate,
        "leadername": techTainmentUser1name,
        "leaderemail": techTainmentUser1email,
        "leadercollgename": techTainmentUser1collegename,
        "leaderenrollmentNo": techTainmentUser1enrollmentno,
        "leaderSem": techTainmentUser1sem,
        "leaderBranch": techTainmentUser1Branch,
        "leaderContactNo": techTainmentUser1contactNo,
        "player2name": techTainmentUser2name,
        "player2email": techTainmentUser2email,
        "player2collgename": techTainmentUser2collegename,
        "player2enrollmentNo": techTainmentUser2enrollmentno,
        "player2Sem": techTainmentUser2sem,
        "player2Branch": techTainmentUser2Branch,
        "player2ContactNo": techTainmentUser2contactNo,
        "player3name": techTainmentUser3name,
        "player3email": techTainmentUser3email,
        "player3collgename": techTainmentUser3collegename,
        "player3enrollmentNo": techTainmentUser3enrollmentno,
        "player3Sem": techTainmentUser3sem,
        "player3Branch": techTainmentUser3Branch,
        "player3ContactNo": techTainmentUser3contactNo,
      };
      final body = jsonEncode(data);

      //call API
      http.Response res = await http.post(
        Uri.parse('$uri/api/Degree/Games/Techtaimnet'),
        body: utf8.encode(body),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=utf-8',
        },
      );

      hhtpErrorHanle(
        response: res,
        context: context,
        onSuccess: () {},
      );

      print(res.body);
    } catch (e) {
      openSnackbar(context, e.toString(), Color.fromARGB(255, 240, 16, 0));
    }
  }

  //TheCivilSafari
  void TheCivilSafari({
    required BuildContext context,
    required String cuponCode,
    required String paymentStatus,
    required String timeDate,
    required String TheCivilSafariUser1name,
    required String TheCivilSafariUser1email,
    required String TheCivilSafariUser1collegename,
    required String TheCivilSafariUser1enrollmentno,
    required String TheCivilSafariUser1sem,
    required String TheCivilSafariUser1Branch,
    required String TheCivilSafariUser1contactNo,
    required String TheCivilSafariUser2name,
    required String TheCivilSafariUser2email,
    required String TheCivilSafariUser2collegename,
    required String TheCivilSafariUser2enrollmentno,
    required String TheCivilSafariUser2sem,
    required String TheCivilSafariUser2Branch,
    required String TheCivilSafariUser2contactNo,
    required String TheCivilSafariUser3name,
    required String TheCivilSafariUser3email,
    required String TheCivilSafariUser3collegename,
    required String TheCivilSafariUser3enrollmentno,
    required String TheCivilSafariUser3sem,
    required String TheCivilSafariUser3Branch,
    required String TheCivilSafariUser3contactNo,
  }) async {
    try {
      // Convert request data to JSON string
      final data = {
        "cuponCode": cuponCode,
        "paymentStatus": paymentStatus,
        "timeDate": timeDate,
        "leadername": TheCivilSafariUser1name,
        "leaderemail": TheCivilSafariUser1email,
        "leadercollgename": TheCivilSafariUser1collegename,
        "leaderenrollmentNo": TheCivilSafariUser1enrollmentno,
        "leaderSem": TheCivilSafariUser1sem,
        "leaderBranch": TheCivilSafariUser1Branch,
        "leaderContactNo": TheCivilSafariUser1contactNo,
        "player2name": TheCivilSafariUser2name,
        "player2email": TheCivilSafariUser2email,
        "player2collgename": TheCivilSafariUser2collegename,
        "player2enrollmentNo": TheCivilSafariUser2enrollmentno,
        "player2Sem": TheCivilSafariUser2sem,
        "player2Branch": TheCivilSafariUser2Branch,
        "player2ContactNo": TheCivilSafariUser2contactNo,
        "player3name": TheCivilSafariUser3name,
        "player3email": TheCivilSafariUser3email,
        "player3collgename": TheCivilSafariUser3collegename,
        "player3enrollmentNo": TheCivilSafariUser3enrollmentno,
        "player3Sem": TheCivilSafariUser3sem,
        "player3Branch": TheCivilSafariUser3Branch,
        "player3ContactNo": TheCivilSafariUser3contactNo,
      };
      final body = jsonEncode(data);

      //call API
      http.Response res = await http.post(
        Uri.parse('$uri/api/Degree/Games/TheCivilSafari'),
        body: utf8.encode(body),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=utf-8',
        },
      );

      hhtpErrorHanle(
        response: res,
        context: context,
        onSuccess: () {},
      );

      print(res.body);
    } catch (e) {
      openSnackbar(context, e.toString(), Color.fromARGB(255, 240, 16, 0));
    }
  }

  //Dekathon
  void DekathoneUser({
    required BuildContext context,
    required String cuponCode,
    required String paymentStatus,
    required String timeDate,
    required String DekathoneUser1name,
    required String DekathoneUser1email,
    required String Dekathoneser1collegename,
    required String Dekathoneser1enrollmentno,
    required String Dekathoneser1sem,
    required String Dekathoneser1Branch,
    required String Dekathoneser1contactNo,
    required String Dekathoneser2name,
    required String Dekathoneser2email,
    required String Dekathoneser2collegename,
    required String Dekathoneser2enrollmentno,
    required String Dekathoneser2sem,
    required String Dekathoneser2Branch,
    required String Dekathoneser2contactNo,
    required String DekathoneUser3name,
    required String DekathoneUser3email,
    required String DekathoneUser3collegename,
    required String DekathoneUser3enrollmentno,
    required String DekathoneUser3sem,
    required String DekathoneUser3Branch,
    required String DekathoneUser3contactNo,
    required String DekathoneUser4name,
    required String DekathoneUser4email,
    required String DekathoneUser4collegename,
    required String DekathoneUser4enrollmentno,
    required String DekathoneUser4sem,
    required String DekathoneUser4Branch,
    required String DekathoneUser4contactNo,
  }) async {
    try {
      // Convert request data to JSON string
      final data = {
        "cuponCode": cuponCode,
        "paymentStatus": paymentStatus,
        "timeDate": timeDate,
        "leadername": DekathoneUser1name,
        "leaderemail": DekathoneUser1email,
        "leadercollgename": Dekathoneser1collegename,
        "leaderenrollmentNo": Dekathoneser1enrollmentno,
        "leaderSem": Dekathoneser1sem,
        "leaderBranch": Dekathoneser1Branch,
        "leaderContactNo": Dekathoneser1contactNo,
        "player2name": Dekathoneser2name,
        "player2email": Dekathoneser2email,
        "player2collgename": Dekathoneser2collegename,
        "player2enrollmentNo": Dekathoneser2enrollmentno,
        "player2Sem": Dekathoneser2sem,
        "player2Branch": Dekathoneser2Branch,
        "player2ContactNo": Dekathoneser2contactNo,
        "player3name": DekathoneUser3name,
        "player3email": DekathoneUser3email,
        "player3collgename": DekathoneUser3collegename,
        "player3enrollmentNo": DekathoneUser3enrollmentno,
        "player3Sem": DekathoneUser3sem,
        "player3Branch": DekathoneUser3Branch,
        "player3ContactNo": DekathoneUser3contactNo,
        "player4name": DekathoneUser4name,
        "player4email": DekathoneUser4email,
        "player4collgename": DekathoneUser4collegename,
        "player4enrollmentNo": DekathoneUser4enrollmentno,
        "player4Sem": DekathoneUser4sem,
        "player4Branch": DekathoneUser4Branch,
        "player4ContactNo": DekathoneUser4contactNo,
      };
      final body = jsonEncode(data);

      //call API
      http.Response res = await http.post(
        Uri.parse('$uri/api/Degree/Games/Dekathon'),
        body: utf8.encode(body),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=utf-8',
        },
      );

      hhtpErrorHanle(
        response: res,
        context: context,
        onSuccess: () {},
      );

      print(res.body);
    } catch (e) {
      openSnackbar(context, e.toString(), Color.fromARGB(255, 240, 16, 0));
    }
  }

  //OfficeTennis
  void OfficeTennis({
    required BuildContext context,
    required String cuponCode,
    required String paymentStatus,
    required String timeDate,
    required String OfficeTennisUser1name,
    required String OfficeTennisUser1email,
    required String OfficeTennisUser1collegename,
    required String OfficeTennisUser1enrollmentno,
    required String OfficeTennisUser1sem,
    required String OfficeTennisUser1Branch,
    required String OfficeTennisUser1contactNo,
    required String OfficeTennisUser2name,
    required String OfficeTennisUser2email,
    required String OfficeTennisUser2collegename,
    required String OfficeTennisUser2enrollmentno,
    required String OfficeTennisUser2sem,
    required String OfficeTennisUser2Branch,
    required String OfficeTennisUser2contactNo,
  }) async {
    try {
      // Convert request data to JSON string
      final data = {
        "cuponCode": cuponCode,
        "paymentStatus": paymentStatus,
        "timeDate": timeDate,
        "leadername": OfficeTennisUser1name,
        "leaderemail": OfficeTennisUser1email,
        "leadercollgename": OfficeTennisUser1collegename,
        "leaderenrollmentNo": OfficeTennisUser1enrollmentno,
        "leaderSem": OfficeTennisUser1sem,
        "leaderBranch": OfficeTennisUser1Branch,
        "leaderContactNo": OfficeTennisUser1contactNo,
        "player2name": OfficeTennisUser2name,
        "player2email": OfficeTennisUser2email,
        "player2collgename": OfficeTennisUser2collegename,
        "player2enrollmentNo": OfficeTennisUser2enrollmentno,
        "player2Sem": OfficeTennisUser2sem,
        "player2Branch": OfficeTennisUser2Branch,
        "player2ContactNo": OfficeTennisUser2contactNo,
      };
      final body = jsonEncode(data);

      //call API
      http.Response res = await http.post(
        Uri.parse('$uri/api/Degree/Games/OfficeTenis'),
        body: utf8.encode(body),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=utf-8',
        },
      );

      hhtpErrorHanle(
        response: res,
        context: context,
        onSuccess: () {},
      );

      print(res.body);
    } catch (e) {
      openSnackbar(context, e.toString(), Color.fromARGB(255, 240, 16, 0));
    }
  }

  //MechanicalDroids
  void ScavengerHunt({
    required BuildContext context,
    required String cuponCode,
    required String paymentStatus,
    required String timeDate,
    required String ScavengerHuntUser1name,
    required String ScavengerHuntUser1email,
    required String ScavengerHuntUser1collegename,
    required String ScavengerHuntUser1enrollmentno,
    required String ScavengerHuntUser1sem,
    required String ScavengerHuntUser1Branch,
    required String ScavengerHuntUser1contactNo,
    required String ScavengerHuntUser2name,
    required String ScavengerHuntUser2email,
    required String ScavengerHuntUser2collegename,
    required String ScavengerHuntUser2enrollmentno,
    required String ScavengerHuntUser2sem,
    required String ScavengerHuntUser2Branch,
    required String ScavengerHuntUser2contactNo,
    required String ScavengerHuntUser3name,
    required String ScavengerHuntUser3email,
    required String ScavengerHuntUser3collegename,
    required String ScavengerHuntUser3enrollmentno,
    required String ScavengerHuntUser3sem,
    required String ScavengerHuntUser3Branch,
    required String ScavengerHuntUser3contactNo,
  }) async {
    try {
      // Convert request data to JSON string
      final data = {
        "cuponCode": cuponCode,
        "paymentStatus": paymentStatus,
        "timeDate": timeDate,
        "leadername": ScavengerHuntUser1name,
        "leaderemail": ScavengerHuntUser1email,
        "leadercollgename": ScavengerHuntUser1collegename,
        "leaderenrollmentNo": ScavengerHuntUser1enrollmentno,
        "leaderSem": ScavengerHuntUser1sem,
        "leaderBranch": ScavengerHuntUser1Branch,
        "leaderContactNo": ScavengerHuntUser1contactNo,
        "player2name": ScavengerHuntUser2name,
        "player2email": ScavengerHuntUser2email,
        "player2collgename": ScavengerHuntUser2collegename,
        "player2enrollmentNo": ScavengerHuntUser2enrollmentno,
        "player2Sem": ScavengerHuntUser2sem,
        "player2Branch": ScavengerHuntUser2Branch,
        "player2ContactNo": ScavengerHuntUser2contactNo,
        "player3name": ScavengerHuntUser3name,
        "player3email": ScavengerHuntUser3email,
        "player3collgename": ScavengerHuntUser3collegename,
        "player3enrollmentNo": ScavengerHuntUser3enrollmentno,
        "player3Sem": ScavengerHuntUser3sem,
        "player3Branch": ScavengerHuntUser3Branch,
        "player3ContactNo": ScavengerHuntUser3contactNo,
      };
      final body = jsonEncode(data);

      //call API
      http.Response res = await http.post(
        Uri.parse('$uri/api/Degree/Games/ScavengerHunt'),
        body: utf8.encode(body),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=utf-8',
        },
      );

      hhtpErrorHanle(
        response: res,
        context: context,
        onSuccess: () {},
      );

      print(res.body);
    } catch (e) {
      openSnackbar(context, e.toString(), Color.fromARGB(255, 240, 16, 0));
    }
  }

  //*************************************************************************************************/
  //For Diploma

  //GullyCricket
  void GullyCricket({
    required BuildContext context,
    required String cuponCode,
    required String paymentStatus,
    required String timeDate,
    required String GullyCricketUser1name,
    required String GullyCricketUser1email,
    required String GullyCricketUser1collegename,
    required String GullyCricketUser1enrollmentno,
    required String GullyCricketUser1sem,
    required String GullyCricketUser1Branch,
    required String GullyCricketUser1contactNo,
  }) async {
    try {
      // Convert request data to JSON string
      final data = {
        "cuponCode": cuponCode,
        "paymentStatus": paymentStatus,
        "timeDate": timeDate,
        "leadername": GullyCricketUser1name,
        "leaderemail": GullyCricketUser1email,
        "leadercollgename": GullyCricketUser1collegename,
        "leaderenrollmentNo": GullyCricketUser1enrollmentno,
        "leaderSem": GullyCricketUser1sem,
        "leaderBranch": GullyCricketUser1Branch,
        "leaderContactNo": GullyCricketUser1contactNo,
      };
      final body = jsonEncode(data);

      //call API
      http.Response res = await http.post(
        Uri.parse('$uri/api/Diploma/Games/GullyCricket'),
        body: utf8.encode(body),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=utf-8',
        },
      );

      hhtpErrorHanle(
        response: res,
        context: context,
        onSuccess: () {},
      );

      print(res.body);
    } catch (e) {
      openSnackbar(context, e.toString(), Color.fromARGB(255, 240, 16, 0));
    }
  }

  //OneMinuteGame
  void OneMinuteGame({
    required BuildContext context,
    required String cuponCode,
    required String paymentStatus,
    required String timeDate,
    required String OneMinuteGameUser1name,
    required String OneMinuteGameUser1email,
    required String OneMinuteGameUser1collegename,
    required String OneMinuteGameUser1enrollmentno,
    required String OneMinuteGameUser1sem,
    required String OneMinuteGameUser1Branch,
    required String OneMinuteGameUser1contactNo,
  }) async {
    try {
      // Convert request data to JSON string
      final data = {
        "cuponCode": cuponCode,
        "paymentStatus": paymentStatus,
        "timeDate": timeDate,
        "leadername": OneMinuteGameUser1name,
        "leaderemail": OneMinuteGameUser1email,
        "leadercollgename": OneMinuteGameUser1collegename,
        "leaderenrollmentNo": OneMinuteGameUser1enrollmentno,
        "leaderSem": OneMinuteGameUser1sem,
        "leaderBranch": OneMinuteGameUser1Branch,
        "leaderContactNo": OneMinuteGameUser1contactNo,
      };
      final body = jsonEncode(data);

      //call API
      http.Response res = await http.post(
        Uri.parse('$uri/api/Diploma/Games/OneMinuteGame'),
        body: utf8.encode(body),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=utf-8',
        },
      );

      hhtpErrorHanle(
        response: res,
        context: context,
        onSuccess: () {},
      );

      print(res.body);
    } catch (e) {
      openSnackbar(context, e.toString(), Color.fromARGB(255, 240, 16, 0));
    }
  }

  //PosterTalk
  void PosterTalk({
    required BuildContext context,
    required String cuponCode,
    required String paymentStatus,
    required String timeDate,
    required String PosterTalkUser1name,
    required String PosterTalkUser1email,
    required String PosterTalkUser1collegename,
    required String PosterTalkUser1enrollmentno,
    required String PosterTalkUser1sem,
    required String PosterTalkUser1Branch,
    required String PosterTalkUser1contactNo,
  }) async {
    try {
      // Convert request data to JSON string
      final data = {
        "cuponCode": cuponCode,
        "paymentStatus": paymentStatus,
        "timeDate": timeDate,
        "leadername": PosterTalkUser1name,
        "leaderemail": PosterTalkUser1email,
        "leadercollgename": PosterTalkUser1collegename,
        "leaderenrollmentNo": PosterTalkUser1enrollmentno,
        "leaderSem": PosterTalkUser1sem,
        "leaderBranch": PosterTalkUser1Branch,
        "leaderContactNo": PosterTalkUser1contactNo,
      };
      final body = jsonEncode(data);

      //call API
      http.Response res = await http.post(
        Uri.parse('$uri/api/Diploma/Games/PosterTalk'),
        body: utf8.encode(body),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=utf-8',
        },
      );

      hhtpErrorHanle(
        response: res,
        context: context,
        onSuccess: () {},
      );

      print(res.body);
    } catch (e) {
      openSnackbar(context, e.toString(), Color.fromARGB(255, 240, 16, 0));
    }
  }

  //TechnoSketch
  void TechnoSketch({
    required BuildContext context,
    required String cuponCode,
    required String paymentStatus,
    required String timeDate,
    required String TechnoSketchUser1name,
    required String TechnoSketchUser1email,
    required String TechnoSketchUser1collegename,
    required String TechnoSketchUser1enrollmentno,
    required String TechnoSketchUser1sem,
    required String TechnoSketchUser1Branch,
    required String TechnoSketchUser1contactNo,
  }) async {
    try {
      // Convert request data to JSON string
      final data = {
        "cuponCode": cuponCode,
        "paymentStatus": paymentStatus,
        "timeDate": timeDate,
        "leadername": TechnoSketchUser1name,
        "leaderemail": TechnoSketchUser1email,
        "leadercollgename": TechnoSketchUser1collegename,
        "leaderenrollmentNo": TechnoSketchUser1enrollmentno,
        "leaderSem": TechnoSketchUser1sem,
        "leaderBranch": TechnoSketchUser1Branch,
        "leaderContactNo": TechnoSketchUser1contactNo,
      };
      final body = jsonEncode(data);

      //call API
      http.Response res = await http.post(
        Uri.parse('$uri/api/Diploma/Games/TechnoSketch'),
        body: utf8.encode(body),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=utf-8',
        },
      );

      hhtpErrorHanle(
        response: res,
        context: context,
        onSuccess: () {},
      );

      print(res.body);
    } catch (e) {
      openSnackbar(context, e.toString(), Color.fromARGB(255, 240, 16, 0));
    }
  }

  //VadicMaths
  void VadicMaths({
    required BuildContext context,
    required String cuponCode,
    required String paymentStatus,
    required String timeDate,
    required String VadicMathsUser1name,
    required String VadicMathsUser1email,
    required String VadicMathsUser1collegename,
    required String VadicMathsUser1enrollmentno,
    required String VadicMathsUser1sem,
    required String VadicMathsUser1Branch,
    required String VadicMathsUser1contactNo,
  }) async {
    try {
      // Convert request data to JSON string
      final data = {
        "cuponCode": cuponCode,
        "paymentStatus": paymentStatus,
        "timeDate": timeDate,
        "leadername": VadicMathsUser1name,
        "leaderemail": VadicMathsUser1email,
        "leadercollgename": VadicMathsUser1collegename,
        "leaderenrollmentNo": VadicMathsUser1enrollmentno,
        "leaderSem": VadicMathsUser1sem,
        "leaderBranch": VadicMathsUser1Branch,
        "leaderContactNo": VadicMathsUser1contactNo,
      };
      final body = jsonEncode(data);

      //call API
      http.Response res = await http.post(
        Uri.parse('$uri/api/Diploma/Games/VadicMaths'),
        body: utf8.encode(body),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=utf-8',
        },
      );

      hhtpErrorHanle(
        response: res,
        context: context,
        onSuccess: () {},
      );

      print(res.body);
    } catch (e) {
      openSnackbar(context, e.toString(), Color.fromARGB(255, 240, 16, 0));
    }
  }

  //MultiMediaPrse
  void MultiMediaPrse({
    required BuildContext context,
    required String cuponCode,
    required String paymentStatus,
    required String timeDate,
    required String MultiMediaPrseUser1name,
    required String MultiMediaPrseUser1email,
    required String MultiMediaPrseUser1collegename,
    required String MultiMediaPrseUser1enrollmentno,
    required String MultiMediaPrseUser1sem,
    required String MultiMediaPrseUser1Branch,
    required String MultiMediaPrseUser1contactNo,
    required String MultiMediaPrseUser2name,
    required String MultiMediaPrseUser2email,
    required String MultiMediaPrseUser2collegename,
    required String MultiMediaPrseUser2enrollmentno,
    required String MultiMediaPrseUser2sem,
    required String MultiMediaPrseUser2Branch,
    required String MultiMediaPrseUser2contactNo,
  }) async {
    try {
      // Convert request data to JSON string
      final data = {
        "cuponCode": cuponCode,
        "paymentStatus": paymentStatus,
        "timeDate": timeDate,
        "leadername": MultiMediaPrseUser1name,
        "leaderemail": MultiMediaPrseUser1email,
        "leadercollgename": MultiMediaPrseUser1collegename,
        "leaderenrollmentNo": MultiMediaPrseUser1enrollmentno,
        "leaderSem": MultiMediaPrseUser1sem,
        "leaderBranch": MultiMediaPrseUser1Branch,
        "leaderContactNo": MultiMediaPrseUser1contactNo,
        "player2name": MultiMediaPrseUser2name,
        "player2email": MultiMediaPrseUser2email,
        "player2collgename": MultiMediaPrseUser2collegename,
        "player2enrollmentNo": MultiMediaPrseUser2enrollmentno,
        "player2Sem": MultiMediaPrseUser2sem,
        "player2Branch": MultiMediaPrseUser2Branch,
        "player2ContactNo": MultiMediaPrseUser2contactNo,
      };
      final body = jsonEncode(data);

      //call API
      http.Response res = await http.post(
        Uri.parse('$uri/api/Diploma/Games/MultiMediaPrse'),
        body: utf8.encode(body),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=utf-8',
        },
      );

      hhtpErrorHanle(
        response: res,
        context: context,
        onSuccess: () {},
      );

      print(res.body);
    } catch (e) {
      openSnackbar(context, e.toString(), Color.fromARGB(255, 240, 16, 0));
    }
  }

  //SharkTank
  void SharkTank({
    required BuildContext context,
    required String cuponCode,
    required String paymentStatus,
    required String timeDate,
    required String SharkTankUser1name,
    required String SharkTankUser1email,
    required String SharkTankUser1collegename,
    required String SharkTankUser1enrollmentno,
    required String SharkTankUser1sem,
    required String SharkTankUser1Branch,
    required String SharkTankUser1contactNo,
    required String SharkTankUser2name,
    required String SharkTankUser2email,
    required String SharkTankUser2collegename,
    required String SharkTankUser2enrollmentno,
    required String SharkTankUser2sem,
    required String SharkTankUser2Branch,
    required String SharkTankUser2contactNo,
  }) async {
    try {
      // Convert request data to JSON string
      final data = {
        "cuponCode": cuponCode,
        "paymentStatus": paymentStatus,
        "timeDate": timeDate,
        "leadername": SharkTankUser1name,
        "leaderemail": SharkTankUser1email,
        "leadercollgename": SharkTankUser1collegename,
        "leaderenrollmentNo": SharkTankUser1enrollmentno,
        "leaderSem": SharkTankUser1sem,
        "leaderBranch": SharkTankUser1Branch,
        "leaderContactNo": SharkTankUser1contactNo,
        "player2name": SharkTankUser2name,
        "player2email": SharkTankUser2email,
        "player2collgename": SharkTankUser2collegename,
        "player2enrollmentNo": SharkTankUser2enrollmentno,
        "player2Sem": SharkTankUser2sem,
        "player2Branch": SharkTankUser2Branch,
        "player2ContactNo": SharkTankUser2contactNo,
      };
      final body = jsonEncode(data);

      //call API
      http.Response res = await http.post(
        Uri.parse('$uri/api/Diploma/Games/SharkTank'),
        body: utf8.encode(body),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=utf-8',
        },
      );

      hhtpErrorHanle(
        response: res,
        context: context,
        onSuccess: () {},
      );

      print(res.body);
    } catch (e) {
      openSnackbar(context, e.toString(), Color.fromARGB(255, 240, 16, 0));
    }
  }

  //TechOModel
  void TechOModel({
    required BuildContext context,
    required String cuponCode,
    required String paymentStatus,
    required String timeDate,
    required String TechOModelUser1name,
    required String TechOModelUser1email,
    required String TechOModelUser1collegename,
    required String TechOModelUser1enrollmentno,
    required String TechOModelUser1sem,
    required String TechOModelUser1Branch,
    required String TechOModelUser1contactNo,
    required String TechOModelUser2name,
    required String TechOModelUser2email,
    required String TechOModelUser2collegename,
    required String TechOModelUser2enrollmentno,
    required String TechOModelUser2sem,
    required String TechOModelUser2Branch,
    required String TechOModelUser2contactNo,
  }) async {
    try {
      // Convert request data to JSON string
      final data = {
        "cuponCode": cuponCode,
        "paymentStatus": paymentStatus,
        "timeDate": timeDate,
        "leadername": TechOModelUser1name,
        "leaderemail": TechOModelUser1email,
        "leadercollgename": TechOModelUser1collegename,
        "leaderenrollmentNo": TechOModelUser1enrollmentno,
        "leaderSem": TechOModelUser1sem,
        "leaderBranch": TechOModelUser1Branch,
        "leaderContactNo": TechOModelUser1contactNo,
        "player2name": TechOModelUser2name,
        "player2email": TechOModelUser2email,
        "player2collgename": TechOModelUser2collegename,
        "player2enrollmentNo": TechOModelUser2enrollmentno,
        "player2Sem": TechOModelUser2sem,
        "player2Branch": TechOModelUser2Branch,
        "player2ContactNo": TechOModelUser2contactNo,
      };
      final body = jsonEncode(data);

      //call API
      http.Response res = await http.post(
        Uri.parse('$uri/api/Diploma/Games/TechOModel'),
        body: utf8.encode(body),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=utf-8',
        },
      );

      hhtpErrorHanle(
        response: res,
        context: context,
        onSuccess: () {},
      );

      print(res.body);
    } catch (e) {
      openSnackbar(context, e.toString(), Color.fromARGB(255, 240, 16, 0));
    }
  }

  //ProjecExpo
  void ProjecExpo({
    required BuildContext context,
    required String cuponCode,
    required String paymentStatus,
    required String timeDate,
    required String ProjecExpoUser1name,
    required String ProjecExpoUser1email,
    required String ProjecExpoUser1collegename,
    required String ProjecExpoUser1enrollmentno,
    required String ProjecExpoUser1sem,
    required String ProjecExpoUser1Branch,
    required String ProjecExpoUser1contactNo,
    required String ProjecExpoUser2name,
    required String ProjecExpoUser2email,
    required String ProjecExpoUser2collegename,
    required String ProjecExpoUser2enrollmentno,
    required String ProjecExpoUser2sem,
    required String ProjecExpoUser2Branch,
    required String ProjecExpoUser2contactNo,
    required String ProjecExpoUser3name,
    required String ProjecExpoUser3email,
    required String ProjecExpoUser3collegename,
    required String ProjecExpoUser3enrollmentno,
    required String ProjecExpoUser3sem,
    required String ProjecExpoUser3Branch,
    required String ProjecExpoUser3contactNo,
    required String ProjecExpoUser4name,
    required String ProjecExpoUser4email,
    required String ProjecExpoUser4collegename,
    required String ProjecExpoUser4enrollmentno,
    required String ProjecExpoUser4sem,
    required String ProjecExpoUser4Branch,
    required String ProjecExpoUser4contactNo,
  }) async {
    try {
      // Convert request data to JSON string
      final data = {
        "cuponCode": cuponCode,
        "paymentStatus": paymentStatus,
        "timeDate": timeDate,
        "leadername": ProjecExpoUser1name,
        "leaderemail": ProjecExpoUser1email,
        "leadercollgename": ProjecExpoUser1collegename,
        "leaderenrollmentNo": ProjecExpoUser1enrollmentno,
        "leaderSem": ProjecExpoUser1sem,
        "leaderBranch": ProjecExpoUser1Branch,
        "leaderContactNo": ProjecExpoUser1contactNo,
        "player2name": ProjecExpoUser2name,
        "player2email": ProjecExpoUser2email,
        "player2collgename": ProjecExpoUser2collegename,
        "player2enrollmentNo": ProjecExpoUser2enrollmentno,
        "player2Sem": ProjecExpoUser2sem,
        "player2Branch": ProjecExpoUser2Branch,
        "player2ContactNo": ProjecExpoUser2contactNo,
        "player3name": ProjecExpoUser3name,
        "player3email": ProjecExpoUser3email,
        "player3collgename": ProjecExpoUser3collegename,
        "player3enrollmentNo": ProjecExpoUser3enrollmentno,
        "player3Sem": ProjecExpoUser3sem,
        "player3Branch": ProjecExpoUser3Branch,
        "player3ContactNo": ProjecExpoUser3contactNo,
        "player4name": ProjecExpoUser4name,
        "player4email": ProjecExpoUser4email,
        "player4collgename": ProjecExpoUser4collegename,
        "player4enrollmentNo": ProjecExpoUser4enrollmentno,
        "player4Sem": ProjecExpoUser4sem,
        "player4Branch": ProjecExpoUser4Branch,
        "player4ContactNo": ProjecExpoUser4contactNo,
      };
      final body = jsonEncode(data);

      //call API
      http.Response res = await http.post(
        Uri.parse('$uri/api/Diploma/Games/ProjecExpo'),
        body: utf8.encode(body),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=utf-8',
        },
      );

      hhtpErrorHanle(
        response: res,
        context: context,
        onSuccess: () {},
      );

      print(res.body);
    } catch (e) {
      openSnackbar(context, e.toString(), Color.fromARGB(255, 240, 16, 0));
    }
  }
}
