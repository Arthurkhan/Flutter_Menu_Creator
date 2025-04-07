import 'package:flutter/material.dart';
import 'package:menu_creator/screens/home_screen.dart';

void main() {
  runApp(const MenuCreatorApp());
}

class MenuCreatorApp extends StatelessWidget {
  const MenuCreatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Menu Creator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomeScreen(),
    );
  }
}