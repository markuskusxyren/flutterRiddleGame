import 'package:flutter/material.dart';

import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();

    // Wait for 3 seconds, then navigate to the home screen
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
          ),
          Center(
            child: RotationTransition(
              turns: Tween(begin: 0.0, end: 1.0).animate(animationController),
              child: Image.asset(
                'lib/images/logoouter.png',
                width: 350,
                height: 350,
              ),
            ),
          ),
          Positioned(
            child: Image.asset(
              'lib/images/logoinner.png',
              width: 50,
              height: 50,
            ),
          ),
        ],
      ),
    );
  }
}
