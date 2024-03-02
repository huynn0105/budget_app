import 'package:expense_manager/constants.dart';
import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  primaryColor: Colors.black,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.pinkAccent,
    foregroundColor: Colors.white,
  ),
  appBarTheme: AppBarTheme(
    elevation: 0,
    backgroundColor: Colors.grey.shade50,
    titleTextStyle:
        TextStyleUtils.medium(16).copyWith(color: Colors.pinkAccent),
    iconTheme: IconThemeData(color: Colors.pinkAccent),
  ),
  scaffoldBackgroundColor: Colors.grey.shade50,
  iconTheme: IconThemeData(
    color: Colors.grey.shade600,
  ),
  buttonTheme: ButtonThemeData(buttonColor: Colors.pinkAccent),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.grey.shade100,
    selectedItemColor: Colors.pinkAccent,
    unselectedItemColor: Colors.grey.shade500,
  ),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.white,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.grey[850],
    elevation: 0,
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.black12,
    selectedItemColor: Colors.white,
    unselectedItemColor: Colors.grey.shade700,
  ),
  switchTheme: SwitchThemeData(
    trackColor: MaterialStateProperty.all<Color>(Colors.grey),
    thumbColor: MaterialStateProperty.all<Color>(Colors.white),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(borderSide: BorderSide.none),
  ),
  splashColor: Colors.grey.shade800,
);
