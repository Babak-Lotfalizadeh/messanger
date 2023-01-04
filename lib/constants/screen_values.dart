import 'package:flutter/material.dart';

class ScreenValues {
  const ScreenValues._();
  static const String fontFamilyRighteous = "Righteous";
  static const double iconSmall = 20;
  static const double iconNormal = 24;
  static const double iconLarge = 48;
  static const double paddingNormal = 8;
  static const double paddingSmall = paddingNormal * 0.5;
  static const double paddingLarge = paddingNormal * 2;
  static const double paddingXLarge = paddingNormal * 3;
  static const double radiusSmall = radiusNormal * 0.1;
  static const double radiusNormal = 8;
  static const double radiusLarge = radiusNormal * 2;
  static const double radiusXLarge = radiusNormal * 4;
  static const double normalImageSize = 200;
  static const double loginHeaderHeight = 80;
  static const Duration fastAnimation = Duration(milliseconds: 300);
  static const Duration normalAnimation = Duration(seconds: 1);
  static const Color teddyBackground = Color(0xffD6E2EA);
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < mobileConstraints.maxWidth;
  static const mobileConstraints = BoxConstraints(
    maxWidth: 800,
    maxHeight: 800,
  );
  static const webConstraints = BoxConstraints(
    maxWidth: 1000,
    maxHeight: 1000,
  );
}
