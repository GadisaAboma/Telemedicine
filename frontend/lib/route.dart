import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:frontend/login/login.dart';
import 'package:frontend/provider/register.dart';
import 'package:frontend/video%20chat/utils/sotre_util.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'utils/helpers.dart';

class RouteApp extends StatefulWidget {
  const RouteApp({Key? key}) : super(key: key);

  @override
  State<RouteApp> createState() => _RouteAppState();
}

class _RouteAppState extends State<RouteApp> {
  String username = "";
  String password = "";
  bool isLoading = false;

  @override
  void initState() {
  Firebase.initializeApp();

    super.initState();

    Future.delayed(Duration.zero, () => {getData()});
  }

  Future getData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    username = sharedPreferences.getString("username").toString();
    password = sharedPreferences.getString("password").toString();
    if (username.isNotEmpty) {
      final loginResponse =
          await Provider.of<RegisterProvider>(context, listen: false)
              .login(username, password);

      ////////// storing username and password to local storage
      LocalStorage.write('userid', loginResponse["user"]["_id"]);
      LocalStorage.write('username', username);

      switch (loginResponse['role']) {
        case "admin":
          Navigator.pushReplacementNamed(context, adminHomeRoute);
          break;
        case "doctor":
          Navigator.pushReplacementNamed(context, doctorHomeRoute,
              arguments: loginResponse["user"]["_id"]);

          break;
        case "patient":
          Navigator.pushReplacementNamed(context, patientHomeRoute);
          break;
        default:
          // Navigator.pop(context);
          setState(() {
            isLoading = false;
          });
      }
    }
    ;
  }

  @override
  Widget build(BuildContext context) {
    return username.isEmpty ? Login() : Container();
  }
}
