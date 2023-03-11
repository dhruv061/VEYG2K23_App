import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import '../pages/SnackBar.dart';

void hhtpErrorHanle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {

    //for signup we get 201 success code
    case 201:
      onSuccess();
      break;

    //for signin we get 201 success code
    case 200:
      onSuccess();
      break;

    case 400:
      openSnackbar(context, jsonDecode(response.body)['msg'],
          Color.fromARGB(255, 225, 38, 25));
      break;

    case 500:
      openSnackbar(context, jsonDecode(response.body)['error'],
          Color.fromARGB(255, 214, 27, 14));
      break;

    default:
      openSnackbar(context, response.body, Color.fromARGB(255, 233, 21, 6));
  }
}
