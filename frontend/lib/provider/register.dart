import 'package:flutter/material.dart';

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class RegisterProvider extends ChangeNotifier {
  List _userData = [];
  String url = "http://10.141.215.106/3000";

  void signup(String name, String password, String username) async {
    Map<String, String> jsonData = {
      "name": name,
      "username": username,
      "password": password
    };
    try {
      final response = await http.post(Uri.parse("$url/api/patient/register"),
          body: json.encode(jsonData));
      final resData = response.body;
      print(resData);
      print(jsonData);
    } catch (e) {
      print(e);
    }
  }
}
