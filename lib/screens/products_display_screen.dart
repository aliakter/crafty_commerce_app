import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:am_ecommerce_app/provider/product_provider.dart';
import 'package:am_ecommerce_app/utility/responsive.dart';
import 'package:am_ecommerce_app/utility/size_config.dart';
import 'package:am_ecommerce_app/widgets/product_item.dart';

class ProductDisplayScreen extends StatelessWidget {
  final bool isFavorite;
  const ProductDisplayScreen({
    Key? key,
    required this.isFavorite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    final productListData = Provider.of<ProductProvider>(context);
    final allProduct = productListData.fetchAndSetProducts();
    final products = isFavorite
        ? productListData.favoriteProductItems
        : productListData.productItems;
    return GridView.builder(
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: Responsive.isMobile(context)
            ? .6
            : Responsive.isTab(context)
                ? .7
                : .6,
      ),
      itemBuilder: (context, index) {
        return ChangeNotifierProvider.value(
          value: products[index],
          child: ProductItem(),
        );
      },
    );
  }
}
