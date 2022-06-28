import 'package:flutter/material.dart';

import 'dart:convert';
import 'dart:io';
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
    try {
      final response = await http.post(
          Uri.parse("${Helpers.ip}/api/patient/register"),
          body: json.encode(jsonData));
      final resData = response.body;
      print(resData);
      print(jsonData);
    } catch (e) {
      print(e);
    }
  }
}
