import 'package:am_ecommerce_app/provider/order_provider.dart';
import 'package:am_ecommerce_app/widgets/order_items.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Orders'),
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
        itemCount: orderProvider.orders.length,
        itemBuilder: (context, index) => OrderItem(
          order: orderProvider.orders[index],
        ),
      ),
    );
  }
}
