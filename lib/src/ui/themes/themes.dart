import 'package:flutter/material.dart';

const double kHorizontalGlobalMargin = 40.0;
const EdgeInsets kHorizontalGlobalPadding =EdgeInsets.symmetric(horizontal: 12.0);
const EdgeInsets kVerticalGlobalPadding = EdgeInsets.symmetric(vertical: 30.0);

const double kTextSizeNavigationBar = 30.0;
const double kElevationNavigationBar = 0.0;
const double kHeightNavigationBar = 86.0;

class WanderlustColors {
  const WanderlustColors();

  static const Color loginGradientStart = const Color(0xFFfbab66);
  static const Color loginGradientEnd = const Color(0xFFf7418c);
  static const Color loginBlueSky = const Color(0xFF779ca5);
  static const Color backLoginColor = Color(0xFF6f6c7d);

  static const primaryGradient = const LinearGradient(
    colors: const [loginGradientStart, loginGradientEnd],
    stops: const [0.0, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static Color darkLoginColor = Color(0xFF32424f);
  static Color lightGreyColor = Color(0xFFfafafa);
  static Color wanderlustBlack = Colors.black;
  static Color wanderlustWhite = Colors.white;
  
  // Ancient globe colors
  static const wanderlustLightBrown = Color(0xff5e4725);
  static const wanderlustVeryLightBrown = Color(0xffc0985d);
  static const wanderlustRed = Color(0xffa57461);
  static const wanderlustGreen = Color(0xff56655b);
  static const wanderlustDarkBrown = Color(0xff3a2206);

  static List<Color> kitGradients = [
    Colors.black87,
    Colors.blueGrey.shade900,
  ];
}