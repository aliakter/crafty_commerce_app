import 'package:am_ecommerce_app/provider/product_provider.dart';
import 'package:am_ecommerce_app/widgets/app_drawer.dart';
import 'package:am_ecommerce_app/widgets/user_product_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ManageProductScreen extends StatelessWidget {
  const ManageProductScreen({Key? key}) : super(key: key);

  Future<void> _refreshedProducts(BuildContext context) async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        backgroundColor: Colors.deepOrange,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/add-product');
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: _refreshedProducts(context),
        builder: (context, snapshot) {
          return snapshot.connectionState == ConnectionState.waiting
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : RefreshIndicator(
                  onRefresh: () => _refreshedProducts(context),
                  child: Consumer<ProductProvider>(
                    builder: (context, productData, _) =>
                        productData.productList.isEmpty
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(
                                      Icons.error_sharp,
                                      color: Colors.red,
                                      size: 30,
                                    ),
                                    Text(
                                      'No products added by this user!',
                                    ),
                                  ],
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.all(8),
                                child: ListView.builder(
                                  itemCount: productData.productList.length,
                                  itemBuilder: (context, index) => Column(
                                    children: [
                                      UserProductItem(
                                        id: productData.productList[index].id,
                                        productName: productData
                                            .productList[index].name!,
                                        imagePath: productData
                                            .productList[index].imagePath!,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                  ),
                );
        },
      ),
    );
  }
}
