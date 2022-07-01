import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../utils/helpers.dart';

class PatientProvider extends ChangeNotifier {
  Future doctors() async {
    try {
      final response = await http
          .get(Uri.parse("${Helpers.url}/patients/doctorsList"), headers: {
        "Content-type": "application/json",
        "Accept": "application/json",
      });
      final data = json.decode(response.body);
      print(data["_docs"]);
    } catch (e) {
      return e;
    }
  }
}
