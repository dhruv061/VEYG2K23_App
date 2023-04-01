import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:vegy2023/Services/authServices.dart';
import 'package:vegy2023/pages/Nextscreen.dart';
import 'package:vegy2023/pages/SignUpPage.dart';

import '../Provider/InternetProvider.dart';
import '../Provider/userprovider.dart';
import 'SnackBar.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  //for loading indicator
  bool isLoading = false;

  @override
  void initState() {
    authService.getUserData(context);
    super.initState();
  }

  //THIS ALL FOR LOGIN PAGE
  //for check validation
  final formKey = GlobalKey<FormState>();

  //Text Editing Controller
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  //DropDoen OPtion --> Degree/Diploma
  String? degreeORdiplomaController;
  List<String> items = [
    'Degree',
    'Diploma',
  ];

  //validate user email
  String _errorMessage = '';

  //for mongodb
  final AuthService authService = AuthService();
  void signInUser() async {
    final ip = context.read<InternetProvider>();
    await ip.checkInternetConnection();

    //for checking Internet
    if (ip.hasInternet == false) {
      openSnackbar(context, "Check your internet connection", Colors.red);
    } else {
      //call backend file
      authService.signInUser(
        context: context,
        email: emailController.text,
        password: passwordController.text,
        diplomaORdegree: degreeORdiplomaController!,
      );
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //height and width
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Provider.of<UserProvider>(context).user.token.isNotEmpty
        ? const SafeArea(
            child: Center(
              child: Text("Profile Page"),
            ),
          )
        : SafeArea(
            child: Scaffold(
              backgroundColor: HexColor("#ECECEC"),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    //Logo
                    Padding(
                      padding: const EdgeInsets.only(top: 90),
                      child: Container(
                        height: height / 8,
                        width: width / 2.8,
                        decoration: BoxDecoration(
                          // color: Colors.white,
                          image: const DecorationImage(
                            image: AssetImage("assets/icons/logo2.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Container(),
                      ),
                    ),

                    //for Sign-in heading
                    Padding(
                      padding: const EdgeInsets.only(left: 27),
                      child: Container(
                        margin: const EdgeInsets.only(top: 60),
                        height: 47,
                        width: 500,
                        // color: Colors.yellow,
                        alignment: const FractionalOffset(0.0002, 0.6),
                        child: const Text(
                          "Sign-in",
                          style: TextStyle(
                            fontFamily: 'OpenSanse',
                            fontWeight: FontWeight.w700,
                            fontSize: 35,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),

                    //for SubHeading
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Container(
                        margin: const EdgeInsets.only(right: 50),
                        height: 42,
                        width: 800,
                        // color: Colors.yellow,
                        alignment: const FractionalOffset(0.1, 0.6),
                        child: const Text(
                          "Let's Play a game",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: 'OpenSanse',
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),

                    //form
                    Form(
                      key: formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(18),
                        child: Column(
                          children: [
                            //Email
                            TextFormField(
                              controller: emailController,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                prefixIcon: Icon(
                                  LineIcons.mailBulk,
                                  color: HexColor("#11145A"),
                                ),
                                hintText: "E-mail",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(2)),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: HexColor("#11145A")),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),

                              //for validation
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter password";
                                }
                              },
                            ),

                            const SizedBox(height: 10),

                            //password
                            TextFormField(
                              controller: passwordController,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                prefixIcon: Icon(
                                  LineIcons.passport,
                                  color: HexColor("#11145A"),
                                ),
                                hintText: "password",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(2)),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: HexColor("#11145A")),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),

                              //for validation
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter password";
                                } else if (value.length <= 5) {
                                  return "password should be minimum 5 letter long";
                                }
                                return null;
                              },
                            ),

                            const SizedBox(height: 10),

                            //diploma Or Degree
                            Container(
                              height: height / 16,
                              width: width / 1.1,
                              decoration: BoxDecoration(
                                color: HexColor("#FFFFFF"),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15),
                                  bottomLeft: Radius.circular(15),
                                  bottomRight: Radius.circular(15),
                                ),
                              ),
                              child: DropdownButton2(
                                isExpanded: true,

                                //hint text
                                hint: Row(
                                  children: [
                                    Icon(
                                      LineIcons.blackberry,
                                      size: 25,
                                      color: HexColor("#11145A"),
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Expanded(
                                      child: Text(
                                        'Select Item',
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontFamily: 'OpenSanse',
                                          fontWeight: FontWeight.w500,
                                          color: HexColor("#D9D9D9"),
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),

                                //items
                                items: items
                                    .map((item) => DropdownMenuItem<String>(
                                          value: item,
                                          child: Text(
                                            item,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ))
                                    .toList(),

                                //select value
                                value: degreeORdiplomaController,
                                onChanged: (value) {
                                  setState(() {
                                    degreeORdiplomaController = value as String;
                                  });
                                },
                              ),
                            ),

                            const SizedBox(height: 10),

                            //Sing-In Button
                            Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.only(top: 10),
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
                                child: isLoading
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          SizedBox(
                                            height: 27,
                                            width: 27,
                                            child: CircularProgressIndicator(
                                              color: Colors.white,
                                              strokeWidth: 3,
                                            ),
                                          ),
                                          SizedBox(width: 18),
                                          Text(
                                            "Please Wait",
                                            style: TextStyle(
                                              fontFamily: 'OpenSanse',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 20,
                                              color: Colors.white,
                                            ),
                                          )
                                        ],
                                      )
                                    : const Text("Sign in"),
                                onPressed: () {
                                  setState(() {
                                    isLoading = true;
                                  });

                                  //check for drop down box
                                  if (degreeORdiplomaController == null) {
                                    openSnackbar(
                                        context,
                                        'Please fill up all the blocks',
                                        Colors.red);
                                    //end loading
                                    setState(() {
                                      isLoading = false;
                                    });
                                  }

                                  if (formKey.currentState!.validate() &&
                                      degreeORdiplomaController != null) {
                                    Future.delayed(
                                      Duration(seconds: 3),
                                      () {
                                        //for mongoDb
                                        signInUser();
                                      },
                                    );
                                  }
                                },
                              ),
                            ),

                            //signUp option after signin button
                            Padding(
                              padding: const EdgeInsets.only(left: 50),
                              child: Row(
                                children: [
                                  Text(
                                    "Don’t have account? ",
                                    style: TextStyle(
                                      fontFamily: 'OpenSanse',
                                      fontWeight: FontWeight.w300,
                                      fontSize: 14,
                                      color: HexColor("#110E0D"),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      nextScreen(context, const SignUpPage());
                                    },
                                    child: Text(
                                      "Sign up",
                                      style: TextStyle(
                                        fontFamily: 'OpenSanse',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                        color: HexColor("#11145A"),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
