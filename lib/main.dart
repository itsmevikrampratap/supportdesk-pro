import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'themes/app_theme.dart';

void main() {
  runApp(const SupportDeskApp());
}

class SupportDeskApp extends StatefulWidget {
  const SupportDeskApp({Key? key}) : super(key: key);

  @override
  State<SupportDeskApp> createState() => _SupportDeskAppState();
}

class _SupportDeskAppState extends State<SupportDeskApp> {
  final bool _isDark = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SupportDesk Pro',
      debugShowCheckedModeBanner: false,
      themeMode: _isDark ? ThemeMode.dark : ThemeMode.light,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: const SplashScreen(),
    );
  }
}