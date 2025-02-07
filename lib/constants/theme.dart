import 'package:flutter/material.dart';

OutlineInputBorder outlineInputBorder = const OutlineInputBorder(
  borderSide: BorderSide(
    color: Colors.grey,
  ),
);

ThemeData themeData = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  inputDecorationTheme: InputDecorationTheme(
    border: outlineInputBorder,
    errorBorder: outlineInputBorder,
    enabledBorder: outlineInputBorder,
    focusedBorder: outlineInputBorder,
    disabledBorder: outlineInputBorder,
    prefixIconColor: Colors.grey,
    suffixIconColor: Colors.grey,
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      textStyle: const TextStyle(
        color: Colors.black,
      ),
      side: const BorderSide(
        color: Colors.black,
        width: 2,
      ),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      minimumSize: const Size(double.infinity, 48),
      backgroundColor: const Color.fromARGB(255, 24, 129, 215),
      textStyle: const TextStyle(
        color: Colors.white,
        fontSize: 18.0,
      ),
      disabledBackgroundColor: Colors.grey,
    ),
  ),
  primarySwatch: Colors.grey,
  canvasColor: Colors.green,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 0,
    centerTitle: true,
    titleTextStyle: TextStyle(
      fontSize: 24,
      color: Colors.black,
      fontWeight: FontWeight.bold,
    ),
    toolbarTextStyle: TextStyle(
      color: Colors.black,
    ),
    iconTheme: IconThemeData(color: Colors.black),
  ),
);
