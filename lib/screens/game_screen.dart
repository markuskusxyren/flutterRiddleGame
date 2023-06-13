// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

AudioCache audioCache = AudioCache();

final player = AudioPlayer();

void playCorrectSound() {
  player.play(AssetSource('sounds/correct_sound.mp3'));
}

void playWrongSound() {
  player.play(AssetSource('sounds/wrong_sound.mp3'));
}

class _GameScreenState extends State<GameScreen> {
  int currentLevel = 1;
  int wrongAnswers = 0;
  String selectedAnswer = '';

  final random = Random();
  int correctAnswers = 0;

  Timer? timer;
  int timerDuration = 15;

  List shuffledOptions = [];

  List getAnswerOptions() {
    final currentLevelData = levels[currentLevel - 1];
    final answerOptions = [
      currentLevelData['answer'],
      currentLevelData['choices'][0],
      currentLevelData['choices'][1],
      currentLevelData['choices'][2],
    ];
    answerOptions.shuffle(); // Shuffle the answer options
    return answerOptions;
  }

  final List<Map<String, dynamic>> levels = [
    {
      'question': 'What has to be broken before you use it?',
      'answer': 'Egg',
      'choices': ['Glass', 'Plate', 'Mirror']
    },
    {
      'question':
          'I speak without a mouth and hear without ears. I have no body, but I come alive with the wind. What am I?',
      'answer': 'Echo',
      'choices': ['Music', 'Whisper', 'Voice']
    },
    {
      'question': 'What is always in front of you but can\'t be seen?',
      'answer': 'Future',
      'choices': ['Shadow', 'Dream', 'Air']
    },
    {
      'question': "What has a heart that doesn't beat?",
      'answer': 'Artichoke',
      'choices': ['Stone', 'Statue', 'Robot']
    },
    {
      'question': 'What goes up but never comes down?',
      'answer': 'Age',
      'choices': ['Balloon', 'Rocket', 'Stairs']
    },
    {
      'question': 'What is so fragile that saying its name breaks it?',
      'answer': 'Silence',
      'choices': ['Glass', 'China', 'Whisper']
    },
    {
      'question':
          'What is seen in the middle of March and April that cant be seen at the beginning or end of either month?',
      'answer': 'Letter R',
      'choices': ['Sun', 'Moon', 'Trash']
    },
    {
      'question': 'What is black when it is clean and white when it is dirty?',
      'answer': 'Chalkboard',
      'choices': ['Paper', 'Towel', 'Board']
    },
    {
      'question': 'What is full of holes but still holds water?',
      'answer': 'Sponge',
      'choices': ['Bucket', 'Cup', 'Bowl']
    },
    {
      'question': 'What has one eye but cant see?',
      'answer': 'Needle',
      'choices': ['Cyclops', 'Camera', 'Telescope']
    },
    {
      'question': "What has keys but can't open locks?",
      'answer': 'Piano',
      'choices': ['Keyboard', 'Safe', 'Chest']
    },
    {
      'question': "I can be cracked, made, told, and played. What am I?",
      'answer': 'Joke',
      'choices': ['Song', 'Poem', 'Riddle']
    },
    {
      'question': "What belongs to you but is used more by others?",
      'answer': 'Name',
      'choices': ['Money', 'Time', 'House']
    },
    {
      'question':
          "I can fly without wings. I can cry without eyes. Wherever I go, darkness follows me. What am I?",
      'answer': 'Cloud',
      'choices': ['Bird', 'Airplane', 'Rain']
    },
    {
      'question':
          "What has cities but no houses, forests but no trees, and rivers but no water?",
      'answer': 'Map',
      'choices': ['Book', 'Globe', 'Painting']
    },
    {
      'question':
          "I am taken from a mine, and shut in a wooden case, from which I am never released, and yet I am used by almost every person. What am I?",
      'answer': 'Pencil',
      'choices': ['Pen', 'Eraser', 'Marker']
    },
    {
      'question': "What can travel around the world while staying in a corner?",
      'answer': 'Stamp',
      'choices': ['Coin', 'Ticket', 'Passport']
    },
    {
      'question':
          "What has a face that doesn't smile, a back that doesn't break, and two arms that don't move?",
      'answer': 'Clock',
      'choices': ['Mirror', 'Doll', 'Statue']
    },
    {
      'question': "What can you catch but not throw?",
      'answer': 'Cold',
      'choices': ['Ball', 'Fish', 'Butterfly']
    },
    {
      'question': "What has a thumb and four fingers but is not alive?",
      'answer': 'Glove',
      'choices': ['Hand', 'Foot', 'Sock']
    },
    {
      'question':
          "I have cities but no houses, forests but no trees, and rivers but no water. What am I?",
      'answer': 'Globe',
      'choices': ['Planet', 'Country', 'Continent']
    },
    {
      'question': "The more you take, the more you leave behind. What am I?",
      'answer': 'Footsteps',
      'choices': ['Breath', 'Steps', 'Shadows']
    },
    {
      'question': "What has keys but no locks?",
      'answer': 'Keyboard',
      'choices': ['Car', 'Door', 'Safe']
    },
    {
      'question':
          "What can be seen once in a minute, twice in a moment, and never in a thousand years?",
      'answer': "Letter 'M'",
      'choices': ["Number '1'", "Letter 'A'", "Symbol '+'"]
    },
    {
      'question': "What has no beginning, end, or middle?",
      'answer': 'Circle',
      'choices': ["Line", "Square", "Triangle"]
    },
    {
      'question': "You can't see me, but you can't live without me. What am I?",
      'answer': 'Air',
      'choices': ['Mountain', 'Water', 'Fire']
    },
    {
      'question':
          "Only one color, but not one size, stuck at the bottom, yet easily flies, present in the sun, but not in rain, doing no harm, and feeling no pain. What is it?",
      'answer': 'Shadow',
      'choices': ['Cat', 'Moon', 'Sun']
    },
    {
      'question': "What building has the most stories?",
      'answer': 'Library',
      'choices': ['Restaurant', 'Department', 'Cafe']
    },
    {
      'question': "What has words, but never speaks?",
      'answer': 'Book',
      'choices': ['Graffiti', 'Letter', 'Keyboard']
    }
  ];

