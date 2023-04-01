import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vegy2023/models/paymentHistoryModel.dart';
import 'package:vegy2023/pages/AdminPageDegree.dart';
import 'package:vegy2023/pages/AdminPageDiploma.dart';
import 'package:vegy2023/pages/FirstPage.dart';
import 'package:vegy2023/pages/Nextscreen.dart';
import 'package:vegy2023/pages/paymentHistory.dart';
import '../Provider/userprovider.dart';
import 'SnackBar.dart';

class AdminPage extends StatefulWidget {
  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    //get Data From mongodb using StudentProvider Class
    final user = Provider.of<UserProvider>(context).user;

    //height and width
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: user.uid == "641f1ef410e9665b5a14fa85"
            ? AdminPageDegree()
            : AdminPageDiploma(),
      ),
    );
  }
}
