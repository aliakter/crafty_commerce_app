import 'package:am_ecommerce_app/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProductItem extends StatelessWidget {
  final String? id;
  final String productName;
  final String imagePath;
  const UserProductItem({
    Key? key,
    required this.id,
    required this.productName,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
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
        contentPadding: const EdgeInsets.all(10),
        trailing: Container(
          width: 100,
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/edit-product', arguments: id);
                },
                icon: Icon(
                  Icons.edit,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              IconButton(
                onPressed: () {
                  Provider.of<ProductProvider>(context, listen: false)
                      .deleteProduct(id!);
                },
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).errorColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
