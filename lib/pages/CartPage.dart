// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

import 'package:vegy2023/Provider/particpationData.dart';
import 'package:vegy2023/pages/FirstPage.dart';
import 'package:vegy2023/pages/HomePage.dart';
import 'package:vegy2023/pages/Nextscreen.dart';
import 'package:vegy2023/pages/SnackBar.dart';
import 'package:vegy2023/pages/checkOutpage.dart';

import 'CartModel.dart';

class CartPage extends StatefulWidget {
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    //height and width
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    //foe add students data || check visibilty
    final participateData = ParticipateData();

    //for diffrent game have diffrent textfields so they have diffrent height
    // define a map with the desired heights for each item name
    Map<String, double> itemHeights = {
      'Tech-Tainment': height / 0.37,
      'Talassh': height / 0.54,
      'TheCivilSafari': height / 0.37,
      'Dekathon': height / 0.29,
      'OfficeTennis': height / 0.53,
    };

    //for getting Total Price
    var cart = context.watch<CartModel>();

    return Scaffold(
      backgroundColor: HexColor("#F0F0F2"),
      body: cart.items.length == 0
          ? Column(
              children: [
                //image
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 150),
                    child: Container(
                      height: height / 2,
                      width: width / 1.3,
                      decoration: const BoxDecoration(
                        // color: Colors.yellow,
                        image: DecorationImage(
                          image: AssetImage("assets/images/gamenotadded.gif"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                Text(
                  "You not added any game",
                  style: TextStyle(
                    fontFamily: 'OpenSanse',
                    fontWeight: FontWeight.w300,
                    fontSize: 18,
                    color: HexColor("#110E0D"),
                  ),
                )
              ],
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cart.items.length,
                    itemBuilder: (context, index) {
                      var item = cart.items[index];
                      // retrieve the height from the map based on the item name
                      double containerHeight =
                          itemHeights[item.name] ?? height / 1.6;
                      // return ListTile(
                      //   title: Text(item.name),
                      //   subtitle:
                      //       Text('Price: ${item.price}, Quantity: ${item.quantity}'),
                      //   trailing: IconButton(
                      //     icon: const Icon(
                      //       LineIcons.trash,
                      //       size: 30,
                      //     ),
                      //     onPressed: () => cart.removeItem(item),
                      //   ),
                      // );

                      return SingleChildScrollView(
                        child: Center(
                          child: Column(
                            children: [
                              //all game boxes
                              Padding(
                                padding: const EdgeInsets.only(top: 15),
                                child: Container(
                                  height: containerHeight,
                                  width: width / 1.08,
                                  // color: Colors.yellow,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(23),
                                        topRight: Radius.circular(23),
                                        bottomLeft: Radius.circular(23),
                                        bottomRight: Radius.circular(23)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 4,
                                        offset: Offset(1.4, 1.2),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      //this is for game info and delete icon
                                      Row(
                                        children: [
                                          //game info
                                          Column(
                                            children: [
                                              //game Name
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: 20, top: 20),
                                                child: Text(
                                                  item.name,
                                                  style: const TextStyle(
                                                    fontFamily: 'OpenSanse',
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 23,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),

                                              //Game Price
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 20, top: 0),
                                                child: Text(
                                                  'Entry Fee: ₹${item.price}',
                                                  style: const TextStyle(
                                                    fontFamily: 'OpenSanse',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 18,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),

                                              //text
                                              const Padding(
                                                padding: EdgeInsets.only(
                                                    left: 20, top: 0),
                                                child: Text(
                                                  'per team members',
                                                  style: TextStyle(
                                                    fontFamily: 'OpenSanse',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),

                                          //delete Icon
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 60),
                                            child: IconButton(
                                              icon: const Icon(
                                                LineIcons.trash,
                                                size: 30,
                                              ),
                                              onPressed: () =>
                                                  cart.removeItem(item),
                                            ),
                                          ),
                                        ],
                                      ),

                                      const SizedBox(height: 10),

                                      //for playersBox
                                      if (item.name == 'Tech-Tainment') ...[
                                        ReusableFormFields(
                                          teamSize: 3,
                                          GameName: 'Tech-Tainment',
                                        ),
                                      ] else if (item.name == 'Talassh') ...[
                                        ReusableFormFields(
                                          teamSize: 2,
                                          GameName: 'Talassh',
                                        ),
                                      ] else if (item.name ==
                                          'TheCivilSafari') ...[
                                        ReusableFormFields(
                                          teamSize: 3,
                                          GameName: 'TheCivilSafari',
                                        ),
                                      ] else if (item.name == 'Dekathon') ...[
                                        ReusableFormFields(
                                          teamSize: 4,
                                          GameName: 'Dekathon',
                                        ),
                                      ] else if (item.name ==
                                          'OfficeTennis') ...[
                                        ReusableFormFields(
                                          //is 1 or 2
                                          teamSize:
                                              cart.quantityforOfficeTennis,
                                          GameName: 'OfficeTennis',
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 10),

                //check out button
                InkWell(
                  onTap: () {
                    //set counter to check insert game details are filled up OR not
                    int count = 0;
                    bool isallDetailsRight = true;

                    //Iterate through each item in the cart
                    cart.items.forEach((item) {
                      if (item.name == 'Talassh' &&
                          participateData.isTalaash == true) {
                        //If Talaash game details are filled up, increment the count
                        count += 1;
                      } else if (item.name == 'Tech-Tainment' &&
                          participateData.isTechTainment == true) {
                        //If TechTainment game details are filled up, increment the count
                        count += 1;
                      } else if (item.name == 'TheCivilSafari' &&
                          participateData.isTheCivilSafari == true) {
                        //If Dekathon game details are filled up, increment the count
                        count += 1;
                      } else if (item.name == 'Dekathon' &&
                          participateData.isDekathon == true) {
                        //If Dekathon game details are filled up, increment the count
                        count += 1;
                      } else if (item.name == 'OfficeTennis' &&
                          participateData.isOfficeTennis == true) {
                        //If Dekathon game details are filled up, increment the count
                        count += 1;
                      } else {
                        //If the details are not filled up, set isallDetailsRight to false and break out of the loop
                        isallDetailsRight = false;
                        openSnackbar(
                            context,
                            "Please add all required team members in selected Games",
                            Colors.red);
                        return;
                      }
                    });

                    //If selected game details are fill up then go to the checkout Page
                    if (isallDetailsRight == true &&
                        count == cart.items.length) {
                      print("true");
                      nextScreen(context, checkOutPage());
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 3),
                    height: height / 17,
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
                          padding: const EdgeInsets.only(left: 75),
                          child: LineIcon(
                            LineIcons.checkCircleAlt,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            "Check out",
                            style: const TextStyle(
                              fontFamily: 'OpenSanse',
                              fontWeight: FontWeight.w600,
                              fontSize: 25,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Text('Total Price: ${cart.totalPrice}'),
                // ElevatedButton(
                //   onPressed:
                //       cart.items.isNotEmpty ? () => cart.clearCart() : null,
                //   child: Text('Clear Cart'),
                // ),
              ],
            ),
    );
  }
}

//*********************************************************************************************************/
//resuable formFields
class ReusableFormFields extends StatefulWidget {
  int teamSize;
  String GameName;

  ReusableFormFields({
    Key? key,
    required this.teamSize,
    required this.GameName,
  }) : super(key: key);

  @override
  State<ReusableFormFields> createState() => _ReusableFormFieldsState();
}

class _ReusableFormFieldsState extends State<ReusableFormFields> {
  //for check validation
  final formKey = GlobalKey<FormState>();

  //Text Editing Controller
  final leaderNameController = TextEditingController();
  final player2Controller = TextEditingController();
  final player3Controller = TextEditingController();
  final player4Controller = TextEditingController();
  final player5Controller = TextEditingController();

  //for email
  final leaderEmailController = TextEditingController();
  final player2EmailController = TextEditingController();
  final player3EmailController = TextEditingController();
  final player4EmailController = TextEditingController();
  final player5EmailController = TextEditingController();

  //for collegename
  final leaderCollegeNameController = TextEditingController();
  final player2CollegeNameController = TextEditingController();
  final player3CollegeNameController = TextEditingController();
  final player4CollegeNameController = TextEditingController();
  final player5CollegeNameController = TextEditingController();

  //for enrollment No
  final leaderEnrollmentNoController = TextEditingController();
  final player2EnrollmentNoController = TextEditingController();
  final player3EnrollmentNoController = TextEditingController();
  final player4EnrollmentNoController = TextEditingController();
  final player5EnrollmentNoController = TextEditingController();

  //for sem
  final leaderSemController = TextEditingController();
  final player2SemController = TextEditingController();
  final player3SemController = TextEditingController();
  final player4SemController = TextEditingController();
  final player5SemController = TextEditingController();

  //for branch
  final leaderBranchController = TextEditingController();
  final player2BranchController = TextEditingController();
  final player3BranchController = TextEditingController();
  final player4BranchController = TextEditingController();
  final player5BranchController = TextEditingController();

  //for contect No
  final leaderContectNoController = TextEditingController();
  final player2ContectNoController = TextEditingController();
  final player3ContectNoController = TextEditingController();
  final player4ContectNoController = TextEditingController();
  final player5ContectNoController = TextEditingController();

  //for addmember button
  bool _isAddmemberBtnDiasble = false;

  @override
  void dispose() {
    //for name
    leaderNameController.dispose();
    player2Controller.dispose();
    player3Controller.dispose();
    player4Controller.dispose();
    player5Controller.dispose();

    //for email
    leaderEmailController.dispose();
    player2EmailController.dispose();
    player3EmailController.dispose();
    player4EmailController.dispose();
    player5EmailController.dispose();

    //for college name
    leaderCollegeNameController.dispose();
    player2CollegeNameController.dispose();
    player3CollegeNameController.dispose();
    player4CollegeNameController.dispose();
    player5CollegeNameController.dispose();

    //for enrollment no
    leaderEnrollmentNoController.dispose();
    player2EnrollmentNoController.dispose();
    player3EnrollmentNoController.dispose();
    player4EnrollmentNoController.dispose();
    player5EnrollmentNoController.dispose();

    //for sem
    leaderSemController.dispose();
    player2SemController.dispose();
    player3SemController.dispose();
    player4SemController.dispose();
    player5SemController.dispose();

    //for branch
    leaderBranchController.dispose();
    player2BranchController.dispose();
    player3BranchController.dispose();
    player4BranchController.dispose();
    player5BranchController.dispose();

    //for contact No
    leaderContectNoController.dispose();
    player2ContectNoController.dispose();
    player3ContectNoController.dispose();
    player4ContectNoController.dispose();
    player5ContectNoController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //height and width
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    //for add students data || check visibilty
    final participateData = ParticipateData();
    return Column(
      children: [
        //for 1-playes [in office tennish]
        if (widget.teamSize == 1) ...[
          Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  //leaderController name
                  TextFormField(
                    controller: leaderNameController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: HexColor("#F0F0F2"),
                      prefixIcon: Icon(
                        LineIcons.user,
                        color: HexColor("#11145A"),
                      ),
                      hintText: "leader name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor("#11145A")),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),

                    //for validation
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter player-1 name";
                      }
                    },
                  ),

                  const SizedBox(height: 10),

                  //leaderController email
                  TextFormField(
                    controller: leaderEmailController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: HexColor("#F0F0F2"),
                      prefixIcon: Icon(
                        LineIcons.mailBulk,
                        color: HexColor("#11145A"),
                      ),
                      hintText: "leader email",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor("#11145A")),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),

                    //for validation
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter leader En.no";
                      }
                    },
                  ),

                  const SizedBox(height: 10),

                  //leaderController college name
                  TextFormField(
                    controller: leaderCollegeNameController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: HexColor("#F0F0F2"),
                      prefixIcon: Icon(
                        LineIcons.book,
                        color: HexColor("#11145A"),
                      ),
                      hintText: "leader college name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor("#11145A")),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),

                    //for validation
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter leader College name";
                      }
                    },
                  ),

                  const SizedBox(height: 10),

                  //leaderController enrollment NO
                  TextFormField(
                    controller: leaderEnrollmentNoController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: HexColor("#F0F0F2"),
                      prefixIcon: Icon(
                        LineIcons.calculator,
                        color: HexColor("#11145A"),
                      ),
                      hintText: "leader enrollment no",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor("#11145A")),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),

                    //for validation
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter leader enrollment NO";
                      }
                    },
                  ),

                  const SizedBox(height: 10),

                  //leaderController sem
                  TextFormField(
                    controller: leaderSemController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: HexColor("#F0F0F2"),
                      prefixIcon: Icon(
                        LineIcons.cloud,
                        color: HexColor("#11145A"),
                      ),
                      hintText: "leader semester",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor("#11145A")),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),

                    //for validation
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter leader semester";
                      }
                    },
                  ),

                  const SizedBox(height: 10),

                  //leaderController Branch
                  TextFormField(
                    controller: leaderBranchController,
                    textInputAction: TextInputAction.next,

                    decoration: InputDecoration(
                      filled: true,
                      fillColor: HexColor("#F0F0F2"),
                      prefixIcon: Icon(
                        LineIcons.brain,
                        color: HexColor("#11145A"),
                      ),
                      hintText: "leader Branch",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor("#11145A")),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),

                    //for validation
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter leader branch";
                      }
                    },
                  ),

