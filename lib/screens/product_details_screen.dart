import 'package:am_ecommerce_app/provider/cart_provider.dart';
import 'package:am_ecommerce_app/provider/product_provider.dart';
import 'package:am_ecommerce_app/utility/app_properties.dart';
import 'package:am_ecommerce_app/utility/responsive.dart';
import 'package:am_ecommerce_app/utility/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatelessWidget {
  String productId;
  ProductDetailScreen({
    Key? key,
    required this.productId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<ProductProvider>(context, listen: false)
        .getProductById(productId);
    final productList = Provider.of<ProductProvider>(context, listen: false)
        .productItems
        .toList();
    final cart = Provider.of<CartProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: SizedBox(
                height: Responsive.isMobile(context)
                    ? SizeConfig.screenHeight * .3
                    : SizeConfig.screenHeight * .5,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                          gradient: RadialGradient(
                            colors: [
                              Colors.purple,
                              Colors.cyan,
                            ],
                            focal: Alignment(0.0, 0.0),
                            stops: [0.4, 1.0],
                            focalRadius: .5,
                            center: Alignment(-0.8, -0.6),
                          ),
                        ),
                        child: Image.asset(
                          product.imagePath!,
                          width: 150,
                          height: 150,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0.0,
                      child: SizedBox(
                        width: SizeConfig.screenWidth * .5,
                        height: Responsive.isMobile(context)
                            ? SizeConfig.screenHeight * .28
                            : SizeConfig.screenHeight * .5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 20,
                                left: 20,
                                bottom: 15,
                              ),
                              child: Text(
                                product.name!,
                                style: titleStyle,
                                maxLines: 3,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            ElevatedButton.icon(
                              icon: const Icon(
                                Icons.shopping_bag_outlined,
                                color: Colors.yellow,
                                size: 20.0,
                              ),
                              label: const Text('Buy Now'),
                              onPressed: () {
                                cart.addItem(product.id!, product.price!,
                                    product.name!, product.imagePath!);
                                Navigator.pushNamed(context, '/cart');
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                            ),
                            ElevatedButton.icon(
                              icon: const Icon(
                                Icons.shopping_cart_outlined,
                                color: Colors.yellow,
                                size: 20.0,
                              ),
                              label: const Text('Add To Cart'),
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
                                // show popup that item has been added
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: const Text('Added item to cart'),
                                    duration: const Duration(seconds: 2),
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
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 120,
                  height: 40,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 1,
                    ),
                  ),
                  child: FittedBox(
                    child: Text(
                      'BDT ' + product.price.toString(),
                      style: titleStyle,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Text(product.rating.toString()),
                    const Icon(Icons.star_border_outlined),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Text(
                        'DETAILS',
                        style: TextStyle(
                          fontSize: 20,
                          letterSpacing: 5,
                          color: Colors.pink,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      product.description!,
                      style: descriptionStyle.copyWith(
                        letterSpacing: .5,
                        fontSize: 15,
                      ),
                      textAlign: TextAlign.justify,
                      maxLines: 8,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Text(
                        'More Products',
                        style: TextStyle(
                          fontSize: 18,
                          letterSpacing: 5,
                          color: Colors.pink,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Responsive.isMobile(context)
                        ? SizeConfig.screenHeight * .3
                        : SizeConfig.screenHeight * .6,
                    child: ListView.builder(
                      itemCount: productList.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(16),
                          child: InkWell(
                            onTap: () {
                              Navigator.popAndPushNamed(
                                context,
                                '/product-detail',
                                arguments: productList[index].id,
                              );
                            },
                            child: Stack(
                              children: [
                                Container(
                                  width: Responsive.isMobile(context)
                                      ? SizeConfig.screenWidth * .45
                                      : SizeConfig.screenWidth * .35,
                                  height: Responsive.isMobile(context)
                                      ? SizeConfig.screenHeight * .3
                                      : SizeConfig.screenHeight * .5,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                    gradient: RadialGradient(
                                      colors: [
                                        Colors.green,
                                        Colors.cyan,
                                      ],
                                      focal: Alignment(0.0, 0.0),
                                      stops: [0.4, 1.0],
                                      focalRadius: .5,
                                      center: Alignment(0.8, 0.6),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 15,
                                        left: 15,
                                        bottom: 45,
                                        right: 45),
                                    child: Image.asset(
                                      productList[index].imagePath!,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: Responsive.isMobile(context) ? 5 : 15,
                                  right: Responsive.isMobile(context) ? 5 : 10,
                                  child: SizedBox(
                                    width: SizeConfig.screenWidth * .25,
                                    height: SizeConfig.screenHeight * .08,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          productList[index].name!,
                                          style: pdescriptionStyle,
                                          textAlign: TextAlign.right,
                                          maxLines: 2,
                                        ),
                                        Text(
                                          'BDT ' +
                                              productList[index]
                                                  .price
                                                  .toString(),
                                          style: pdescriptionStyle,
                                          maxLines: 2,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
