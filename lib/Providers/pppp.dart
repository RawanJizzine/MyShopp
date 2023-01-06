import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  String? imageurl;
  String? title;
  int? price;
  bool isFavorite;
  bool isFruits;
  String? description;
  String? id;
  
  Product({
    
    required this.id,
    required this.imageurl,
    required this.title,
    required this.price,
    required this.description,
    //required this.quantity,
    this.isFruits = false,
    this.isFavorite = false,
  });
  void setFavValue(bool newValue) {
    isFavorite = newValue;
    notifyListeners();
  }

  Future<void> toggleFavoriteStatus(String token, String userId) async {
    //isFavorite = togle;
    final oldStatus = isFavorite;

    isFavorite = !isFavorite;
    notifyListeners();
    final url = Uri.https('flutter-update-8bfba-default-rtdb.firebaseio.com',
        '/userFavorites/$userId/$id.json', {'auth': token});
    try {
      var response = await http.put(
        url,
        body: json.encode(
          isFavorite,
        ),
      );
      if (response.statusCode >= 400) {
        setFavValue(oldStatus);
      }
    } catch (error) {
      setFavValue(oldStatus);
    }
  }

  /* void toggleFruitsStatus() {
    isFruits = !isFruits;
    notifyListeners();
  } */

}
