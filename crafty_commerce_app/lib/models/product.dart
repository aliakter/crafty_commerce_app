import 'package:flutter/cupertino.dart';

class Product with ChangeNotifier {
  String? id;
  String? name;
  String? imagePath;
  double? price;
  String? description;
  double? rating;
  bool isFavorite;
  Product({
    this.id,
    this.name,
    this.imagePath,
    this.price,
    this.description,
    this.rating,
    this.isFavorite = false,
  });

  void toggleFavoriteStatus() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
