import 'package:flutter/material.dart';
import 'package:riddle_game/screens/splash_screen.dart';

void main() {
  runApp(const RiddleGameApp());
}

class RiddleGameApp extends StatelessWidget {
  const RiddleGameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Riddle Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const SplashScreen(), // Set the splash screen as the initial screen
    );
  }
}
