import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
MaterialColor PrimaryMaterialColor = const MaterialColor(
  4288087671,
  <int, Color>{
    50: Color.fromRGBO(
      151,
      6,
      119,
      .1,
    ),
    100: Color.fromRGBO(
      151,
      6,
      119,
      .2,
    ),
    200: Color.fromRGBO(
      151,
      6,
      119,
      .3,
    ),
    300: Color.fromRGBO(
      151,
      6,
      119,
      .4,
    ),
    400: Color.fromRGBO(
      151,
      6,
      119,
      .5,
    ),
    500: Color.fromRGBO(
      151,
      6,
      119,
      .6,
    ),
    600: Color.fromRGBO(
      151,
      6,
      119,
      .7,
    ),
    700: Color.fromRGBO(
      151,
      6,
      119,
      .8,
    ),
    800: Color.fromRGBO(
      151,
      6,
      119,
      .9,
    ),
    900: Color.fromRGBO(
      151,
      6,
      119,
      1,
    ),
  },
);

ThemeData myTheme = ThemeData(
  fontFamily: "customFont",
  primaryColor: const Color(0xff970677),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(
        const Color(0xff970677),
      ),
    ),
  ),
  colorScheme:
      ColorScheme.fromSwatch(primarySwatch: PrimaryMaterialColor).copyWith(
    secondary: const Color(0xff970677),
  ),
);
