import 'package:flutter/material.dart';
import 'package:todo/screens/home.dart';
import 'package:todo/themes/theme.dart'; // Import the theme file

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light; // Initial theme mode

  void _toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme, // Use the lightTheme
      darkTheme: AppTheme.darkTheme, // Use the darkTheme
      themeMode: _themeMode, // Use the theme mode
      home: Home(toggleTheme: _toggleTheme), // Pass the toggle function to Home
    );
  }
}
