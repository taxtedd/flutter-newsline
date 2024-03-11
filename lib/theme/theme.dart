import 'package:flutter/material.dart';

final lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.light,
    seedColor: Colors.black,
    primary: Colors.black,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white70,
  ),
  scaffoldBackgroundColor: Colors.white,
  useMaterial3: true,
  textTheme: const TextTheme(
    bodySmall: TextStyle(
      color: Colors.black45,
      fontWeight: FontWeight.w500,
      fontSize: 14,
    ),
    labelSmall: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w500,
      fontSize: 16,
    ),
    labelMedium: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w600,
      fontSize: 22,
    ),
    labelLarge: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w700,
      fontSize: 30,
    ),
  ),
);

final darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: Colors.white,
    primary: Colors.white,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black45,
  ),
  scaffoldBackgroundColor: Colors.white12,
  useMaterial3: true,
  textTheme: const TextTheme(
    bodySmall: TextStyle(
      color: Colors.white60,
      fontWeight: FontWeight.w500,
      fontSize: 14,
    ),
    labelSmall: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w500,
      fontSize: 16,
    ),
    labelMedium: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w600,
      fontSize: 22,
    ),
    labelLarge: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w700,
      fontSize: 30,
    ),
  ),
);