import 'dart:ui';

import 'package:flutter/painting.dart';

class AppColor {
  AppColor._();

//  primary colors
//
  static const Color lightestPrimary = Color(0xffF5F8FF);
  static const Color lightPrimary = Color(0xffD6E1FF);
  static const Color basePrimary = Color(0xff2962FF);
  static const Color darkPrimary = Color(0xff1B41AA);

//
  static const Color bg10Primary = Color(0xffFAFAFA);
  static const Color bg20Primary = Color(0xffF5F6F7);
  static const Color border30Primary = Color(0xffEDF0F2);
  static const Color border40Primary = Color(0xffE4E7EB);
  static const Color border50Primary = Color(0xffC4CBD4);
  static const Color text70Primary = Color(0xff66788A);
  static const Color baseText80Primary = Color(0xff425A70);
  static const Color text90Primary = Color(0xff234361);

//
//  end primary colors

// secondary colors
//
  static const Color lightestSecondaryGreen = Color(0xffF6FEFA);
  static const Color lightSecondaryGreen = Color(0xffD0FBE6);
  static const Color baseSecondaryGreen = Color(0xff01E575);
  static const Color darkSecondaryGreen = Color(0xff00994F);

//
//
  static const Color lightestSecondaryAmber = Color(0xffFFFDF5);
  static const Color lightSecondaryAmber = Color(0xffFFF3CC);
  static const Color baseSecondaryAmber = Color(0xffFFC400);
  static const Color darkSecondaryAmber = Color(0xffAA8300);

//
// end secondary colors
// semantic colors
//
  static const Color lightestNegativeSemantic = Color(0xffFFF5F5);
  static const Color lightNegativeSemantic = Color(0xffFFD1D1);
  static const Color baseNegativeSemantic = Color(0xffFF0000);
  static const Color darkNegativeSemantic = Color(0xffB30000);

//
//
  static const Color lightestAlertSemantic = Color(0xffFFFAF0);
  static const Color lightAlertSemantic = Color(0xffFFEECC);
  static const Color baseAlertSemantic = Color(0xffEB9D00);
  static const Color darkAlertSemantic = Color(0xffB37800);

//
//
  static const Color lightestPositiveSemantic = Color(0xffF0FFF6);
  static const Color lightPositiveSemantic = Color(0xffC2FFDB);
  static const Color basePositiveSemantic = Color(0xff00DB5B);
  static const Color darkPositiveSemantic = Color(0xff00A846);

//
// end semantic colors
// gradients
  static const Gradient appBackground = LinearGradient(
    colors: [
      Color.fromRGBO(219, 229, 255, 0.6),
      Color.fromRGBO(213, 251, 232, 0.48),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
// end gradients

}
