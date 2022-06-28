import 'package:flutter/material.dart';

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../utils/helpers.dart';

class RegisterProvider extends ChangeNotifier {
  List _userData = [];
  

  void signup(String name, String username, String password) async {
    Map<String, String> jsonData = {
      "name": name,
      "username": username,
      "password": password
    };
    print("object");
    try {
      final response = await http.post(
          Uri.parse("${Helpers.url}/api/patients/registerPatient"),
          body: json.encode(jsonData),
          headers: {
            "Content-type": "application/json",
            "Accept": "application/json",
          });
      final resData = json.decode(response.body);
      print(resData);
      notifyListeners();
      // print(jsonData);
    } catch (e) {
      print(e);
    }
  }
}
