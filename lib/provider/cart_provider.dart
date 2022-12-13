import 'package:flutter/material.dart';
import 'package:am_ecommerce_app/models/cart.dart';

class CartProvider with ChangeNotifier {
  Map<String, Cart> _items = {};

  Map<String, Cart> get items {
    return {..._items};
  }

  int get itemCount {
    return _items == null ? 0 : _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItems) {
      total += cartItems.price * cartItems.quantity;
    });
    return total;
  }

  void addItem(
    String productId,
    double price,
    String productName,
    String imagePath,
  ) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (existingCart) => Cart(
            id: existingCart.id,
            productName: existingCart.productName,
            imagePath: existingCart.imagePath,
            price: existingCart.price,
            quantity: existingCart.quantity + 1),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => Cart(
          id: DateTime.now().toString(),
          productName: productName,
          imagePath: imagePath,
          price: price,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }

  void removeSingleItem(String productId, {String? workType}) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId]!.quantity >= 1) {
      _items.update(
        productId,
        (existingCart) => Cart(
            id: existingCart.id,
            productName: existingCart.productName,
            imagePath: existingCart.imagePath,
            price: existingCart.price,
            quantity: workType == 'add'
                ? existingCart.quantity + 1
                : existingCart.quantity - 1),
      );
    } else {
      _items[productId]!.quantity > 1 ? _items.remove(productId) : null;
    }
    notifyListeners();
  }
}
