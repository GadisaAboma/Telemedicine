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
      print(responseData);
      currentUser = responseData;
      if (responseData["role"] == "doctor") {
        doctordInfo = responseData["_doc"];
      }

      setLoading();
      notifyListeners();
      return "success";
    } on SocketException catch (e) {
      return e;
    } catch (e) {
      return e;
    }
  }

  Future approveRequest(String id) async {
    final response = await http.post(Uri.parse("$serverUrl/api/admin/approve"),
        body: json.encode({"id": id}),
        headers: {
          "Content-type": "application/json",
          "Accept": "application/json",
        });
    print(json.decode(response.body));
    unApprovedDoctorsList = [];
    await unApprovedDoctors();
    notifyListeners();
  }

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
      return json.decode( response.body);
<<<<<<< HEAD
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
=======
>>>>>>> parent of c6d9ecc (chatbot added)
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
      print(loginData);
      final response = await http.post(Uri.parse("$serverUrl/api/user/login"),
          body: json.encode(loginData),
          headers: {
            "Content-type": "application/json",
            "Accept": "application/json",
          });
      final responseData = json.decode(response.body);
      setLoading();
      print(responseData);
      me = responseData["_doc"]["username"];
      currentUser = responseData["_doc"];
      // me.add(User(responseData["_doc"]["username"], responseData["_doc"]["_id"]));

      if (responseData["role"] == "doctor") {
        doctordInfo = responseData["_doc"];
      }
      print(responseData["_doc"]);
      return {"role": responseData["role"], "user": responseData["_doc"]};
    } catch (e) {
      print(e);
      return e;
    }
  }
}
