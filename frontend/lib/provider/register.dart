import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../utils/helpers.dart';

class RegisterProvider extends ChangeNotifier {
  List _userData = [];
  bool isLoading = false;

  void setLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  Future register(String name, String username, String password,
      String accountType, String specializedIn, String gender) async {
    print("object");
    setLoading();
    Map<String, String> jsonData = accountType == "doctor"
        ? {
            "name": name,
            "gender": gender,
            "username": username,
            "password": password,
            "specializedIn": specializedIn,
          }
        : {
            "name": name,
            "username": username,
            "gender": gender,
            "password": password,
          };

    try {
      // final result = await InternetAddress.lookup('google.com');
      // if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      //   print('connected');
      // }

      final String routeType = accountType == "patient"
          ? "patients/registerPatient"
          : "doctors/registerDoctor";
      print("object $accountType");
      final response = await http.post(Uri.parse("$serverUrl/api/$routeType"),
          body: json.encode(jsonData),
          headers: {
            "Content-type": "application/json",
            "Accept": "application/json",
          });
      final responseData = json.decode(response.body);
      print(responseData);

      setLoading();
      // notifyListeners();
      return "success";
      // print(jsonData);
    } on SocketException catch (e) {
      print('not connected');
      return e;
    } catch (e) {
      return e;
    }
  }

  late String me;
  late dynamic doctordInfo;

  Future login(String username, String password) async {
    Map<String, String> loginData = {
      "username": username,
      "password": password
    };
    try {
      final response = await http.post(Uri.parse("$serverUrl/api/user/login"),
          body: json.encode(loginData),
          headers: {
            "Content-type": "application/json",
            "Accept": "application/json",
          });
      final responseData = json.decode(response.body);
      setLoading();
      // print(responseData);
      me = responseData["_doc"]["username"];
      // me.add(User(responseData["_doc"]["username"], responseData["_doc"]["_id"]));

      if (responseData["role"] == "doctor") {
        doctordInfo = responseData["_doc"];
      }
      return {
        "role": responseData["role"],
      };
    } catch (e) {
      print(e);
      return e;
    }
  }
}
