import 'package:flutter/material.dart';
import 'AppColor.dart';

ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    backgroundColor: AppColor.bodyColor,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColor.textColor,
      elevation: 0.0,
      brightness: Brightness.light,
      iconTheme: IconThemeData(color: AppColor.bodyColor, size: 25.0),
    ),
    scaffoldBackgroundColor: AppColor.bodyColor,
    hintColor: AppColor.textColor,
    primaryColorLight: AppColor.buttonBackgroundColor,
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: AppColor.lightTextColor,
      selectionHandleColor: AppColor.textColor,
    ),
    textTheme: TextTheme(
      headline1: TextStyle(
        color: AppColor.textColor,
        fontSize: 40.0,
        fontWeight: FontWeight.bold,
      ),
      headline2: TextStyle(
        color: AppColor.textColor,
        fontSize: 20.0,
        fontWeight: FontWeight.w500,
      ),
      headline3: TextStyle(
        color: AppColor.textColor,
        fontSize: 20.0,
      ),
      headline4: TextStyle(
        color: AppColor.textColor,
        fontSize: 17.0,
      ),
    ),
    buttonTheme: ButtonThemeData(
      textTheme: ButtonTextTheme.primary,
      buttonColor: AppColor.textColor,
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.pressed))
            return AppColor.bodyColor.withOpacity(0.5);
          return null;
        }),
      ),
    ));
