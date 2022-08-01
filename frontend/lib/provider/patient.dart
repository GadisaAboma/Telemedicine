import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/appointment/set_appointment.dart';
import 'package:http/http.dart' as http;
import '../utils/helpers.dart';

class PatientProvider extends ChangeNotifier {
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
      final data = json.decode(response.body);

      notifyListeners();
      return data;
    } catch (e) {
      return e;
    }
  }

  Future setAppointment(String id, var date, var description) async {
    print(id);
    print(date);
    try {
      final response = await http.post(
          Uri.parse("$serverUrl/api/doctors/setAppointment"),
          body: (json
              .encode({"id": id, "date": date, "description": description})),
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
    print("coming");
    try {
      final response = await http.post(
          Uri.parse("$serverUrl/api/$userType/setAppointment"),
          body: (json.encode({"id": id})),
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
}
