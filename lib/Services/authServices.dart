//Using MongoDb Api
//all authnticate user in this file
// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vegy2023/models/paymentHistoryModel.dart';

import '../Database/error_handling.dart';
import '../Database/user.dart';
import 'package:http/http.dart' as http;

import '../Provider/userprovider.dart';
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
          nextScreen(context, BottonNevBar());

          openSnackbar(
              context, 'Account Created!', Color.fromARGB(255, 100, 212, 103));
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

          // nextScreen(context, BottonNevBar());
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
  //This all for showing payment history

  //add payment in class
  void addINTODegreePayment(
      {required BuildContext context,
      required String userId,
      required String paymentId,
      required String amount,
      required String timeDate,
      required String GameTalaash,
      required String GameTechTainment,
      required String GameTheCivilSafari,
      required String GameDekathon,
      required String GameOfficeTennis,
      required String playername,
      required String playeremail,
      required String playercollgename,
      required String playerenrollmentNo,
      required String playerContactNo}) async {
    try {
      // Convert request data to JSON string
      final data = {
        "userId": userId,
        "paymentId": paymentId,
        "amount": amount,
        "timeDate": timeDate,
        "GameTalaash": GameTalaash,
        "GameTechTainment": GameTechTainment,
        "GameTheCivilSafari": GameTheCivilSafari,
        "GameDekathon": GameDekathon,
        "GameOfficeTennis": GameOfficeTennis,
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
      // }

      // //call API
      // http.Response res = await http.post(
      //   Uri.parse('$uri/payments/${userId}'),
      //   headers: <String, String>{
      //     'Content-Type': 'application/json; charset=utf-8',
      //   },
      // );

      // hhtpErrorHanle(
      //   response: res,
      //   context: context,
      //   onSuccess: () {},
      // );

    } catch (e) {
      openSnackbar(context, e.toString(), Color.fromARGB(255, 240, 16, 0));
    }
  }

  //*************************************************************************************************/
  //THIS ALL FOR GAME'S-- when user make succesfull payments

  //Talaash
  void talaashUser({
    required BuildContext context,
    required String transactionid,
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
        "transactionid": transactionid,
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
    required String transactionid,
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
        "transactionid": transactionid,
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
    required String transactionid,
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
        "transactionid": transactionid,
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
    required String transactionid,
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
        "transactionid": transactionid,
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
    required String transactionid,
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
        "transactionid": transactionid,
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
}
