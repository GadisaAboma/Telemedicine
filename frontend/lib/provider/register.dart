import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../utils/helpers.dart';

class RegisterProvider extends ChangeNotifier {
  List _userData = [];
  bool isLoading = false;
  var unApprovedDoctorsList;
  late String me;
  dynamic currentUser;
  late dynamic doctordInfo;

  String loggedId = '';
  String userType = '';

  void setLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  Future fetchMessage(String username) async {
    try {
      final response = await http.post(
        Uri.parse("$serverUrl/api/patients/fetchPatient"),
        headers: {
          "Content-type": "application/json",
          "Accept": "application/json",
        },
        body: json.encode({"username": username}),
      );
      return json.decode(response.body);
    } catch (e) {
      return e;
    }
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
      final String routeType = accountType == "patient"
          ? "patients/registerPatient"
          : "doctors/registerDoctor";

      final response = await http.post(Uri.parse("$serverUrl/api/$routeType"),
          body: json.encode(jsonData),
          headers: {
            "Content-type": "application/json",
            "Accept": "application/json",
          });

      final responseData = json.decode(response.body);
      if (response.statusCode == 400) {
        return Future.error(responseData["error"]);
      }
      currentUser = responseData;
      if (responseData["role"] == "doctor") {
        doctordInfo = responseData["_doc"];
      }

      setLoading();
      notifyListeners();
      return "success";
    } on SocketException catch (e) {
      print(e.message);
      return Future.error(e.message);
    } catch (e) {
      throw Exception("Error happened");
    }
  }

  // late String me;
  // late dynamic doctordInfo;

  Future fetchPatient(String username) async {
    try {
      final response = await http.post(
          Uri.parse("$serverUrl/api/patients/fetchPatient"),
          body: json.encode({"username": username}),
          headers: {
            "Content-type": "application/json",
            "Accept": "application/json",
          });
      // print("response data  " + response.body);
      return json.decode(response.body);
    } catch (e) {
      print(e);
    }
  }

  Future<void> unApprovedDoctors() async {
    try {
      final response =
          await http.get(Uri.parse("$serverUrl/api/admin/requests"));
      // print(json.decode(response.body));
      unApprovedDoctorsList = json.decode(response.body);
      print(json.decode(response.body));
      notifyListeners();
    } catch (e) {
      unApprovedDoctorsList = [
        null,
      ];
      notifyListeners();
    }
  }

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
      if (response.statusCode == 404) {
        return Future.error((json.decode(response.body)["error"]));
      }
      final responseData = json.decode(response.body);
      setLoading();

      me = responseData["_doc"]["username"];
      currentUser = responseData["_doc"];
      // me.add(User(responseData["_doc"]["username"], responseData["_doc"]["_id"]));

      if (responseData["role"] == "doctor") {
        doctordInfo = responseData["_doc"];
      }

      userType = responseData['role'] + 's';
      loggedId = responseData['_doc']['_id'];

      return {"role": responseData["role"], "user": responseData["_doc"]};
    } catch (e) {
    print(e);
      return Future.error("Error happened");
    }
  }

  String get loggedUserId {
    return loggedId;
  }

  String get loggedUserType {
    return userType;
  }
}
