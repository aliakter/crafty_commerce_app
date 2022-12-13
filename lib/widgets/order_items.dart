import 'dart:math';
import 'package:flutter/material.dart';
import 'package:am_ecommerce_app/models/order.dart';
import 'package:intl/intl.dart';
import 'package:am_ecommerce_app/utility/app_properties.dart';

class OrderItem extends StatefulWidget {
  final Order order;
  const OrderItem({Key? key, required this.order}) : super(key: key);

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            tileColor: Colors.blue,
            isThreeLine: true,
            title: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Order Id : ${widget.order.id}',
                  style: titleStyle.copyWith(color: Colors.white),
                ),
                Text(
                  'Payable Amount : ${widget.order.amount} BDT',
                  style: titleStyle.copyWith(color: Colors.white),
                ),
              ],
            ),
            subtitle: Text(
              'Date : ' +
                  DateFormat('dd/MM/yyyy hh:mm').format(widget.order.dateTime),
              style: titleStyle.copyWith(color: Colors.white),
            ),
            trailing: IconButton(
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
            ),
          ),
          if (_expanded)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              height: widget.order.products.length > 1 ? 200 : 100,
              child: ListView(
                children: widget.order.products
                    .map(
                      (product) => Card(
                        elevation: 10,
                        shadowColor: Colors.deepOrange,
                        child: ListTile(
                          leading: Container(
                            width: 100,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(product.imagePath),
                              ),
                              border: const Border(
                                right: BorderSide(
                                  color: Colors.deepOrange,
                                  width: 3,
                                ),
                              ),
                            ),
                          ),
                          title: Text(product.productName),
                          subtitle: Text(
                            'Total : ${(product.price * product.quantity)} BDT',
                          ),
                          contentPadding: const EdgeInsets.all(10),
                          trailing:
                              Text(product.quantity.toString() + ' items'),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
        ],
      ),
    );
  }
}
