import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/helpers.dart';

class RegisterProvider extends ChangeNotifier {
  List _userData = [];
  bool isLoading = false;

  void setLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  Future register(
      String name, String username, String password, String accountType) async {
    setLoading();
    Map<String, String> jsonData = {
      "name": name,
      "username": username,
      "password": password
    };

    try {
      final String routeType =
          accountType == "patient" ? "registerPatient" : "registerDoctor";
      print("object $accountType");
      final response = await http.post(
          Uri.parse("${Helpers.url}/api/patients/$routeType"),
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
    } catch (e) {
      return e;
    }
  }

  Future login(String username, String password) async {
    Map<String, String> loginData = {
      "username": username,
      "password": password
    };
    try {
      final response = await http.post(
          Uri.parse("${Helpers.url}/api/user/login"),
          body: json.encode(loginData),
          headers: {
            "Content-type": "application/json",
            "Accept": "application/json",
          });
      final responseData = json.decode(response.body);
      print(responseData["_doc"]);
      setLoading();
      return responseData;
    } catch (e) {
      print(e);
      return e;
    }
  }
}
