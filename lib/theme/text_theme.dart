import 'package:flutter/material.dart';

class AppTextTheme {
  AppTextTheme._();

  static const fontFamily = 'OpenSans';

  static const TextStyle headlineMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    height: 22 / 18,
    fontWeight: FontWeight.w700,
    color: Color(0xFF222222),
  );

  static const TextStyle headlineSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    height: 22 / 16,
    fontWeight: FontWeight.w700,
    color: Color(0xFF222222),
  );

  static const TextStyle labelSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    height: 20 / 14,
    fontWeight: FontWeight.w400,
    color: Color(0xFF595959),
  );

  static const TextStyle labelSmallBold = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    height: 20 / 14,
    letterSpacing: 0,
    fontWeight: FontWeight.w700,
    color: Color(0xFFFFFFFF),
  );

  static const TextStyle labelMediumBold = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    height: 22 / 16,
    letterSpacing: 0,
    fontWeight: FontWeight.w700,
    color: Color(0xFF222222),
  );

  static const TextStyle labelXSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    height: 16 / 12,
    letterSpacing: 0,
    fontWeight: FontWeight.w400,
    color: Color(0xFF595959),
  );


  static const TextStyle labelXSmallBold = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    height: 16 / 12,
    letterSpacing: 0,
    fontWeight: FontWeight.w700,
    color: Color(0xFF595959),
  );

  static const TextStyle labelXLargeBold = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20,
    height: 24 / 20,
    letterSpacing: 0,
    fontWeight: FontWeight.w700,
    color: Color(0xFF222222),
  );
}
