import 'package:flutter/cupertino.dart';
import '../models/place.dart';

class PlacesProvider extends ChangeNotifier {
  // ignore: prefer_final_fields
  List<Place>  _places =  [
     Place('Gadisa', 'jimma mall', 'jimma city shopping mall', 'p1', 'sdd'),
    Place('Gadisa', 'jimma mall', 'jimma city shopping mall', 'p1', 'sdd'),
  ];

  List<Place> get places {
    return [..._places];
  }
}
