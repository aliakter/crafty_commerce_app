import 'package:am_ecommerce_app/utility/size_config.dart';
import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  Widget? mobile;
  Widget? tab;
  Widget? desktop;
  Responsive({
    Key? key,
    this.mobile,
    this.desktop,
    this.tab,
  }) : super(key: key);
  static double smallMobileLimit = 576;
  static double mobileLimit = 768;
  static double tabLimit = 992;
  static double maxTabLimit = 1100;

  static bool isSmallMobile(BuildContext context) =>
      SizeConfig.screenWidth < smallMobileLimit;

  static bool isMobile(BuildContext context) =>
      SizeConfig.screenWidth < mobileLimit;

  static bool isTab(BuildContext context) =>
      SizeConfig.screenWidth > mobileLimit &&
      SizeConfig.screenWidth < maxTabLimit;
  static bool isDesktop(BuildContext context) =>
      SizeConfig.screenWidth > maxTabLimit;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, screen) {
      if (screen.maxWidth < mobileLimit || screen.maxWidth < smallMobileLimit) {
        return mobile!;
      } else if (screen.maxWidth >= mobileLimit &&
          screen.maxWidth <= tabLimit) {
        return tab!;
      } else {
        return desktop!;
      }
    });
  }
}
