import 'package:finance/screens/constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//! lIGHT
ThemeData lightTheme = ThemeData(
  textButtonTheme: const TextButtonThemeData(
      style: ButtonStyle(
          foregroundColor: MaterialStatePropertyAll(kBlackColor),
          )),
  fontFamily: GoogleFonts.vazirmatn().fontFamily,
  floatingActionButtonTheme:
      const FloatingActionButtonThemeData(backgroundColor: kpurplecolor),
  bottomNavigationBarTheme:
      const BottomNavigationBarThemeData(selectedItemColor: kpurplecolor),
  brightness: Brightness.light,
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
    backgroundColor: MaterialStateProperty.all(kpurplecolor),
  )),
  // colorScheme: ColorScheme.light(),
  // textTheme: TextTheme(bodyMedium: TextStyle(color: Colors.amberAccent))
);

//! DARK
ThemeData darkTheme = ThemeData(
  fontFamily: GoogleFonts.vazirmatn().fontFamily,
  floatingActionButtonTheme:
      const FloatingActionButtonThemeData(backgroundColor: kpurplecolor),
  bottomNavigationBarTheme:
      const BottomNavigationBarThemeData(selectedItemColor: kpurplecolor),
  brightness: Brightness.dark,

  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
    backgroundColor: MaterialStateProperty.all(kpurplecolor),
  )),
  // colorScheme: ColorScheme.dark(),
  // textTheme: TextTheme(bodyMedium: TextStyle(color: Colors.red))
);
