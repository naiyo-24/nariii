import 'package:flutter/material.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: Colors.blueGrey[600],
    scaffoldBackgroundColor: Colors.white,
    cardColor: Colors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.blueGrey[600]),
      titleTextStyle: TextStyle(color: Colors.blueGrey[800], fontSize: 20),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: Colors.blueGrey[600],
      unselectedItemColor: Colors.blueGrey[300],
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.blueGrey[800]),
      bodyMedium: TextStyle(color: Colors.blueGrey[600]),
      labelLarge: const TextStyle(color: Colors.white),
    ),
    dividerColor: Colors.blueGrey[100],
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.grey[100],
      filled: true,
    ),
  );

  static final darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: Colors.blueGrey[200],
    scaffoldBackgroundColor: const Color(0xFF121212),
    cardColor: const Color(0xFF1E1E1E),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF121212),
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: const Color(0xFF1E1E1E),
      selectedItemColor: Colors.blueGrey[200],
      unselectedItemColor: Colors.grey[600],
    ),
    textTheme: TextTheme(
      bodyLarge: const TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.grey[400]),
      labelLarge: const TextStyle(color: Colors.black),
    ),
    dividerColor: Colors.grey[800],
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.grey[900],
      filled: true,
    ),
    dialogTheme: const DialogTheme(
      backgroundColor: Color(0xFF1E1E1E),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Color(0xFF1E1E1E),
    ),
    colorScheme: ColorScheme.dark(
      primary: Colors.blueGrey[200]!,
      secondary: Colors.blueGrey[300]!,
      surface: const Color(0xFF1E1E1E),
      background: const Color(0xFF121212),
      error: Colors.red[400]!,
    ),
    shadowColor: Colors.black,
    iconTheme: IconThemeData(
      color: Colors.grey[200],
    ),
  );
}
