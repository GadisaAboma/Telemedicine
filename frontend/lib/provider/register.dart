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

  Future signup(String name, String username, String password) async {
    setLoading();
    Map<String, String> jsonData = {
      "name": name,
      "username": username,
      "password": password
    };
    // print("object");
    try {
      final response = await http.post(
          Uri.parse("${Helpers.url}/api/patients/registerPatient"),
          body: json.encode(jsonData),
          headers: {
            "Content-type": "application/json",
            "Accept": "application/json",
          });
      final responseData = json.decode(response.body);
      setLoading();
      notifyListeners();
      return "success";
      // print(jsonData);
    } catch (e) {
      return e;
    }
  }
}
