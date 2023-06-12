import 'package:flutter/material.dart';
import 'package:riddle_game/screens/game_screen.dart';
import 'package:riddle_game/screens/credits_screen.dart';
import 'package:audioplayers/audioplayers.dart';

AudioCache audioCache = AudioCache();
final player = AudioPlayer();
bool isPlaying = false;
bool isMuted = false;

void playBackgroundSound() async {
  await audioCache.load('sounds/song.mp3');
  player.play(AssetSource('sounds/song.mp3'));
  player.setReleaseMode(ReleaseMode.loop);
  isPlaying = true;
}

void stopBackgroundSound() {
  player.stop();
  isPlaying = false;
}

void toggleMute() {
  if (isMuted) {
    player.setVolume(1.0);
    isMuted = false;
  } else {
    player.setVolume(0.0);
    isMuted = true;
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    playBackgroundSound();
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
    stopBackgroundSound();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused && isPlaying) {
      stopBackgroundSound();
    } else if (state == AppLifecycleState.resumed && !isPlaying) {
      playBackgroundSound();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(20),
            color: const Color.fromARGB(255, 57, 90, 64),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 280,
                      height: 280,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(150),
                        border: Border.all(
                          color: const Color.fromARGB(255, 34, 18, 0),
                          width: 20,
                        ),
                      ),
                      child: Transform.rotate(
                        angle: 80, // Specify the rotation angle in radians
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                              140), // Adjust the value to fit your needs
                          child: Container(
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('lib/images/wood.jpg'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Image.asset(
                      'lib/images/logoouter.png',
                      width: 200,
                      height: 200,
                      color: const Color.fromARGB(
                          255, 34, 18, 0), // Set the color of the logo
                    ),
                    Image.asset(
                      'lib/images/logoinner.png',
                      width: 200,
                      height: 200,
                      color: const Color.fromARGB(
                          255, 34, 18, 0), // Set the color of the logo
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20), // Rounded corners
                    image: const DecorationImage(
                      image: AssetImage('lib/images/wood.jpg'),
                      repeat: ImageRepeat.repeat,
                      fit: BoxFit.cover,
                      scale: 2,
                    ),
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      side: const BorderSide(
                          color: Color.fromARGB(255, 34, 18, 0), width: 5),
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 15),
                    ),
                    child: const Text(
                      'Play',
                      style: TextStyle(
                        fontSize: 25,
                        color: Color.fromARGB(255, 34, 18, 0),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const GameScreen()),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: const DecorationImage(
                      image: AssetImage('lib/images/wood.jpg'),
                      repeat: ImageRepeat.repeat,
                      fit: BoxFit.cover,
                      scale: 2,
                    ),
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      side: const BorderSide(
                          color: Color.fromARGB(255, 34, 18, 0), width: 5),
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 15),
                    ),
                    child: const Text(
                      'Credits',
                      style: TextStyle(
                        fontSize: 25,
                        color: Color.fromARGB(255, 34, 18, 0),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreditsScreen()),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 20,
            right: 20,
            child: IconButton(
              icon: Icon(
                isMuted ? Icons.volume_off : Icons.volume_up,
                color: const Color.fromARGB(255, 34, 18, 0),
              ),
              onPressed: () {
                setState(() {
                  toggleMute();
                });
              },
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: Row(
              children: [
                const Text(
                  'A  ',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(255, 34, 18, 0),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Image.asset(
                  'lib/images/plm.png',
                  width: 30,
                  height: 30,
                ),
                const SizedBox(width: 8),
                const Text(
                  'Project',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(255, 34, 18, 0),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
