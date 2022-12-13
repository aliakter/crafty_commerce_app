import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:am_ecommerce_app/models/product.dart';
import 'package:am_ecommerce_app/provider/cart_provider.dart';
import 'package:am_ecommerce_app/provider/product_provider.dart';
import 'package:am_ecommerce_app/screens/products_display_screen.dart';
import 'package:am_ecommerce_app/widgets/app_drawer.dart';
import 'package:am_ecommerce_app/widgets/badge.dart';

enum FilterOptions {
  Favorite,
  All,
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var showFavoriteStatus = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Star Cave'),
          backgroundColor: Colors.green,
          actions: [
            Consumer<CartProvider>(
              builder: (_, cartData, child) => Badge(
                child: child as Widget,
                value: cartData.itemCount.toString(),
                color: Colors.red,
              ),
              child: IconButton(
                tooltip: 'Show cart',
                color: Colors.yellow,
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.pushNamed(context, '/cart');
                },
              ),
            ),
            PopupMenuButton(onSelected: (FilterOptions selectValue) {
              setState(() {
                if (selectValue == FilterOptions.Favorite) {
                  showFavoriteStatus = true;
                } else {
                  showFavoriteStatus = false;
                }
              });
            }, itemBuilder: (context) {
              return [
                const PopupMenuItem(
                  child: Text('Favorite only'),
                  value: FilterOptions.Favorite,
                ),
                const PopupMenuItem(
                  child: Text('All'),
                  value: FilterOptions.All,
                ),
              ];
            }),
          ],
        ),
        drawer: AppDrawer(),
        body: ProductDisplayScreen(
          isFavorite: showFavoriteStatus,
        ),
      ),
    );
  }
}
