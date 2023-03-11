import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Database/user.dart';

//store user data --> Login time
class UserProvider extends ChangeNotifier {
  User _user = User(
    uid: '',
    name: '',
    email: '',
    phoneno: '',
    diplomaORdegree: '',
    collagename: '',
    branch: '',
    sem: '',
    EnNO: '',
    password: '',
    token: '',
  );

  User get user => _user;

  void setUser(String user) async {
    _user = User.fromJson(user);

    // save user data to SharedPreferences
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('user', user);
    notifyListeners();
  }

  //after login one time save data here
  Future<void> getUserFromPrefs() async {
    // Retrieve the user data from SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? user = prefs.getString('user');
    if (user != null) {
      _user = User.fromJson(user);
      notifyListeners();
    }
  }

  //for user Logged out
  void clearUser() async {
    _user = User(
      uid: '',
      name: '',
      email: '',
      phoneno: '',
      diplomaORdegree: '',
      collagename: '',
      branch: '',
      sem: '',
      EnNO: '',
      password: '',
      token: '',
    );

    // clear user data from SharedPreferences
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove('user');
    notifyListeners();
  }
}
