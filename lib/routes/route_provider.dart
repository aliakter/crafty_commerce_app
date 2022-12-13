import 'package:am_ecommerce_app/screens/add_product_screen.dart';
import 'package:am_ecommerce_app/screens/manage_product_screen.dart';
import 'package:am_ecommerce_app/screens/order_received.dart';
import 'package:flutter/material.dart';
import 'package:am_ecommerce_app/screens/cart_screen.dart';
import 'package:am_ecommerce_app/screens/home_screen.dart';
import 'package:am_ecommerce_app/screens/introduction_screen.dart';
import 'package:am_ecommerce_app/screens/order_screen.dart';
import 'package:am_ecommerce_app/screens/product_details_screen.dart';
import 'package:am_ecommerce_app/screens/products_display_screen.dart';
import 'package:am_ecommerce_app/screens/splash_screen.dart';

class RouteProvider {
  static Route<dynamic> RouteName(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
      case '/home':
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );
      case '/introduction':
        return MaterialPageRoute(
          builder: (context) => const IntroductionScreen(),
        );
      case '/products':
        if (args is bool) {
          return MaterialPageRoute(
            builder: (context) => ProductDisplayScreen(
              isFavorite: args,
            ),
          );
        } else {
          return Error();
        }

      case '/product_detail':
        if (args is String) {
          return MaterialPageRoute(
            builder: (context) => ProductDetailScreen(
              productId: args,
            ),
          );
        } else {
          return Error();
        }
      case '/cart':
        return MaterialPageRoute(
          builder: (context) => CartScreen(),
        );
      case '/orders':
        return MaterialPageRoute(
          builder: (context) => OrdersScreen(),
        );

      case '/order-received':
        return MaterialPageRoute(
          builder: (context) => OrderReceived(
            totalAmount: args,
          ),
        );
      case '/manage-product':
        return MaterialPageRoute(
          builder: (context) => ManageProductScreen(),
        );
      case '/add-product':
        return MaterialPageRoute(
          builder: (context) => AddAndEditProductScreen(),
        );

      case '/edit-product':
        return MaterialPageRoute(
          builder: (context) => AddAndEditProductScreen(productId: args),
        );
      default:
        return Error();
    }
  }

  static Route<dynamic> Error() {
    return MaterialPageRoute(
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: Container(
          alignment: Alignment.center,
          child: Image.asset('assets/images/error.png'),
        ),
      ),
    );
  }
}
