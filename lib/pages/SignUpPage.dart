import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:provider/provider.dart';
import 'package:vegy2023/Services/authServices.dart';
import 'package:vegy2023/pages/SnackBar.dart';

import '../Provider/InternetProvider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  //for loading indicator
  bool isLoading = false;

  //for check validation
  final formKey = GlobalKey<FormState>();

  //validate user email
  String _errorMessage = '';

  //Text Editing Controller
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phonenoController = TextEditingController();
  final collgeNameController = TextEditingController();
  final branchController = TextEditingController();
  final semController = TextEditingController();
  final EnNOController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final OTPController = TextEditingController();

  //DropDoen OPtion --> Degree/Diploma
  String? degreeORdiplomaController;
  List<String> items = [
    'Degree',
    'Diploma',
  ];

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phonenoController.dispose();
    collgeNameController.dispose();
    branchController.dispose();
    semController.dispose();
    EnNOController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    OTPController.dispose();
    super.dispose();
  }

  //for mongodb
  final AuthService authService = AuthService();

  //signup method
  void signUpUser() async {
    final ip = context.read<InternetProvider>();
    await ip.checkInternetConnection();

    //for checking Internet
    if (ip.hasInternet == false) {
      openSnackbar(context, "Check your internet connection", Colors.red);
    } else {
      //for check password
      if (passwordController.text == confirmPasswordController.text) {
        //call backend file
        authService.signUpUser(
          context: context,
          name: nameController.text,
          email: emailController.text,
          phoneno: phonenoController.text,
          diplomaORdegree: degreeORdiplomaController!,
          collagename: collgeNameController.text,
          branch: branchController.text,
          sem: semController.text,
          EnNO: EnNOController.text,
          visiblepassword: passwordController.text,
          password: passwordController.text,
        );
      } else {
        openSnackbar(context, "password Not match", Colors.red);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    //height and width
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: HexColor("#ECECEC"),
        //appbar
        appBar: AppBar(
          backgroundColor: HexColor("#ECECEC"),
          elevation: 0,
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

        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                //Logo
                Center(
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

                //for Sign-up heading
                Padding(
                  padding: const EdgeInsets.only(left: 27),
                  child: Container(
                    margin: const EdgeInsets.only(top: 60),
                    height: 47,
                    width: 500,
                    // color: Colors.yellow,
                    alignment: const FractionalOffset(0.0002, 0.6),
                    child: const Text(
                      "Sign-up",
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
                        //Name
                        TextFormField(
                          controller: nameController,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: Icon(
                              LineIcons.user,
                              color: HexColor("#11145A"),
                            ),
                            hintText: "Name",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(2)),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: HexColor("#11145A")),
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
                              return "Please enter name";
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 10),

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
                              borderSide: const BorderSide(color: Colors.white),
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

                        // //send Otp Button
                        // Container(
                        //   height: height / 17,
                        //   width: width / 3,
                        //   // color: Colors.yellow,
                        //   margin: EdgeInsets.only(left: 190),
                        //   child: ElevatedButton(
                        //     style: ElevatedButton.styleFrom(
                        //       backgroundColor: HexColor("#11145A"),
                        //       textStyle: const TextStyle(
                        //         fontFamily: 'OpenSanse',
                        //         fontWeight: FontWeight.w600,
                        //         fontSize: 17,
                        //         color: Colors.white,
                        //       ),
                        //       minimumSize: Size.fromHeight(35),
                        //       shape: RoundedRectangleBorder(
                        //         borderRadius: BorderRadius.circular(13),
                        //       ),
                        //     ),
                        //     child: const Text("Send OTP"),
                        //     onPressed: () {},
                        //   ),
                        // ),

                        // const SizedBox(height: 13),

                        //phone No.
                        TextFormField(
                          controller: phonenoController,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: Icon(
                              LineIcons.phone,
                              color: HexColor("#11145A"),
                            ),
                            hintText: "phone",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(2)),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: HexColor("#11145A")),
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
                              return "Please enter phone No";
                            } else if (value.length != 10) {
                              return "Please enter valid phone No";
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 13),

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

                        //College Name
                        TextFormField(
                          controller: collgeNameController,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: Icon(
                              LineIcons.school,
                              color: HexColor("#11145A"),
                            ),
                            hintText: "collage name",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(2)),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: HexColor("#11145A")),
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
                              return "Please enter college Name";
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 10),

                        //Branch
                        TextFormField(
                          controller: branchController,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: Icon(
                              LineIcons.patreon,
                              color: HexColor("#11145A"),
                            ),
                            hintText: "branch",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(2)),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: HexColor("#11145A")),
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
                              return "Please enterBranch";
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 10),

                        //sem
                        TextFormField(
                          controller: semController,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: Icon(
                              LineIcons.steamSymbol,
                              color: HexColor("#11145A"),
                            ),
                            hintText: "semester",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(2)),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: HexColor("#11145A")),
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
                              return "Please enter semster";
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 10),

                        //Enrollment No
                        TextFormField(
                          controller: EnNOController,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: Icon(
                              LineIcons.calculator,
                              color: HexColor("#11145A"),
                            ),
                            hintText: "enrollment Number",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(2)),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: HexColor("#11145A")),
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
                              return "Please enter enrollment no";
                            }
                            return null;
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
                              borderSide: const BorderSide(color: Colors.white),
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

                        //confirm Password
                        TextFormField(
                          controller: confirmPasswordController,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: Icon(
                              LineIcons.check,
                              color: HexColor("#11145A"),
                            ),
                            hintText: "confirm password",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(2)),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: HexColor("#11145A")),
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
                              return "Please re-enter your password";
                            }
                            return null;
                          },
                        ),

                        //SignUp Button
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
                                : Text("Sign up"),
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
                                    //print data
                                    print("account creation :data\n");
                                    print(nameController.text);
                                    print(emailController.text);
                                    print(phonenoController.text);
                                    print(degreeORdiplomaController!);
                                    print(collgeNameController.text);
                                    print(branchController.text);
                                    print(semController.text);
                                    print(passwordController.text);

                                    //signup
                                    signUpUser();

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
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
