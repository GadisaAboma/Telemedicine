import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend/appointment/set_appointment.dart';
import 'package:http/http.dart' as http;
import '../utils/helpers.dart';

class PatientProvider extends ChangeNotifier {
  List _places = [];

  Future doctors() async {
    try {
      final response = await http
          .get(Uri.parse("$serverUrl/patients/doctorsList"), headers: {
        "Content-type": "application/json",
        "Accept": "application/json",
      });
      final data = json.decode(response.body);
      print(data["_docs"]);
    } catch (e) {
      return e;
    }
  }

  dynamic patientData;
  Future patient(String username) async {
    try {
      final response =
          await http.post(Uri.parse("$serverUrl/api/patients/patient"),
              headers: {
                "Content-type": "application/json",
                "Accept": "application/json",
              },
              body: json.encode({"username": username}));
      final data = json.decode(response.body);
      // (data["_docs"]);
      patientData = data;
      print(patientData);
      notifyListeners();
      return data;
    } catch (e) {
      print("error   " + e.toString());
      // return e;
    }
  }

  Future searchDoctor(String username) async {
    try {
      final response = await http.post(
          Uri.parse("$serverUrl/api/patients/searchDoctor"),
          body: (json.encode({"username": username})),
          headers: {
            "Content-type": "application/json",
            "Accept": "application/json",
          });
      final data = json.decode(response.body);
      notifyListeners();
      return data;
    } catch (e) {
      return e;
    }
  }

  Future searchPatient(String username) async {
    try {
      final response = await http.post(
          Uri.parse("$serverUrl/api/doctors/searchPatient"),
          body: (json.encode({"username": username})),
          headers: {
            "Content-type": "application/json",
            "Accept": "application/json",
          });
      List data = json.decode(response.body);

      notifyListeners();
      return data;
    } catch (e) {
      return e;
    }
  }

  Future setAppointment(
      String id, var date, String doctorId, String description) async {
    print("desc   " + description);
    try {
      final response = await http.post(
          Uri.parse("$serverUrl/api/doctors/setAppointment"),
          body: (json.encode({
            "id": id,
            "date": date,
            "description": description,
            "doctorId": doctorId
          })),
          headers: {
            "Content-type": "application/json",
            "Accept": "application/json",
          });
      final data = json.decode(response.body);

      notifyListeners();
      return data;
    } catch (e) {
      print(e);
      return e;
    }
  }

  Future fetchAppointment(String id, String userType) async {
    try {
      final response = await http.post(
          Uri.parse("$serverUrl/api/user/fetchAppointments"),
          body: (json.encode({"id": id, "userType": userType})),
          headers: {
            "Content-type": "application/json",
            "Accept": "application/json",
          });

      print(response.body);
      final data = json.decode(response.body);

      notifyListeners();
      return data;
    } catch (e) {
      print(e);
      return e;
    }
  }

  Future<void> createPlace(
      var description, File image, String doctorName) async {
    var url = Uri.parse('$serverUrl/api/user/createPost');
    try {
      var request = http.MultipartRequest('post', url);
      // request.fields['name'] = name.toString();
      // request.headers['authorization'] = 'Bearer $token';
      request.fields['description'] = description.toString();
      request.fields['doctorName'] = doctorName.toString();
      var img = await http.MultipartFile.fromPath("postImage", image.path);
      request.files.add(img);
      var res = await request.send();
      var response = await http.Response.fromStream(res);
      notifyListeners();
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  Future<void> fetchPosts() async {
    var url = Uri.parse('$serverUrl/api/user/fetchPosts');
    try {
      var res = await http.get(url);
      _places = json.decode(res.body);
      notifyListeners();
    } catch (err) {
      print(err);
    }
  }

  List get places {
    return [..._places];
  }
}
