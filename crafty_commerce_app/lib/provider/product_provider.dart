import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:am_ecommerce_app/models/product.dart';
import 'package:flutter/cupertino.dart';

class ProductProvider with ChangeNotifier {
  List<Product> productList = [
    Product(
      id: 'product-1',
      name: 'Laptop Table',
      imagePath: 'assets/images/product/desk table.png',
      price: 849,
      description:
          "The foldable table made of high-quality thick steel pipe, black brushed sheet",
      rating: 4.9,
      // isFavourite: false,
    ),
    Product(
      id: 'product-2',
      name: 'T-Shirt',
      imagePath: 'assets/images/product/T-shirt.png',
      price: 288,
      description: "Stylish Comfortable jersey T-shirt for Men New Contrast",
      rating: 4.9,
      // isFavourite: false,
    ),
    Product(
      id: 'product-3',
      name: 'TVS Apache RTR 4V',
      imagePath: 'assets/images/product/tvs-apache-rtr-160-4v.png',
      price: 215999,
      description:
          "TVS Motor Company has recently launched its 2022 TVS Apache RTR 160 4V bike in the Indian market",
      rating: 4.9,
      // isFavourite: false,
    ),
    Product(
      id: 'product-4',
      name: 'One & Loafers',
      imagePath: 'assets/images/product/one Loafers.png',
      price: 360,
      description:
          "fairfootwear Relaxo fashionable PVC leather look suede , Made entirely of PVC",
      rating: 4.9,
      // isFavourite: false,
    ),
    Product(
      id: 'product-5',
      name: 'BMW Car',
      imagePath: 'assets/images/product/BMW-8-Series-840i-xDrive.png',
      price: 2140,
      description:
          "The futuristic sports car from BMW uses a 1.5 litre, three cylinder, engine borrowed from new generation Mini Cooper hatchback",
      rating: 4.9,
      // isFavourite: false,
    ),
    Product(
      id: 'product-6',
      name: 'Formal Shirts',
      imagePath: 'assets/images/product/Formal_Shirts.png',
      price: 820,
      description:
          "JENTS CHOICE SMART LOOKING FULL SLEEVE COTTON FORMAL SHIRTS FOR MEN",
      rating: 4.9,
      // isFavourite: false,
    ),
    Product(
      id: 'product-7',
      name: 'Bag',
      imagePath: 'assets/images/product/Bag-removebg-preview.png',
      price: 2670,
      description: "Bag For Boys Small Backpack School bag For Men",
      rating: 4.9,
      // isFavourite: false,
    ),
    Product(
      id: 'product-8',
      name: 'Watch',
      imagePath: 'assets/images/product/analog-watch.png',
      price: 170,
      description: "UJYFJ BMHT NEW IBSSO Leather Analog Watch for Men Brown",
      rating: 4.9,
      // isFavourite: false,
    ),
  ];

  List<Product> get productItems {
    return [...productList];
  }

  List<Product> get favoriteProductItems {
    return productList.where((p) => p.isFavorite).toList();
  }

  get baseUrl => null;

  Future<void> addProduct(Product product) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl + 'product.json'),
        body: json.encode({
          'id': product.name,
          'name': product.name,
          'description': product.description,
          'price': product.price,
          'imagePath': product.imagePath,
          'rating': product.rating,
          'isFavorite': product.isFavorite,
        }),
      );
      final newProduct = Product(
        id: json.decode(response.body)['name'],
        name: product.name,
        price: product.price,
        imagePath: product.imagePath,
        description: product.description,
        rating: 4.9,
        isFavorite: false,
      );
      productList.add(newProduct);
      notifyListeners();
    } catch (err) {
      throw err;
    }
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final prodIndex = productList.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      await http.patch(
        Uri.parse(baseUrl + 'product/$id.json'),
        body: json.encode(
          {
            'name': newProduct.name,
            'description': newProduct.description,
            'price': newProduct.price,
            'imagePath': newProduct.imagePath,
          },
        ),
      );
      productList[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('not saved');
    }
  }

  Future<void> fetchAndSetProducts([bool filterByUser = false]) async {
    try {
      final response = await http.get(Uri.parse(baseUrl + 'product.json'));
      final extractedData = json.decode(response.body);
      final List<Product> fetchedProduct = [];
      if (extractedData == null) {
        return;
      }
      extractedData.forEach((prodId, prodData) {
        fetchedProduct.add(
          Product(
            id: prodId,
            name: prodData['name'],
            description: prodData['description'],
            price: prodData['price'] as double,
            imagePath: prodData['imagePath'],
          ),
        );
      });
      productList = fetchedProduct;
      notifyListeners();
    } catch (err) {
      rethrow;
    }
  }

  void deleteProduct(String id) {
    final existingProductIndex =
        productList.indexWhere((prod) => prod.id == id);
    Product? existingProduct = productList[existingProductIndex];

    http.delete(Uri.parse(baseUrl + 'product/$id.json')).then((response) {
      existingProduct = null;
    }).catchError((_) {
      productList.insert(existingProductIndex, existingProduct!);
      notifyListeners();
    });

    productList.removeAt(existingProductIndex);
    notifyListeners();
  }

  Product getProductById(String productId) {
    return productList.firstWhere((p) => p.id == productId);
  }
}
