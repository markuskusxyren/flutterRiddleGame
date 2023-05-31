import 'package:flutter/material.dart';
import 'package:riddle_game/screens/game_screen.dart';
// ignore: unused_import
import 'package:riddle_game/screens/settings_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  'lib/images/logoouter.png',
                  width: 200,
                  height: 200,
                ),
                Image.asset(
                  'lib/images/logoinner.png',
                  width: 200,
                  height: 200,
                ),
              ],
            ),
            const SizedBox(height: 80),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              child: const Text(
                'Play',
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const GameScreen()),
                );
              },
            ),
            const SizedBox(height: 16),
            //ElevatedButton(
            //  style: ElevatedButton.styleFrom(
            //    backgroundColor: const Color.fromARGB(255, 155, 179, 245),
            //    shape: RoundedRectangleBorder(
            //      borderRadius: BorderRadius.circular(20),
            //    ),
            //    padding:
            //        const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            //  ),
            //  child: const Text(
            //    'Settings',
            //    style: TextStyle(fontSize: 20),
            //  ),
            //  onPressed: () {
            //    Navigator.push(
            //      context,
            //      MaterialPageRoute(
            //          builder: (context) => const SettingsScreen()),
            //    );
            //  },
            //),
          ],
        ),
      ),
    );
  }
}