  @override
  void initState() {
    super.initState();
    setRandomLevel();
    startTimer();
    audioCache.load('sounds/correct_sound.mp3');
    audioCache.load('sounds/wrong_sound.mp3');
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void shuffleOptions() {
    setState(() {
      getAnswerOptions();
    });
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) async {
      setState(() {
        if (timerDuration > 0) {
          timerDuration--;
        } else {
          // Stop the timer
          timer.cancel();
          playWrongSound();
          if (wrongAnswers >= 2) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return Center(
                  child: SimpleDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    title: const Text("Game Over"),
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Column(
                          children: [
                            const Text("You have reached 3 mistakes."),
                            const SizedBox(height: 16),
                            Text("Correct Answers: $correctAnswers"),
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          resetGame(); // Reset the game
                        },
                        child: const Text("Restart"),
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            wrongAnswers++;
            setState(() {
              selectedAnswer = levels[currentLevel - 1]['answer'];
            });

            Future.delayed(const Duration(milliseconds: 3000), () {
              setState(() {
                resetTimer();
                setRandomLevel();
                shuffleOptions();
              });
              startTimer(); // Start the timer again
            });
          }
        }
      });
    });
  }

  void resetTimer() {
    setState(() {
      timerDuration = 15;
    });
  }

  void setRandomLevel() {
    int randomLevel;
    do {
      randomLevel = random.nextInt(levels.length) + 1;
    } while (randomLevel == currentLevel);

    setState(() {
      currentLevel = randomLevel;
      shuffledOptions = getAnswerOptions();
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentLevelData = levels[currentLevel - 1];
    final String question = currentLevelData['question'];
    final List answerOptions = shuffledOptions;

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor:
            Color.fromARGB(255, 57, 90, 64), // Set the desired color here
      ),
    );

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(20),
              color: const Color.fromARGB(255, 57, 90, 64),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 16),
                  Text(
                    question,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 253, 253, 253),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 25),
                  for (String answerOption in answerOptions)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Container(
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage('lib/images/wood.jpg'),
                            repeat: ImageRepeat.repeat,
                            fit: BoxFit.cover,
                            scale: 2,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(
                                color: selectedAnswer == answerOption
                                    ? Colors.green
                                    : const Color.fromARGB(255, 34, 18, 0),
                                width: 5,
                              ),
                            ),
                            backgroundColor: Colors.transparent,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 30,
                              vertical: 15,
                            ),
                          ),
                          onPressed: () {
                            selectAnswer(answerOption);
                          },
                          child: Text(
                            answerOption,
                            style: const TextStyle(
                              fontSize: 20,
                              color: Color.fromARGB(255, 34, 18, 0),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      3,
                      (index) => Icon(
                        index < wrongAnswers
                            ? Icons.close
                            : Icons.close_outlined,
                        color: index < wrongAnswers ? Colors.red : null,
                        size: 80,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            Positioned(
              top: 10,
              left: 1,
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                color: const Color.fromARGB(255, 34, 18, 0),
                iconSize: 40,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Positioned(
              top: 15,
              right: 15,
              child: SizedBox(
                width: 40,
                height: 40,
                child: CircularProgressIndicator(
                  value: timerDuration / 15, // Update this value as needed
                  strokeWidth: 10,
                  backgroundColor: const Color.fromARGB(255, 57, 90, 64),
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    Color.fromARGB(255, 34, 18, 0),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: SizedBox(
                width: 50,
                height: 50,
                child: Center(
                  child: Text(
                    timerDuration.toString(),
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void selectAnswer(String answer) async {
    final currentLevelData = levels[currentLevel - 1];
    final String correctAnswer = currentLevelData['answer'];

    if (answer == correctAnswer) {
      setState(() {
        playCorrectSound();
        correctAnswers++;
        resetTimer();
        selectedAnswer = answer;
      });
      await Future.delayed(const Duration(milliseconds: 1500));
      setRandomLevel();
    } else {
      setState(() {
        playWrongSound();
        wrongAnswers++;
        selectedAnswer = answer;
      });

      setState(() {
        selectedAnswer = correctAnswer;
      });

      await Future.delayed(const Duration(milliseconds: 1500));

      setState(() {
        selectedAnswer = '';
      });
      resetTimer();
      setRandomLevel();
      shuffleOptions();
    }
    checkGameOver();
  }

  void checkGameOver() {
    if (wrongAnswers >= 3) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(
            child: SimpleDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: const Text("Game Over"),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    children: [
                      const Text("You have reached 3 mistakes."),
                      const SizedBox(height: 16),
                      Text("Correct Answers: $correctAnswers"),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    resetGame(); // Reset the game
                  },
                  child: const Text("Restart"),
                ),
              ],
            ),
          );
        },
      );
      // Stop the timer
      timer?.cancel();
    }
  }

  void resetGame() {
    setState(() {
      wrongAnswers = 0;
      correctAnswers = 0;
      setRandomLevel();
      selectedAnswer = '';
    });
    resetTimer(); // Reset the timer
    startTimer(); // Start the timer again
  }
}
