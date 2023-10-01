import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
MaterialColor PrimaryMaterialColor = const MaterialColor(
  4291565220,
  <int, Color>{
    50: Color.fromRGBO(
      204,
      22,
      164,
      .1,
    ),
    100: Color.fromRGBO(
      204,
      22,
      164,
      .2,
    ),
    200: Color.fromRGBO(
      204,
      22,
      164,
      .3,
    ),
    300: Color.fromRGBO(
      204,
      22,
      164,
      .4,
    ),
    400: Color.fromRGBO(
      204,
      22,
      164,
      .5,
    ),
    500: Color.fromRGBO(
      204,
      22,
      164,
      .6,
    ),
    600: Color.fromRGBO(
      204,
      22,
      164,
      .7,
    ),
    700: Color.fromRGBO(
      204,
      22,
      164,
      .8,
    ),
    800: Color.fromRGBO(
      204,
      22,
      164,
      .9,
    ),
    900: Color.fromRGBO(
      204,
      22,
      164,
      1,
    ),
  },
);

ThemeData myTheme = ThemeData(
  fontFamily: "Arial",
  primaryColor: const Color(0xffcc16a4),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(
        const Color(0xffcc16a4),
      ),
    ),
  ),
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: PrimaryMaterialColor,
  ).copyWith(
    secondary: const Color(0xffcc16a4),
  ),
);
