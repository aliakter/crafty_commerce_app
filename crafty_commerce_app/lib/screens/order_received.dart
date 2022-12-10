import 'package:am_ecommerce_app/provider/order_provider.dart';
import 'package:am_ecommerce_app/utility/app_properties.dart';
import 'package:am_ecommerce_app/utility/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderReceived extends StatelessWidget {
  var totalAmount;
  OrderReceived({Key? key, required this.totalAmount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Received'),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          Container(
            height: SizeConfig.screenHeight * .4,
            color: Colors.red,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SizedBox(height: 15, width: 15),
                Text(
                  'Waiting for Payment ',
                  style: titleStyle.copyWith(color: Colors.black),
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                      width: 3,
                    ),
                  ),
                  child: Text(
                    'Your order Number is \n ${orderProvider.getOrderId()}',
                    style: titleStyle.copyWith(color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 15, width: 15),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.deepOrange,
                  width: 3,
                ),
              ),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'Please have this amount ready on delivery day.\n',
                  style: titleStyle.copyWith(color: Colors.black),
                  children: [
                    TextSpan(
                      text: 'BDT ${totalAmount}',
                      style: titleStyle,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            width: SizeConfig.screenWidth * .8,
            height: SizeConfig.screenHeight * .25,
            child: Card(
              elevation: 10,
              shadowColor: Colors.deepOrange,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'You can track and manage your order at \n',
                      style: titleStyle.copyWith(color: Colors.black),
                      children: [
                        TextSpan(
                          text: 'Menu > My Orders',
                          style: titleStyle,
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/orders');
                    },
                    child: const Text(
                      'TRACK ORDER',
                    ),
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.orange,
                      textStyle: const TextStyle(
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
