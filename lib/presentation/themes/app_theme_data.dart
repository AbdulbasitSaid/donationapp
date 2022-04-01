import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_color.dart';

class AppThemeData {
  AppThemeData._();

  static TextTheme get _inter => GoogleFonts.interTextTheme();

// textStyles
  static TextStyle? get _mediumLevel1Header => _inter.headline1?.copyWith(
        fontSize: 36,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w500,
        color: AppColor.text90Primary,
      );

  static TextStyle? get headLineSemiBold => _mediumLevel1Header!.copyWith(
        fontWeight: FontWeight.w600,
      );
//
  static TextStyle? get _mediumLevel2Header => _inter.headline2?.copyWith(
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.normal,
        color: AppColor.text90Primary,
        fontSize: 24,
      );

  //
  static TextStyle? get _mediumLevel3Header => _inter.headline2?.copyWith(
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.normal,
        color: AppColor.text90Primary,
        fontSize: 20,
      );
  static TextStyle? get _mediumLevel4Headline => _inter.headline4?.copyWith(
        fontWeight: FontWeight.w600,
        color: AppColor.text90Primary,
        fontSize: 18,
      );

  static TextStyle? get _mediumLevel6Header => _inter.headline6?.copyWith(
        fontWeight: FontWeight.w600,
        fontStyle: FontStyle.normal,
        fontSize: 14,
        color: AppColor.text90Primary,
      );
  static TextStyle? get _buttonText => _inter.button?.copyWith(
        color: Colors.white,
      );
  static TextStyle? get _uiTextBase => _inter.bodyText1?.copyWith(
        color: AppColor.text70Primary,
        fontWeight: FontWeight.w400,
        fontSize: 14,
      );

  static get child => null;

// end textStyles

// textTheme
  static TextTheme appTextTheme() => TextTheme(
      headline1: _mediumLevel1Header,
      headline2: _mediumLevel2Header,
      headline3: _mediumLevel3Header,
      headline4: _mediumLevel4Headline,
      headline6: _mediumLevel6Header,
      subtitle1:
          _uiTextBase!.copyWith(fontSize: 16, fontWeight: FontWeight.w400),
      bodyText1: _uiTextBase,
      bodyText2: _uiTextBase!.copyWith(
        fontWeight: FontWeight.w400,
        fontSize: 14,
      ),
      button: _buttonText,
      caption: _uiTextBase!.copyWith(fontSize: 12));

// end textTheme

  static ThemeData appTheme() {
    return ThemeData(
      primaryColor: AppColor.basePrimary,
      primaryColorLight: AppColor.basePrimary,
      primaryColorDark: AppColor.darkPrimary,
      brightness: Brightness.light,
      secondaryHeaderColor: AppColor.darkSecondaryAmber,
      focusColor: AppColor.basePrimary,
      scaffoldBackgroundColor: Colors.white,
      errorColor: AppColor.baseNegativeSemantic,
      disabledColor: AppColor.lightPrimary,
      hoverColor: AppColor.basePrimary,
      textTheme: appTextTheme(),
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(primary: AppColor.basePrimary)),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: AppColor.basePrimary,
        selectionHandleColor: AppColor.basePrimary,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        focusColor: AppColor.basePrimary,
        hoverColor: AppColor.basePrimary,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColor.basePrimary,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColor.baseNegativeSemantic,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColor.border40Primary,
          ),
        ),
        //  focusedBorder:,
        filled: true,

        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
      ),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: Color.fromRGBO(219, 229, 255, .6),
        titleTextStyle: TextStyle(
          color: AppColor.text90Primary,
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
        iconTheme: IconThemeData(
          color: Color(0xff425A70),
        ),
      ),
      outlinedButtonTheme: appOutlinedButtonThemeData(),
      elevatedButtonTheme: appElevatedButtonThemeData(),
      buttonTheme: const ButtonThemeData(),
      primaryTextTheme: appTextTheme(),
    );
  }

  static ElevatedButtonThemeData appElevatedButtonThemeData() {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: AppColor.basePrimary,
        onSurface: AppColor.darkPrimary,
        minimumSize: const Size(300, 48),
        textStyle: appTextTheme().button,
        elevation: 0,
        visualDensity: const VisualDensity(horizontal: 4, vertical: 2),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
          Radius.circular(8),
        )),
      ).copyWith(),
    );
  }

  static OutlinedButtonThemeData appOutlinedButtonThemeData() {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        primary: AppColor.basePrimary,
        minimumSize: const Size(300, 48),
        elevation: 0,
        side: const BorderSide(width: 2, color: AppColor.basePrimary),
        visualDensity: const VisualDensity(horizontal: 4, vertical: 2),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
          Radius.circular(8),
        )),
      ),
    );
  }
}
