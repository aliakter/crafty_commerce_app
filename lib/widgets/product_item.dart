import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:am_ecommerce_app/models/product.dart';
import 'package:am_ecommerce_app/provider/cart_provider.dart';
import 'package:am_ecommerce_app/utility/app_properties.dart';
import 'package:am_ecommerce_app/utility/responsive.dart';
import 'package:am_ecommerce_app/utility/size_config.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Consumer<Product>(
      builder: (context, product, _) {
        return InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              '/product_detail',
              arguments: product.id,
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(3),
            child: Card(
              elevation: 10,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.lightGreenAccent,
                            offset: const Offset(0.0, 0.0),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        child: AspectRatio(
                          aspectRatio: 1.28,
                          child: Image.asset(product.imagePath!),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0.0,
                    child: Container(
                      width: SizeConfig.screenWidth * .5,
                      height: Responsive.isMobile(context)
                          ? SizeConfig.screenWidth * .4
                          : SizeConfig.screenWidth * .3,
                      decoration: BoxDecoration(
                        color: Colors.indigo,
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.purple,
                            width: 8,
                          ),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: Text(
                              product.name!,
                              style: titleStyle,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                'BDT:  ' + product.price.toString(),
                                style: titleStyle,
                              ),
                              Row(
                                children: [
                                  Text(
                                    product.rating.toString(),
                                    style: titleStyle,
                                  ),
                                  const Icon(
                                    Icons.star,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              IconButton(
                                onPressed: () {
                                  product.toggleFavoriteStatus();
                                },
                                icon: Icon(
                                  product.isFavorite
                                      ? Icons.favorite
                                      : Icons.favorite_border_outlined,
                                  color: Colors.red,
                                ),
                              ),
                              ElevatedButton.icon(
                                icon: const Icon(
                                  Icons.shopping_cart,
                                  color: Colors.yellow,
                                  size: 20.0,
                                ),
                                label: const Text(
                                  'Add To Cart',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                ),
                                onPressed: () {
                                  cart.addItem(product.id!, product.price!,
                                      product.name!, product.imagePath!);
                                  ScaffoldMessenger.of(context)
                                      .hideCurrentSnackBar();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: const Text('Added item to cart'),
                                      duration: const Duration(seconds: 3),
                                      action: SnackBarAction(
                                        label: 'UNDO',
                                        textColor: Colors.red,
                                        onPressed: () {
                                          cart.removeSingleItem(product.id!);
                                        },
                                      ),
                                    ),
                                  );
                                  ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
