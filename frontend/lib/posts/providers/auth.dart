import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/http_exception.dart';

class Auth extends ChangeNotifier {
  String _token = '';
  DateTime _expiryDate = DateTime.now();
  String _userId = '';
  String _loggedName = '';

  bool get isAuth {
    return _token != '';
  }

  void get deleteToken {
    _token = '';
    notifyListeners();
  }

  String get loggedUser {
    return _loggedName;
  }

  String get token {
    return _token;
  }

  Future<void> signUp(String name, String email, String password) async {
    var url = Uri.parse('http://192.168.1.41:3000/api/user/register');

    try {
      final res = await http.post(
        url,
        body: json.encode(
          {'name': name, 'email': email, 'password': password},
        ),
        headers: {
          "Content-Type": "application/json",
          "Access-Control-Allow-Origin": "*"
        },
      );

      if (res.statusCode == 404) {
        throw HttpException(res.body);
      }

      final payload = json.decode(res.body);
    } catch (err) {
      rethrow;
    }
  }

  Future<void> login(String email, String password) async {
    var url = Uri.parse('http://10.141.221.253:3000/api/user/login');

    try {
      final res = await http.post(
        url,
        body: json.encode(
          {'email': email, 'password': password},
        ),
        headers: {
          "Content-Type": "application/json",
          "Access-Control-Allow-Origin": "*"
        },
      );

      var payload = json.decode(res.body);

      if (res.statusCode == 400) {
        throw HttpException(res.body);
      }
      _token = payload['token'];
      _userId = payload['id'];
      _loggedName = payload['name'];
      notifyListeners();
    } catch (err) {
      rethrow;
    }
  }
}
