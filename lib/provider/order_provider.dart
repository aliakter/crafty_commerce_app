import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:am_ecommerce_app/main.dart';
import 'package:am_ecommerce_app/models/cart.dart';
import 'package:am_ecommerce_app/models/order.dart';
import 'dart:math';

class OrderProvider with ChangeNotifier {
  int orderId = 0;
  List<Order> _orders = [];
  List<Order> get orders {
    return [..._orders];
  }

  void addOrder(List<Cart> cartProducts, double total) {
    final timeStamp = DateTime.now();
    orderId = (Random().nextInt(10001) + 1000);
    _orders.insert(
      0,
      Order(
        id: orderId.toString(),
        amount: total,
        dateTime: timeStamp,
        products: cartProducts,
      ),
    );

    notifyListeners();
  }

  int getOrderId() {
    return orderId;
  }
}
