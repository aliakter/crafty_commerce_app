import 'package:flutter/cupertino.dart';

class Cart with ChangeNotifier {
  final String id;
  final String productName;
  final String imagePath;
  final int quantity;
  final double price;

  Cart({
    required this.id,
    required this.productName,
    required this.imagePath,
    required this.price,
    required this.quantity,
  });
}
