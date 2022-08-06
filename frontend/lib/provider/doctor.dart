import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:frontend/utils/helpers.dart';
import 'package:http/http.dart' as http;

class DoctorProvider extends ChangeNotifier {
  List _posts = [];

  Future fetchDoctorPosts(String token) async {
    try {
      var url = Uri.parse('$serverUrl/api/user/getMyPosts');

      var res =
          await http.get(url, headers: {"authorization": "Bearer $token"});
      notifyListeners();
      _posts = json.decode(res.body);
    } catch (e) {
      print(e);
    }
  }

  Future deletePost(String id) async {
    try {
      var url = Uri.parse('$serverUrl/api/user/deletePost');

      var res = await http.post(url,
          headers: {
            "Content-type": "application/json",
            "Accept": "application/json",
          },
          body: json.encode({"id": id}));
      print(json.decode(res.body));
      notifyListeners();
      // _posts = json.decode(res.body);
    } catch (e) {
      print(e);
    }
  }

  Future verifyUserIdentity(String id, String password, String type) async {
    var url = Uri.parse('$serverUrl/api/user/confirmPassword');

    try {
      var res = await http.post(
        url,
        headers: {
          "Content-type": "application/json",
          "Accept": "application/json",
        },
        body: json.encode(
          {
            "id": id,
            "password": password,
            "type": type,
          },
        ),
      );
      var returnedValue;
      if (res.body == "success") {
        returnedValue = "success";
      } else {
        returnedValue = "error";
      }

      return returnedValue;
    } catch (e) {}

    notifyListeners();
  }

  Future updateUserInfo(String name, String password, String type,
      String username, String id) async {
    var url = Uri.parse('$serverUrl/api/user/updateUserInfo');

    try {
      var res = await http.post(
        url,
        headers: {
          "Content-type": "application/json",
          "Accept": "application/json",
        },
        body: json.encode(
          {
            "id": id,
            "password": password,
            "type": type,
            "username": username,
            "name": name
          },
        ),
      );
      if (res.body == 'success') {
        return "success";
      } else {
        return "error";
      }
    } catch (e) {}

    notifyListeners();
  }

  List get doctorPosts {
    return [..._posts];
  }
}
