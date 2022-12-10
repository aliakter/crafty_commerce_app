import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:am_ecommerce_app/provider/cart_provider.dart';
import 'package:am_ecommerce_app/provider/order_provider.dart';
import 'package:am_ecommerce_app/provider/product_provider.dart';
import 'package:am_ecommerce_app/routes/route_provider.dart';

bool? isViewed;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences pref = await SharedPreferences.getInstance();
  isViewed = pref.getBool('introductionScreenData') ?? false;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProductProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => OrderProvider(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Crafty Commerce',
        initialRoute: '/',
        onGenerateRoute: RouteProvider.RouteName,
      ),
    );
  }
}
