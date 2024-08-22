import 'package:flutter/material.dart';

class TSizes {
  TSizes._();

  static double _screenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static double _screenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  // Padding and Margins
  static double xs(BuildContext context) => _screenWidth(context) * 0.01;
  static double sm(BuildContext context) => _screenWidth(context) * 0.02;
  static double md(BuildContext context) => _screenWidth(context) * 0.04;
  static double lg(BuildContext context) => _screenWidth(context) * 0.06;
  static double xl(BuildContext context) => _screenWidth(context) * 0.08;

  // Icon Sizes
  static double iconXs(BuildContext context) => _screenWidth(context) * 0.03;
  static double iconSm(BuildContext context) => _screenWidth(context) * 0.04;
  static double iconMd(BuildContext context) => _screenWidth(context) * 0.06;
  static double iconLg(BuildContext context) => _screenWidth(context) * 0.08;

  // Font Sizes
  static double fontSizeSm(BuildContext context) => _screenWidth(context) * 0.035;
  static double fontSizeMd(BuildContext context) => _screenWidth(context) * 0.04;
  static double fontSizeLg(BuildContext context) => _screenWidth(context) * 0.045;
  static double fontSizeXl(BuildContext context) => _screenWidth(context) * 0.06;

  // AppBar
  static double appBarHeight(BuildContext context) => _screenHeight(context) * 0.07;

  // Space Between Sections
  static double defaultSpace(BuildContext context) => _screenWidth(context) * 0.06;
  static double spaceBtwnItems(BuildContext context) => _screenWidth(context) * 0.04;
  static double spaceBtwnSections(BuildContext context) => _screenWidth(context) * 0.08;

  // Border Radius
  static double borderRadiusSm(BuildContext context) => _screenWidth(context) * 0.01;
  static double borderRadiusMd(BuildContext context) => _screenWidth(context) * 0.02;
  static double borderRadiusLg(BuildContext context) => _screenWidth(context) * 0.03;

  // Divider Height
  static double dividerHeight(BuildContext context) => _screenHeight(context) * 0.001;

  // Input Field
  static double inputFieldsRadius(BuildContext context) => _screenWidth(context) * 0.03;
  static double spaceBtwnInputFields(BuildContext context) => _screenWidth(context) * 0.04;

  // Loading Size
  static double loadingSize(BuildContext context) => _screenWidth(context) * 0.09;

  // Grid View Spacing
  static double gridViewSpacing(BuildContext context) => _screenWidth(context) * 0.04;
}
