import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:am_ecommerce_app/provider/cart_provider.dart';
import 'package:am_ecommerce_app/provider/order_provider.dart';
import '../main.dart';
import 'package:am_ecommerce_app/widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(' Your Cart'),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartProvider.items.length,
              itemBuilder: (context, index) => CartItem(
                id: cartProvider.items.values.toList()[index].id,
                productId: cartProvider.items.keys.toList()[index],
                price: cartProvider.items.values.toList()[index].price,
                quantity: cartProvider.items.values.toList()[index].quantity,
                productName:
                    cartProvider.items.values.toList()[index].productName,
                imagePath: cartProvider.items.values.toList()[index].imagePath,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 100,
            child: Card(
              elevation: 10,
              margin: EdgeInsets.all(10),
              shadowColor: Colors.deepOrange,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(),
                  const Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  const Spacer(),
                  Chip(
                    label: Text(
                      'BDT ${cartProvider.totalAmount}',
                      style: const TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  OrderButton(
                    cartProvider: cartProvider,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  final CartProvider cartProvider;

  const OrderButton({
    Key? key,
    required this.cartProvider,
  }) : super(key: key);

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);
    return OutlinedButton(
      onPressed: (widget.cartProvider.totalAmount <= 0 || _isLoading)
          ? null
          : () {
              setState(() {
                _isLoading = true;
                var totalAmountHolder = widget.cartProvider.totalAmount;
                orderProvider.addOrder(
                  widget.cartProvider.items.values.toList(),
                  widget.cartProvider.totalAmount,
                );
                widget.cartProvider.clear();
                Timer(const Duration(milliseconds: 1200), () {
                  Navigator.pushReplacementNamed(
                    context,
                    '/order-received',
                    arguments: totalAmountHolder,
                  );
                });
              });
              _isLoading = false;
            },
      child: _isLoading
          ? const CircularProgressIndicator()
          : const Text('Order Now'),
      style: OutlinedButton.styleFrom(
        onSurface: Theme.of(context).primaryColor,
      ),
    );
  }
}
