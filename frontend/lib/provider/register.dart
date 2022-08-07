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
  String loggedName = '';
  String userToken = '';
  String userName = '';
  String userPassword = '';

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

  Future register(
      String name,
      String username,
      String password,
      String accountType,
      String specializedIn,
      String gender,
      File? image) async {
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

    var response;
    try {
      final String routeType = accountType == "patient"
          ? "patients/registerPatient"
          : "doctors/registerDoctor";

      var url = Uri.parse('$serverUrl/api/$routeType');
      var request = http.MultipartRequest('post', url);
      if (accountType != 'doctor') {
        // request.fields['name'] = name.toString();
        // request.fields['username'] = username.toString();
        // request.fields['gender'] = gender.toString();
        // request.fields['password'] = password.toString();

        response = await http.post(Uri.parse("$serverUrl/api/$routeType"),
            body: json.encode(jsonData),
            headers: {
              "Content-type": "application/json",
              "Accept": "application/json",
            });
      } else {
        request.fields['name'] = name.toString();
        request.fields['username'] = username.toString();
        request.fields['gender'] = gender.toString();
        request.fields['password'] = password.toString();
        request.fields['specializedIn'] = specializedIn.toString();
        var img = await http.MultipartFile.fromPath("doctorId", image!.path);
        request.files.add(img);
        var res = await request.send();
        response = await http.Response.fromStream(res);
      }

      // final response = await http.post(Uri.parse("$serverUrl/api/$routeType"),
      //     body: json.encode(jsonData),
      //     headers: {
      //       "Content-type": "application/json",
      //       "Accept": "application/json",
      //     });

      final responseData = json.decode(response.body);
      if (response.statusCode == 400) {
        return Future.error(responseData["error"]);
      }
      currentUser = responseData;
      if (responseData["role"] == "doctor") {
        doctordInfo = responseData["_doc"];
        loggedId = responseData['_doc']["_id"];
        loggedName = responseData['_doc']['name'];
      } else {
        loggedId = responseData['_id'];
        loggedName = responseData['name'];
      }

      print(responseData);

      userType = accountType + 's';
      setLoading();
      notifyListeners();
      return "success";
    } on SocketException catch (e) {
      print(e.message);
      return Future.error(e.message);
    } catch (e) {
      print(e);
      throw Exception("Something wrong");
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

  Future<void> approveDoctor(String id) async {
    try {
      final response = await http.post(
          Uri.parse("$serverUrl/api/admin/approve"),
          body: json.encode({"id": id}),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
          });

      unApprovedDoctorsList = json.decode(response.body);

      notifyListeners();
      print("respinse: " + json.decode(response.body));
      return json.decode(response.body);
    } catch (e) {
      unApprovedDoctorsList = [
        null,
      ];
      notifyListeners();
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
      loggedName = responseData['_doc']['name'];
      userName = responseData["_doc"]['username'];
      userToken = responseData['token'];
      userPassword = responseData["_doc"]['password'];

      return {"role": responseData["role"], "user": responseData["_doc"]};
    } on SocketException catch (e) {
      print(e.message);
      return Future.error(e.message);
    } catch (e) {
      return Future.error("something is wrong");
    }
  }

  String get loggedUserId {
    return loggedId;
  }

  String get loggedUserType {
    return userType;
  }

  String get loggedUserName {
    return loggedName;
  }

  String get username {
    return userName;
  }

  String get passWord {
    return userPassword;
  }

  String get token {
    return userToken;
  }
}
