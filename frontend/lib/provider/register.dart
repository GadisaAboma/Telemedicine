import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/helpers.dart';

class RegisterProvider extends ChangeNotifier {
  List _userData = [];

  void signup(String name, String password, String username) async {
    Map<String, String> jsonData = {
      "name": name,
      "username": username,
      "password": password
    };

    print("${Helpers.ip}/api/patients/registerPatient");
    try {
      final response = await http.post(
          Uri.parse("http://10.141.215.115:3000/api/patients/registerPatient"),
          body: json.encode(jsonData),
          headers: {
            "Content-type": "application/json",
            "Accept": "application/json",
          });
      final resData = response.body;
      print(resData);
      print(jsonData);
    } catch (e) {
      print(e);
    }
  }
}
