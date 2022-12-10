import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:am_ecommerce_app/models/cart.dart';
import 'package:am_ecommerce_app/provider/cart_provider.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String productName;
  final String imagePath;
  const CartItem({
    Key? key,
    required this.id,
    required this.productId,
    required this.price,
    required this.quantity,
    required this.productName,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Are you sure?'),
            content:
                const Text('Do you want to remove this item from the cart'),
            actions: [
              OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: const Text('No'),
              ),
              OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: const Text('Yes'),
              ),
            ],
          ),
        );
      },
      onDismissed: (direction) {
        Provider.of<CartProvider>(context, listen: false).removeItem(productId);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        child: Card(
          elevation: 10,
          shadowColor: Colors.deepOrange,
          child: ListTile(
            leading: Container(
              width: 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imagePath),
                ),
                border: const Border(
                  right: BorderSide(
                    color: Colors.deepOrange,
                    width: 3,
                  ),
                ),
              ),
            ),
            title: Text(productName),
            subtitle: Text(
              'Total: ${(price * quantity)} BDT',
            ),
            contentPadding: const EdgeInsets.all(10),
            trailing: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: SizedBox(
                width: 70,
                child: Consumer<CartProvider>(builder: (context, cartData, _) {
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        child: const Icon(Icons.remove, size: 15),
                        onTap: () {
                          quantity > 1
                              ? cartData.removeSingleItem(productId)
                              : null;
                        },
                      ),
                      Text(quantity.toString()),
                      InkWell(
                        child: const Icon(Icons.add, size: 15),
                        onTap: () {
                          cartData.removeSingleItem(productId, workType: 'add');
                        },
                      ),
                    ],
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