                  const SizedBox(height: 10),

                  //leaderController Contact No
                  TextFormField(
                    controller: leaderContectNoController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,

                    decoration: InputDecoration(
                      filled: true,
                      fillColor: HexColor("#F0F0F2"),
                      prefixIcon: Icon(
                        LineIcons.phone,
                        color: HexColor("#11145A"),
                      ),
                      hintText: "leader contact no",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor("#11145A")),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),

                    //for validation
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter leader Contact no";
                      }
                    },
                  ),

                  const SizedBox(height: 10),

                  //add student Button
                  InkWell(
                    onTap: () {
                      if (_isAddmemberBtnDiasble == false) {
                        if (formKey.currentState!.validate()) {
                          //for game OfficeTennis
                          if (widget.GameName == 'OfficeTennis') {
                            //disable btn
                            setState(() {
                              _isAddmemberBtnDiasble = true;
                            });
                            print("Student added");
                            //for store data in in ParticipateData for temporary

                            //for team member-1 --> ofice tennish for 2 players
                            participateData.OfficeTennisUser1name =
                                leaderNameController.text;
                            participateData.OfficeTennisUser1email =
                                leaderEmailController.text;
                            participateData.OfficeTennisUser1collegename =
                                leaderCollegeNameController.text;
                            participateData.OfficeTennisUser1enrollmentnO =
                                leaderEnrollmentNoController.text;
                            participateData.OfficeTennisUser1sem =
                                leaderSemController.text;
                            participateData.OfficeTennisUser1branch =
                                leaderBranchController.text;
                            participateData.OfficeTennisUser1contactNo =
                                leaderContectNoController.text;

                            //for team member-2
                            participateData.OfficeTennisUser2name = ' ';
                            participateData.OfficeTennisUser2email = ' ';
                            participateData.OfficeTennisUser2collegename = ' ';
                            participateData.OfficeTennisUser2enrollmentnO = ' ';
                            participateData.OfficeTennisUser2sem = ' ';
                            participateData.OfficeTennisUser2branch = ' ';
                            participateData.OfficeTennisUser2contactNo = ' ';

                            //set Game
                            participateData.isOfficeTennis = true;

                            //incremt game
                            participateData.totalGame +=
                                participateData.totalGame + 1;
                            openSnackbar(
                                context,
                                'Team member added in Game Office Tennis',
                                Color.fromARGB(255, 70, 213, 92));
                          }
                        } else {
                          return null;
                        }
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 3, left: 150),
                      height: height / 20,
                      width: width / 2.5,
                      decoration: BoxDecoration(
                        color: _isAddmemberBtnDiasble == false
                            ? HexColor("#11145A")
                            : HexColor("#C9CBF3"),
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
                            padding: EdgeInsets.only(left: 10),
                            child: Icon(
                              Icons.done,
                              size: 20,
                              color: Colors.white,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 6, bottom: 2),
                            child: Text(
                              "Add members",
                              style: TextStyle(
                                  fontFamily: 'OpenSanse',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13,
                                  color: Colors.white),
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
        ],

        //for 2-players
        if (widget.teamSize == 2) ...[
          //player names and Email
          Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  //leaderController name
                  TextFormField(
                    controller: leaderNameController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: HexColor("#F0F0F2"),
                      prefixIcon: Icon(
                        LineIcons.user,
                        color: HexColor("#11145A"),
                      ),
                      hintText: "leader name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor("#11145A")),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),

                    //for validation
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter player-1 name";
                      }
                    },
                  ),

                  const SizedBox(height: 10),

                  //leaderController email
                  TextFormField(
                    controller: leaderEmailController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: HexColor("#F0F0F2"),
                      prefixIcon: Icon(
                        LineIcons.mailBulk,
                        color: HexColor("#11145A"),
                      ),
                      hintText: "leader email",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor("#11145A")),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),

                    //for validation
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter leader En.no";
                      }
                    },
                  ),

                  const SizedBox(height: 10),

                  //leaderController college name
                  TextFormField(
                    controller: leaderCollegeNameController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: HexColor("#F0F0F2"),
                      prefixIcon: Icon(
                        LineIcons.book,
                        color: HexColor("#11145A"),
                      ),
                      hintText: "leader college name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor("#11145A")),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),

                    //for validation
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter leader College name";
                      }
                    },
                  ),

                  const SizedBox(height: 10),

                  //leaderController enrollment NO
                  TextFormField(
                    controller: leaderEnrollmentNoController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: HexColor("#F0F0F2"),
                      prefixIcon: Icon(
                        LineIcons.calculator,
                        color: HexColor("#11145A"),
                      ),
                      hintText: "leader enrollment no",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor("#11145A")),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),

                    //for validation
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter leader enrollment NO";
                      }
                    },
                  ),

                  const SizedBox(height: 10),

                  //leaderController sem
                  TextFormField(
                    controller: leaderSemController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: HexColor("#F0F0F2"),
                      prefixIcon: Icon(
                        LineIcons.cloud,
                        color: HexColor("#11145A"),
                      ),
                      hintText: "leader semester",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor("#11145A")),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),

                    //for validation
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter leader semester";
                      }
                    },
                  ),

                  const SizedBox(height: 10),

                  //leaderController Branch
                  TextFormField(
                    controller: leaderBranchController,
                    textInputAction: TextInputAction.next,

                    decoration: InputDecoration(
                      filled: true,
                      fillColor: HexColor("#F0F0F2"),
                      prefixIcon: Icon(
                        LineIcons.brain,
                        color: HexColor("#11145A"),
                      ),
                      hintText: "leader Branch",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor("#11145A")),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),

                    //for validation
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter leader branch";
                      }
                    },
                  ),

                  const SizedBox(height: 10),

                  //leaderController Contact No
                  TextFormField(
                    controller: leaderContectNoController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,

                    decoration: InputDecoration(
                      filled: true,
                      fillColor: HexColor("#F0F0F2"),
                      prefixIcon: Icon(
                        LineIcons.phone,
                        color: HexColor("#11145A"),
                      ),
                      hintText: "leader contact no",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor("#11145A")),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),

                    //for validation
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter leader Contact no";
                      }
                    },
                  ),

                  const SizedBox(height: 10),

                  //player-2 name
                  TextFormField(
                    controller: player2Controller,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: HexColor("#F0F0F2"),
                      prefixIcon: Icon(
                        LineIcons.user,
                        color: HexColor("#11145A"),
                      ),
                      hintText: "player-2 name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor("#11145A")),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),

                    //for validation
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter player-2 name";
                      }
                    },
                  ),

                  const SizedBox(height: 10),

                  //player-2 Email
                  TextFormField(
                    controller: player2EmailController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: HexColor("#F0F0F2"),
                      prefixIcon: Icon(
                        LineIcons.mailBulk,
                        color: HexColor("#11145A"),
                      ),
                      hintText: "player-2 email",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor("#11145A")),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),

                    //for validation
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter player-2 En.no";
                      }
                    },
                  ),

                  const SizedBox(height: 18),

                  //player-2 college name
                  TextFormField(
                    controller: player2CollegeNameController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: HexColor("#F0F0F2"),
                      prefixIcon: Icon(
                        LineIcons.book,
                        color: HexColor("#11145A"),
                      ),
                      hintText: "player-2 college name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor("#11145A")),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),

                    //for validation
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter player-2 College name";
                      }
                    },
                  ),

                  const SizedBox(height: 10),

                  //player-2 enrollment NO
                  TextFormField(
                    controller: player2EnrollmentNoController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: HexColor("#F0F0F2"),
                      prefixIcon: Icon(
                        LineIcons.calculator,
                        color: HexColor("#11145A"),
                      ),
                      hintText: "player-2 enrollment no",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor("#11145A")),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),

                    //for validation
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter player-2 enrollment NO";
                      }
                    },
                  ),

                  const SizedBox(height: 10),

                  //player-2 sem
                  TextFormField(
                    controller: player2SemController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: HexColor("#F0F0F2"),
                      prefixIcon: Icon(
                        LineIcons.cloud,
                        color: HexColor("#11145A"),
                      ),
                      hintText: "player-2 semester",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor("#11145A")),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),

                    //for validation
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter player-2 semester";
                      }
                    },
                  ),

                  const SizedBox(height: 10),

                  //player-2 Branch
                  TextFormField(
                    controller: player2BranchController,
                    textInputAction: TextInputAction.next,

                    decoration: InputDecoration(
                      filled: true,
                      fillColor: HexColor("#F0F0F2"),
                      prefixIcon: Icon(
                        LineIcons.brain,
                        color: HexColor("#11145A"),
                      ),
                      hintText: "player-2 Branch",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor("#11145A")),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),

                    //for validation
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter player-2 branch";
                      }
                    },
                  ),

                  const SizedBox(height: 10),

                  //player-2 Contact No
                  TextFormField(
                    controller: player2ContectNoController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,

                    decoration: InputDecoration(
                      filled: true,
                      fillColor: HexColor("#F0F0F2"),
                      prefixIcon: Icon(
                        LineIcons.phone,
                        color: HexColor("#11145A"),
                      ),
                      hintText: "player-2 contact no",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor("#11145A")),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),

                    //for validation
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter player-2 Contact no";
                      }
                    },
                  ),

                  const SizedBox(height: 10),

                  //add student Button
                  InkWell(
                    onTap: () {
                      if (_isAddmemberBtnDiasble == false) {
                        if (formKey.currentState!.validate()) {
                          //for game talaash
                          if (widget.GameName == 'Talassh') {
                            //disable btn
                            setState(() {
                              _isAddmemberBtnDiasble = true;
                            });
                            print("Student added");
                            //for store data in in ParticipateData for temporary

                            //for team member-1
                            participateData.talaashUser1name =
                                leaderNameController.text;
                            participateData.talaashUser1email =
                                leaderEmailController.text;
                            participateData.talaashUser1collegename =
                                leaderCollegeNameController.text;
                            participateData.talaashUser1enrollmentnO =
                                leaderEnrollmentNoController.text;
                            participateData.talaashUser1sem =
                                leaderSemController.text;
                            participateData.talaashUser1branch =
                                leaderBranchController.text;
                            participateData.talaashUser1contactNo =
                                leaderContectNoController.text;

                            //for team member-2
                            participateData.talaashUser2name =
                                player2Controller.text;
                            participateData.talaashUser2email =
                                player2EmailController.text;
                            participateData.talaashUser2collegename =
                                player2CollegeNameController.text;
                            participateData.talaashUser2enrollmentnO =
                                player2EnrollmentNoController.text;
                            participateData.talaashUser2sem =
                                player2SemController.text;
                            participateData.talaashUser2branch =
                                player2BranchController.text;
                            participateData.talaashUser2contactNo =
                                player2ContectNoController.text;

                            //set Game
                            participateData.isTalaash = true;

                            //incremt game
                            participateData.totalGame +=
                                participateData.totalGame + 1;
                            openSnackbar(
                                context,
                                'Team member added in Game Talaash',
                                Color.fromARGB(255, 70, 213, 92));
                          }
                          //for game OfficeTennis --> ofice tennish for 2 players
                          if (widget.GameName == 'OfficeTennis') {
                            //disable btn
                            setState(() {
                              _isAddmemberBtnDiasble = true;
                            });
                            print("Student added");
                            //for store data in in ParticipateData for temporary

                            //for team member-1
                            participateData.OfficeTennisUser1name =
                                leaderNameController.text;
                            participateData.OfficeTennisUser1email =
                                leaderEmailController.text;
                            participateData.OfficeTennisUser1collegename =
                                leaderCollegeNameController.text;
                            participateData.OfficeTennisUser1enrollmentnO =
                                leaderEnrollmentNoController.text;
                            participateData.OfficeTennisUser1sem =
                                leaderSemController.text;
                            participateData.OfficeTennisUser1branch =
                                leaderBranchController.text;
                            participateData.OfficeTennisUser1contactNo =
                                leaderContectNoController.text;

                            //for team member-2
                            participateData.OfficeTennisUser2name =
                                player2Controller.text;
                            participateData.OfficeTennisUser2email =
                                player2EmailController.text;
                            participateData.OfficeTennisUser2collegename =
                                player2CollegeNameController.text;
                            participateData.OfficeTennisUser2enrollmentnO =
                                player2EnrollmentNoController.text;
                            participateData.OfficeTennisUser2sem =
                                player2SemController.text;
                            participateData.OfficeTennisUser2branch =
                                player2BranchController.text;
                            participateData.OfficeTennisUser2contactNo =
                                player2ContectNoController.text;

                            //set Game
                            participateData.isOfficeTennis = true;

                            //incremt game
                            participateData.totalGame +=
                                participateData.totalGame + 1;
                            openSnackbar(
                                context,
                                'Team member added in Game Office Tennis',
                                Color.fromARGB(255, 70, 213, 92));
                          }
                        } else {
                          return null;
                        }
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 3, left: 150),
                      height: height / 20,
                      width: width / 2.5,
                      decoration: BoxDecoration(
                        color: _isAddmemberBtnDiasble == false
                            ? HexColor("#11145A")
                            : HexColor("#C9CBF3"),
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
                            padding: EdgeInsets.only(left: 10),
                            child: Icon(
                              Icons.done,
                              size: 20,
                              color: Colors.white,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 6, bottom: 2),
                            child: Text(
                              "Add members",
                              style: TextStyle(
                                  fontFamily: 'OpenSanse',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13,
                                  color: Colors.white),
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
        ],

        //for 3 players
        if (widget.teamSize == 3) ...[
          //player names and email
          Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  //leaderController name
                  TextFormField(
                    controller: leaderNameController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: HexColor("#F0F0F2"),
                      prefixIcon: Icon(
                        LineIcons.user,
                        color: HexColor("#11145A"),
                      ),
                      hintText: "leader name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor("#11145A")),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),

                    //for validation
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter player-1 name";
                      }
                    },
                  ),

                  const SizedBox(height: 10),

                  //leaderController email
                  TextFormField(
                    controller: leaderEmailController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: HexColor("#F0F0F2"),
                      prefixIcon: Icon(
                        LineIcons.mailBulk,
                        color: HexColor("#11145A"),
                      ),
                      hintText: "leader email",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor("#11145A")),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),

                    //for validation
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter leader En.no";
                      }
                    },
                  ),

                  const SizedBox(height: 10),

                  //Leader college name
                  TextFormField(
                    controller: leaderCollegeNameController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: HexColor("#F0F0F2"),
                      prefixIcon: Icon(
                        LineIcons.book,
                        color: HexColor("#11145A"),
                      ),
                      hintText: "Leader college name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor("#11145A")),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),

                    //for validation
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter leader College name";
                      }
                    },
                  ),

                  const SizedBox(height: 10),

                  //Leader enrollment NO
                  TextFormField(
                    controller: leaderEnrollmentNoController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: HexColor("#F0F0F2"),
                      prefixIcon: Icon(
                        LineIcons.calculator,
                        color: HexColor("#11145A"),
                      ),
                      hintText: "Leader enrollment no",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor("#11145A")),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),

                    //for validation
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter leader enrollment NO";
                      }
                    },
                  ),

                  const SizedBox(height: 10),

                  //leaderController sem
                  TextFormField(
                    controller: leaderSemController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: HexColor("#F0F0F2"),
                      prefixIcon: Icon(
                        LineIcons.cloud,
                        color: HexColor("#11145A"),
                      ),
                      hintText: "leader semester",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor("#11145A")),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),

                    //for validation
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter leader semester";
                      }
                    },
                  ),

                  const SizedBox(height: 10),

                  //leaderController Branch
                  TextFormField(
                    controller: leaderBranchController,
                    textInputAction: TextInputAction.next,

                    decoration: InputDecoration(
                      filled: true,
                      fillColor: HexColor("#F0F0F2"),
                      prefixIcon: Icon(
                        LineIcons.brain,
                        color: HexColor("#11145A"),
                      ),
                      hintText: "leader Branch",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor("#11145A")),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),

                    //for validation
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter leader branch";
                      }
                    },
                  ),

                  const SizedBox(height: 10),

                  //leaderController Contact No
                  TextFormField(
                    controller: leaderContectNoController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,

                    decoration: InputDecoration(
                      filled: true,
                      fillColor: HexColor("#F0F0F2"),
                      prefixIcon: Icon(
                        LineIcons.phone,
                        color: HexColor("#11145A"),
                      ),
                      hintText: "leader contact no",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor("#11145A")),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),

                    //for validation
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter leader Contact no";
                      }
                    },
                  ),

                  const SizedBox(height: 10),

                  //player-2 name
                  TextFormField(
                    controller: player2Controller,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: HexColor("#F0F0F2"),
                      prefixIcon: Icon(
                        LineIcons.user,
                        color: HexColor("#11145A"),
                      ),
                      hintText: "player-2 name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor("#11145A")),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),

                    //for validation
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter player-2 name";
                      }
                    },
                  ),

                  const SizedBox(height: 10),

                  //player-2 Email
                  TextFormField(
                    controller: player2EmailController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: HexColor("#F0F0F2"),
                      prefixIcon: Icon(
                        LineIcons.mailBulk,
                        color: HexColor("#11145A"),
                      ),
                      hintText: "player-2 email",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor("#11145A")),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),

                    //for validation
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter player-2 En.no";
                      }
                    },
                  ),

                  const SizedBox(height: 10),

                  //player-2 college name
                  TextFormField(
                    controller: player2CollegeNameController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: HexColor("#F0F0F2"),
                      prefixIcon: Icon(
                        LineIcons.book,
                        color: HexColor("#11145A"),
                      ),
                      hintText: "player-2 college name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor("#11145A")),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),

                    //for validation
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter player-2 College name";
                      }
                    },
                  ),

                  const SizedBox(height: 10),

                  //player-2 enrollment NO
                  TextFormField(
                    controller: player2EnrollmentNoController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: HexColor("#F0F0F2"),
                      prefixIcon: Icon(
                        LineIcons.calculator,
                        color: HexColor("#11145A"),
                      ),
                      hintText: "player-2 enrollment no",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor("#11145A")),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),

                    //for validation
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter player-2 enrollment NO";
                      }
                    },
                  ),

                  const SizedBox(height: 10),

                  //player-2 sem
                  TextFormField(
                    controller: player2SemController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: HexColor("#F0F0F2"),
                      prefixIcon: Icon(
                        LineIcons.cloud,
                        color: HexColor("#11145A"),
                      ),
                      hintText: "player-2 semester",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor("#11145A")),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),

                    //for validation
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter player-2 semester";
                      }
                    },
                  ),

                  const SizedBox(height: 10),

                  //player-2 Branch
                  TextFormField(
                    controller: player2BranchController,
                    textInputAction: TextInputAction.next,

                    decoration: InputDecoration(
                      filled: true,
                      fillColor: HexColor("#F0F0F2"),
                      prefixIcon: Icon(
                        LineIcons.brain,
                        color: HexColor("#11145A"),
                      ),
                      hintText: "player-2 Branch",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor("#11145A")),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),

                    //for validation
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter player-2 branch";
                      }
                    },
                  ),

                  const SizedBox(height: 10),

                  //player-2 Contact No
                  TextFormField(
                    controller: player2ContectNoController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,

                    decoration: InputDecoration(
                      filled: true,
                      fillColor: HexColor("#F0F0F2"),
                      prefixIcon: Icon(
                        LineIcons.phone,
                        color: HexColor("#11145A"),
                      ),
                      hintText: "player-2 contact no",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor("#11145A")),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),

                    //for validation
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter player-2 Contact no";
                      }
                    },
                  ),

                  const SizedBox(height: 10),

                  //player-3 name
                  TextFormField(
                    controller: player3Controller,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: HexColor("#F0F0F2"),
                      prefixIcon: Icon(
                        LineIcons.user,
                        color: HexColor("#11145A"),
                      ),
                      hintText: "player-3 name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor("#11145A")),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),

                    //for validation
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter player-3 name";
                      }
                    },
                  ),

                  const SizedBox(height: 10),

                  //player-3 Email
                  TextFormField(
                    controller: player3EmailController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: HexColor("#F0F0F2"),
                      prefixIcon: Icon(
                        LineIcons.mailBulk,
                        color: HexColor("#11145A"),
                      ),
                      hintText: "player-3 email",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor("#11145A")),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),

                    //for validation
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter player-3 En.No";
                      }
                    },
                  ),

                  const SizedBox(height: 10),

                  //player-3 college name
                  TextFormField(
                    controller: player3CollegeNameController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: HexColor("#F0F0F2"),
                      prefixIcon: Icon(
                        LineIcons.book,
                        color: HexColor("#11145A"),
                      ),
                      hintText: "player-3 college name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor("#11145A")),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),

                    //for validation
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter player-3 College name";
                      }
                    },
                  ),

                  const SizedBox(height: 10),

                  //player-3 enrollment NO
                  TextFormField(
                    controller: player3EnrollmentNoController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: HexColor("#F0F0F2"),
                      prefixIcon: Icon(
                        LineIcons.calculator,
                        color: HexColor("#11145A"),
                      ),
                      hintText: "player-3 enrollment no",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor("#11145A")),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),

                    //for validation
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter player-3 enrollment NO";
                      }
                    },
                  ),

                  const SizedBox(height: 10),

                  //player-3 sem
                  TextFormField(
                    controller: player3SemController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: HexColor("#F0F0F2"),
                      prefixIcon: Icon(
                        LineIcons.cloud,
                        color: HexColor("#11145A"),
                      ),
                      hintText: "player-3 semester",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor("#11145A")),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),

                    //for validation
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter player-3 semester";
                      }
                    },
                  ),

                  const SizedBox(height: 10),

                  //player-3 Branch
                  TextFormField(
                    controller: player3BranchController,
                    textInputAction: TextInputAction.next,

                    decoration: InputDecoration(
                      filled: true,
                      fillColor: HexColor("#F0F0F2"),
                      prefixIcon: Icon(
                        LineIcons.brain,
                        color: HexColor("#11145A"),
                      ),
                      hintText: "player-3 Branch",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor("#11145A")),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),

                    //for validation
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter player-3 branch";
                      }
                    },
                  ),

                  const SizedBox(height: 10),

                  //player-3 Contact No
                  TextFormField(
                    controller: player3ContectNoController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,

                    decoration: InputDecoration(
                      filled: true,
                      fillColor: HexColor("#F0F0F2"),
                      prefixIcon: Icon(
                        LineIcons.phone,
                        color: HexColor("#11145A"),
                      ),
                      hintText: "player-3 contact no",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor("#11145A")),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),

                    //for validation
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter player-3 Contact no";
                      }
                    },
                  ),

                  const SizedBox(height: 10),

                  //add student Button
                  InkWell(
                    onTap: () {
                      if (_isAddmemberBtnDiasble == false) {
                        if (formKey.currentState!.validate()) {
                          //for tech tainment
                          if (widget.GameName == 'Tech-Tainment') {
                            //disable btn
                            setState(() {
                              _isAddmemberBtnDiasble = true;
                            });
                            print("Student added");

                            //for store data in in ParticipateData for temporary
                            //for team member-1
                            participateData.techTainmentUser1name =
                                leaderNameController.text;
                            participateData.techTainmentUser1email =
                                leaderEmailController.text;
                            participateData.techTainmentUser1collegename =
                                leaderCollegeNameController.text;
                            participateData.techTainmentUser1enrollmentnO =
                                leaderEnrollmentNoController.text;
                            participateData.techTainmentUser1sem =
                                leaderSemController.text;
                            participateData.techTainmentUser1branch =
                                leaderBranchController.text;
                            participateData.techTainmentUser1contactNo =
                                leaderContectNoController.text;

                            //for team member-2
                            participateData.techTainmentUser2name =
                                player2Controller.text;
                            participateData.techTainmentUser2email =
                                player2EmailController.text;
                            participateData.techTainmentUser2collegename =
                                player2CollegeNameController.text;
                            participateData.techTainmentUser2enrollmentnO =
                                player2EnrollmentNoController.text;
                            participateData.techTainmentUser2sem =
                                player2SemController.text;
                            participateData.techTainmentUser2branch =
                                player2BranchController.text;
                            participateData.techTainmentUser2contactNo =
                                player2ContectNoController.text;

                            //for team member-3
                            participateData.techTainmentUser3name =
                                player3Controller.text;
                            participateData.techTainmentUser3email =
                                player3EmailController.text;
                            participateData.techTainmentUser3collegename =
                                player3CollegeNameController.text;
                            participateData.techTainmentUser3enrollmentnO =
                                player3EnrollmentNoController.text;
                            participateData.techTainmentUser3sem =
                                player3SemController.text;
                            participateData.techTainmentUser3branch =
                                player3BranchController.text;
                            participateData.techTainmentUser3contactNo =
                                player3ContectNoController.text;

                            //set Game
                            participateData.isTechTainment = true;

                            //incremt game
                            participateData.totalGame +=
                                participateData.totalGame + 1;

                            openSnackbar(
                                context,
                                'Team member added in Game Tech-Tainment',
                                Color.fromARGB(255, 70, 213, 92));
                          }

                          //for TheCivilSafari
                          if (widget.GameName == 'TheCivilSafari') {
                            //disable btn
                            setState(() {
                              _isAddmemberBtnDiasble = true;
                            });
                            print("Student added");

                            //for store data in in ParticipateData for temporary
                            //for team member-1
                            participateData.TheCivilSafariUser1name =
                                leaderNameController.text;
                            participateData.TheCivilSafariUser1email =
                                leaderEmailController.text;
                            participateData.TheCivilSafariUser1collegename =
                                leaderCollegeNameController.text;
                            participateData.TheCivilSafariUser1enrollmentnO =
                                leaderEnrollmentNoController.text;
                            participateData.TheCivilSafariUser1sem =
                                leaderSemController.text;
                            participateData.TheCivilSafariUser1branch =
                                leaderBranchController.text;
                            participateData.TheCivilSafariUser1contactNo =
                                leaderContectNoController.text;

                            //for team member-2
                            participateData.TheCivilSafariUser2name =
                                player2Controller.text;
                            participateData.TheCivilSafariUser2email =
                                player2EmailController.text;
                            participateData.TheCivilSafariUser2collegename =
                                player2CollegeNameController.text;
                            participateData.TheCivilSafariUser2enrollmentnO =
                                player2EnrollmentNoController.text;
                            participateData.TheCivilSafariUser2sem =
                                player2SemController.text;
                            participateData.TheCivilSafariUser2branch =
                                player2BranchController.text;
                            participateData.TheCivilSafariUser2contactNo =
                                player2ContectNoController.text;

                            //for team member-3
                            participateData.TheCivilSafariUser3name =
                                player3Controller.text;
                            participateData.TheCivilSafariUser3email =
                                player3EmailController.text;
                            participateData.TheCivilSafariUser3collegename =
                                player3CollegeNameController.text;
                            participateData.TheCivilSafariUser3enrollmentnO =
                                player3EnrollmentNoController.text;
                            participateData.TheCivilSafariUser3sem =
                                player3SemController.text;
                            participateData.TheCivilSafariUser3branch =
                                player3BranchController.text;
                            participateData.TheCivilSafariUser3contactNo =
                                player3ContectNoController.text;

                            //set Game
                            participateData.isTheCivilSafari = true;

                            //incremt game
                            participateData.totalGame +=
                                participateData.totalGame + 1;

                            openSnackbar(
                                context,
                                'Team member added in Game The Civil Safari',
                                Color.fromARGB(255, 70, 213, 92));
                          }
                        } else {
                          return null;
                        }
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 3, left: 150),
                      height: height / 20,
                      width: width / 2.5,
                      decoration: BoxDecoration(
                        color: _isAddmemberBtnDiasble == false
                            ? HexColor("#11145A")
                            : HexColor("#C9CBF3"),
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
                            padding: EdgeInsets.only(left: 10),
                            child: Icon(
                              Icons.done,
                              size: 20,
                              color: Colors.white,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 6, bottom: 2),
                            child: Text(
                              "Add members",
                              style: TextStyle(
                                  fontFamily: 'OpenSanse',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13,
                                  color: Colors.white),
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
        ],

        //for 4- players
        if (widget.teamSize == 4) ...[
          //player names and Email
          Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  //leaderController name
                  TextFormField(
                    controller: leaderNameController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: HexColor("#F0F0F2"),
                      prefixIcon: Icon(
                        LineIcons.user,
                        color: HexColor("#11145A"),
                      ),
                      hintText: "leader name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor("#11145A")),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),

                    //for validation
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter player-1 name";
                      }
                    },
                  ),

                  const SizedBox(height: 10),

                  //leaderController Email
                  TextFormField(
                    controller: leaderEmailController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: HexColor("#F0F0F2"),
                      prefixIcon: Icon(
                        LineIcons.mailBulk,
                        color: HexColor("#11145A"),
                      ),
                      hintText: "leader email",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor("#11145A")),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),

                    //for validation
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter leader En.no";
                      }
                    },
                  ),

                  const SizedBox(height: 10),

                  //leaderController college name
                  TextFormField(
                    controller: leaderCollegeNameController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: HexColor("#F0F0F2"),
                      prefixIcon: Icon(
                        LineIcons.book,
                        color: HexColor("#11145A"),
                      ),
                      hintText: "leader college name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor("#11145A")),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),

                    //for validation
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter leader College name";
                      }
                    },
                  ),

                  const SizedBox(height: 10),

                  //leaderController enrollment NO
                  TextFormField(
                    controller: leaderEnrollmentNoController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: HexColor("#F0F0F2"),
                      prefixIcon: Icon(
                        LineIcons.calculator,
                        color: HexColor("#11145A"),
                      ),
                      hintText: "leader enrollment no",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor("#11145A")),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),

                    //for validation
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter leader enrollment NO";
                      }
                    },
                  ),

                  const SizedBox(height: 10),

                  //leaderController sem
                  TextFormField(
                    controller: leaderSemController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: HexColor("#F0F0F2"),
                      prefixIcon: Icon(
                        LineIcons.cloud,
                        color: HexColor("#11145A"),
                      ),
                      hintText: "leader semester",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor("#11145A")),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),

                    //for validation
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter leader semester";
                      }
                    },
                  ),

                  const SizedBox(height: 10),

                  //leaderController Branch
                  TextFormField(
                    controller: leaderBranchController,
                    textInputAction: TextInputAction.next,

                    decoration: InputDecoration(
                      filled: true,
                      fillColor: HexColor("#F0F0F2"),
                      prefixIcon: Icon(
                        LineIcons.brain,
                        color: HexColor("#11145A"),
                      ),
                      hintText: "leader Branch",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor("#11145A")),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),

                    //for validation
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter leader branch";
                      }
                    },
                  ),

                  const SizedBox(height: 10),

                  //leaderController Contact No
                  TextFormField(
                    controller: leaderContectNoController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,

                    decoration: InputDecoration(
                      filled: true,
                      fillColor: HexColor("#F0F0F2"),
                      prefixIcon: Icon(
                        LineIcons.phone,
                        color: HexColor("#11145A"),
                      ),
                      hintText: "leader contact no",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor("#11145A")),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),

                    //for validation
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter leader Contact no";
                      }
                    },
                  ),

                  const SizedBox(height: 10),

                  //player-2 name
                  TextFormField(
                    controller: player2Controller,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: HexColor("#F0F0F2"),
                      prefixIcon: Icon(
                        LineIcons.user,
                        color: HexColor("#11145A"),
                      ),
                      hintText: "player-2 name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor("#11145A")),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),

                    //for validation
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter player-2 name";
                      }
                    },
                  ),

                  const SizedBox(height: 10),

                  //player-2 Email
                  TextFormField(
                    controller: player2EmailController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: HexColor("#F0F0F2"),
                      prefixIcon: Icon(
                        LineIcons.mailBulk,
                        color: HexColor("#11145A"),
                      ),
                      hintText: "player-2 email",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor("#11145A")),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),

                    //for validation
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter player-2 En.no";
                      }
                    },
                  ),

                  const SizedBox(height: 10),

                  //player-2 college name
                  TextFormField(
                    controller: player2CollegeNameController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: HexColor("#F0F0F2"),
                      prefixIcon: Icon(
                        LineIcons.book,
                        color: HexColor("#11145A"),
                      ),
                      hintText: "player-2 college name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor("#11145A")),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),

                    //for validation
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter player-2 College name";
                      }
                    },
                  ),

                  const SizedBox(height: 10),

                  //player-2 enrollment NO
                  TextFormField(
                    controller: player2EnrollmentNoController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: HexColor("#F0F0F2"),
                      prefixIcon: Icon(
                        LineIcons.calculator,
                        color: HexColor("#11145A"),
                      ),
                      hintText: "player-2 enrollment no",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor("#11145A")),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),

                    //for validation
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter player-2 enrollment NO";
                      }
                    },
                  ),

                  const SizedBox(height: 10),

                  //player-2 sem
                  TextFormField(
                    controller: player2SemController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: HexColor("#F0F0F2"),
                      prefixIcon: Icon(
                        LineIcons.cloud,
                        color: HexColor("#11145A"),
                      ),
                      hintText: "player-2 semester",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor("#11145A")),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),

                    //for validation
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter player-2 semester";
                      }
                    },
                  ),

                  const SizedBox(height: 10),

                  //player-2 Branch
                  TextFormField(
                    controller: player2BranchController,
                    textInputAction: TextInputAction.next,

                    decoration: InputDecoration(
                      filled: true,
                      fillColor: HexColor("#F0F0F2"),
                      prefixIcon: Icon(
                        LineIcons.brain,
                        color: HexColor("#11145A"),
                      ),
                      hintText: "player-2 Branch",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor("#11145A")),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),

                    //for validation
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter player-2 branch";
                      }
                    },
                  ),

                  const SizedBox(height: 10),

                  //player-2 Contact No
                  TextFormField(
                    controller: player2ContectNoController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,

                    decoration: InputDecoration(
                      filled: true,
                      fillColor: HexColor("#F0F0F2"),
                      prefixIcon: Icon(
                        LineIcons.phone,
                        color: HexColor("#11145A"),
                      ),
                      hintText: "player-2 contact no",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor("#11145A")),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),

                    //for validation
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter player-2 Contact no";
                      }
                    },
                  ),

                  const SizedBox(height: 10),

                  //player-3 name
                  TextFormField(
                    controller: player3Controller,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: HexColor("#F0F0F2"),
                      prefixIcon: Icon(
                        LineIcons.user,
                        color: HexColor("#11145A"),
                      ),
                      hintText: "player-3 name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor("#11145A")),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),

                    //for validation
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter player-3 name";
                      }
                    },
                  ),

                  const SizedBox(height: 10),

                  //player-3 Email
                  TextFormField(
                    controller: player3EmailController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: HexColor("#F0F0F2"),
                      prefixIcon: Icon(
                        LineIcons.mailBulk,
                        color: HexColor("#11145A"),
                      ),
                      hintText: "player-3 email",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor("#11145A")),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),

                    //for validation
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter player-3 En.No";
                      }
                    },
                  ),

                  const SizedBox(height: 10),

                  //player-3 college name
                  TextFormField(
                    controller: player3CollegeNameController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: HexColor("#F0F0F2"),
                      prefixIcon: Icon(
                        LineIcons.book,
                        color: HexColor("#11145A"),
                      ),
                      hintText: "player-3 college name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor("#11145A")),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),

                    //for validation
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter player-3 College name";
                      }
                    },
                  ),

                  const SizedBox(height: 10),

                  //player-3 enrollment NO
                  TextFormField(
                    controller: player3EnrollmentNoController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: HexColor("#F0F0F2"),
                      prefixIcon: Icon(
                        LineIcons.calculator,
                        color: HexColor("#11145A"),
                      ),
                      hintText: "player-3 enrollment no",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor("#11145A")),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),

                    //for validation
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter player-3 enrollment NO";
                      }
                    },
                  ),

                  const SizedBox(height: 10),

                  //player-3 sem
                  TextFormField(
                    controller: player3SemController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: HexColor("#F0F0F2"),
                      prefixIcon: Icon(
                        LineIcons.cloud,
                        color: HexColor("#11145A"),
                      ),
                      hintText: "player-3 semester",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor("#11145A")),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),

                    //for validation
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter player-3 semester";
                      }
                    },
                  ),

                  const SizedBox(height: 10),

                  //player-3 Branch
                  TextFormField(
                    controller: player3BranchController,
                    textInputAction: TextInputAction.next,

                    decoration: InputDecoration(
                      filled: true,
                      fillColor: HexColor("#F0F0F2"),
                      prefixIcon: Icon(
                        LineIcons.brain,
                        color: HexColor("#11145A"),
                      ),
                      hintText: "player-3 Branch",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor("#11145A")),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),

                    //for validation
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter player-3 branch";
                      }
                    },
                  ),

                  const SizedBox(height: 10),

                  //player-3 Contact No
                  TextFormField(
                    controller: player3ContectNoController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,

                    decoration: InputDecoration(
                      filled: true,
                      fillColor: HexColor("#F0F0F2"),
                      prefixIcon: Icon(
                        LineIcons.phone,
                        color: HexColor("#11145A"),
                      ),
                      hintText: "player-3 contact no",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor("#11145A")),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),

                    //for validation
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter player-3 Contact no";
                      }
                    },
                  ),

                  const SizedBox(height: 10),

                  //player-4 name
                  TextFormField(
                    controller: player4Controller,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: HexColor("#F0F0F2"),
                      prefixIcon: Icon(
                        LineIcons.user,
                        color: HexColor("#11145A"),
                      ),
                      hintText: "player-4 name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor("#11145A")),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),

                    //for validation
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter player-4 name";
                      }
                    },
                  ),

                  const SizedBox(height: 10),

                  //player-4 Email
                  TextFormField(
                    controller: player4EmailController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: HexColor("#F0F0F2"),
                      prefixIcon: Icon(
                        LineIcons.mailBulk,
                        color: HexColor("#11145A"),
                      ),
                      hintText: "player-4 email",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor("#11145A")),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),

                    //for validation
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter player-4 En.No";
                      }
                    },
                  ),

                  const SizedBox(height: 10),

                  //player-4 college name
                  TextFormField(
                    controller: player4CollegeNameController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: HexColor("#F0F0F2"),
                      prefixIcon: Icon(
                        LineIcons.book,
                        color: HexColor("#11145A"),
                      ),
                      hintText: "player-4 college name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor("#11145A")),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),

                    //for validation
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter player-4 College name";
                      }
                    },
                  ),

                  const SizedBox(height: 10),

                  //player-4 enrollment NO
                  TextFormField(
                    controller: player4EnrollmentNoController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: HexColor("#F0F0F2"),
                      prefixIcon: Icon(
                        LineIcons.calculator,
                        color: HexColor("#11145A"),
                      ),
                      hintText: "player-4 enrollment no",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor("#11145A")),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),

                    //for validation
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter player-4 enrollment NO";
                      }
                    },
                  ),

                  const SizedBox(height: 10),

                  //player-4 sem
                  TextFormField(
                    controller: player4SemController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: HexColor("#F0F0F2"),
                      prefixIcon: Icon(
                        LineIcons.cloud,
                        color: HexColor("#11145A"),
                      ),
                      hintText: "player-4 semester",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor("#11145A")),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),

                    //for validation
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter player-4 semester";
                      }
                    },
                  ),

                  const SizedBox(height: 10),

                  //player-4 Branch
                  TextFormField(
                    controller: player4BranchController,
                    textInputAction: TextInputAction.next,

                    decoration: InputDecoration(
                      filled: true,
                      fillColor: HexColor("#F0F0F2"),
                      prefixIcon: Icon(
                        LineIcons.brain,
                        color: HexColor("#11145A"),
                      ),
                      hintText: "player-4 Branch",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor("#11145A")),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),

                    //for validation
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter player-4 branch";
                      }
                    },
                  ),

                  const SizedBox(height: 10),

                  //player-4 Contact No
                  TextFormField(
                    controller: player4ContectNoController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,

                    decoration: InputDecoration(
                      filled: true,
                      fillColor: HexColor("#F0F0F2"),
                      prefixIcon: Icon(
                        LineIcons.phone,
                        color: HexColor("#11145A"),
                      ),
                      hintText: "player-4 contact no",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor("#11145A")),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),

                    //for validation
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter player-4 Contact no";
                      }
                    },
                  ),

                  const SizedBox(height: 10),

                  //add student Button
                  InkWell(
                    onTap: () {
                      if (_isAddmemberBtnDiasble == false) {
                        if (formKey.currentState!.validate()) {
                          //for game Dekathon
                          if (widget.GameName == 'Dekathon') {
                            //disable btn
                            setState(() {
                              _isAddmemberBtnDiasble = true;
                            });
                            print("Student added");
                            //for store data in in ParticipateData for temporary

                            //for team member-1
                            participateData.DekathonUser1name =
                                leaderNameController.text;
                            participateData.DekathonUser1email =
                                leaderEmailController.text;
                            participateData.DekathonUser1collegename =
                                leaderCollegeNameController.text;
                            participateData.DekathonUser1enrollmentnO =
                                leaderEnrollmentNoController.text;
                            participateData.DekathonUser1sem =
                                leaderSemController.text;
                            participateData.DekathonUser1branch =
                                leaderBranchController.text;
                            participateData.DekathonUser1contactNo =
                                leaderContectNoController.text;

                            //for team member-2
                            participateData.DekathonUser2name =
                                player2Controller.text;
                            participateData.DekathonUser2email =
                                player2EmailController.text;
                            participateData.DekathonUser2collegename =
                                player2CollegeNameController.text;
                            participateData.DekathonUser2enrollmentnO =
                                player2EnrollmentNoController.text;
                            participateData.DekathonUser2sem =
                                player2SemController.text;
                            participateData.DekathonUser2branch =
                                player2BranchController.text;
                            participateData.DekathonUser2contactNo =
                                player2ContectNoController.text;

                            //for team member-3
                            participateData.DekathonUser3name =
                                player3Controller.text;
                            participateData.DekathontUser3email =
                                player3EmailController.text;
                            participateData.DekathonUser3collegename =
                                player3CollegeNameController.text;
                            participateData.DekathonUser3enrollmentnO =
                                player3EnrollmentNoController.text;
                            participateData.DekathonUser3sem =
                                player3SemController.text;
                            participateData.DekathonUser3branch =
                                player3BranchController.text;
                            participateData.DekathonUser3contactNo =
                                player3ContectNoController.text;

                            //for team member-4
                            participateData.DekathonUser4name =
                                player4Controller.text;
                            participateData.DekathontUser4email =
                                player4EmailController.text;
                            participateData.DekathonUser4collegename =
                                player4CollegeNameController.text;
                            participateData.DekathonUser4enrollmentnO =
                                player4EnrollmentNoController.text;
                            participateData.DekathonUser4sem =
                                player4SemController.text;
                            participateData.DekathonUser4branch =
                                player4BranchController.text;
                            participateData.DekathonUser4contactNo =
                                player4ContectNoController.text;

                            //set Game
                            participateData.isDekathon = true;

                            //incremt game
                            participateData.totalGame +=
                                participateData.totalGame + 1;
                            openSnackbar(
                                context,
                                'Team member added in Game Dekathon',
                                Color.fromARGB(255, 70, 213, 92));
                          }
                        } else {
                          return null;
                        }
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 3, left: 150),
                      height: height / 20,
                      width: width / 2.5,
                      decoration: BoxDecoration(
                        color: _isAddmemberBtnDiasble == false
                            ? HexColor("#11145A")
                            : HexColor("#C9CBF3"),
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
                            padding: EdgeInsets.only(left: 10),
                            child: Icon(
                              Icons.done,
                              size: 20,
                              color: Colors.white,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 6, bottom: 2),
                            child: Text(
                              "Add members",
                              style: TextStyle(
                                  fontFamily: 'OpenSanse',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13,
                                  color: Colors.white),
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
        ]
      ],
    );
  }
}
