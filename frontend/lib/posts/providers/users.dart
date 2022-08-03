import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class Users extends ChangeNotifier {
  List _places = [
    /*  User("Gadisa Aboma", "u1", 3, 'image'),
    User("Gemechu Gudisa", "u2", 2, 'image'),
    User("Hirpha Fayisa", "u2", 2, 'image'),
    User("Getinat Sileshi", "u2", 2, 'image'), */
  ];

  List _myPlaces = [];

  Future<void> fetchPlaces() async {
    var url = Uri.parse('http://10.141.221.253:3000/api/user/getallusers');

    try {
      var res = await http.get(url);
      final List extractedData = json.decode(res.body);
      _places = extractedData;
      notifyListeners();
    } catch (err) {
      print(err);
    }
  }

  List get places {
    return [..._places];
  }

  List get myPlaces {
    return [..._myPlaces];
  }

  Future<void> fetchMyPlaces(String token) async {
    var url = Uri.parse('http://10.141.221.253:3000/api/user/myplaces');
    try {
      var res =
          await http.get(url, headers: {"authorization": "Bearer $token"});
      _myPlaces = json.decode(res.body);
      notifyListeners();
    } catch (error) {}
  }

  Future<void> changeProfile(File image) async {
    print("coming");
  }

  Future<void> createPlace(
      var name, var description, File image, String token) async {
    var url = Uri.parse('http://10.141.221.253:3000/api/user/createplace');
    try {
      var request = http.MultipartRequest('post', url);
      request.fields['name'] = name.toString();
      request.headers['authorization'] = 'Bearer $token';
      request.fields['description'] = description.toString();
      var img = await http.MultipartFile.fromPath("placeImage", image.path);
      request.files.add(img);
      var res = await request.send();
      var response = await http.Response.fromStream(res);
      notifyListeners();
    } catch (err) {
      print(err);
      rethrow;
    }
  }
}
