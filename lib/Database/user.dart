import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

//structure of user
class User {
  final String uid;
  final String name;
  final String email;
  final String phoneno;
  final String diplomaORdegree;
  final String collagename;
  final String branch;
  final String sem;
  final String EnNO;
  final String visiblepassword;
  final String password;
  final String token;

  User({
    required this.uid,
    required this.name,
    required this.email,
    required this.phoneno,
    required this.diplomaORdegree,
    required this.collagename,
    required this.branch,
    required this.sem,
    required this.EnNO,
    required this.visiblepassword,
    required this.password,
    required this.token,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'name': name,
      'email': email,
      'phoneno': phoneno,
      'diplomaORdegree': diplomaORdegree,
      'collagename': collagename,
      'branch': branch,
      'sem': sem,
      'EnNO': EnNO,
      'visiblepassword': visiblepassword,
      'password': password,
      'token': token,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      uid: map['_id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      phoneno: map['phoneno'] as String,
      diplomaORdegree: map['diplomaORdegree'] as String,
      collagename: map['collagename'] as String,
      branch: map['branch'] as String,
      sem: map['sem'] as String,
      EnNO: map['EnNO'] as String,
      visiblepassword: map['visiblepassword'] as String,
      password: map['password'] as String,
      token: map['token'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
