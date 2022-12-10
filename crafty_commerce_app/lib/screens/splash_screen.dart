import 'package:am_ecommerce_app/main.dart';
import 'package:am_ecommerce_app/utility/size_config.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> opacity;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );
    opacity = Tween<double>(begin: 1.0, end: 0.0).animate(controller)
      ..addListener(
        () {
          setState(() {});
        },
      );
    controller.forward().then(
          (value) => navigateToNextScreen(),
        );
  }

  navigateToNextScreen() {
    Navigator.pushReplacementNamed(
      context,
      isViewed == true ? '/home' : '/introduction',
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: SizeConfig.screenWidth,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bg-4.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                Expanded(
                  child: Opacity(
                    opacity: opacity.value,
                    child: Image.asset(
                      'assets/images/crafty - white.png',
                    ),
                  ),
                ),
                RichText(
                  text: const TextSpan(
                    text: 'Powered By ',
                    style: TextStyle(color: Colors.black),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Ali Akter',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
