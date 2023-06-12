import 'package:flutter/material.dart';

class Member {
  final String name;
  final ImageProvider<Object> image;

  Member({required this.name, required this.image});
}

class CreditsScreen extends StatelessWidget {
  final List<Member> groupMembers = [
    Member(
      name: 'Crisostomo, Cyril Gwyneth F.',
      image: const AssetImage('lib/images/cyril.png'),
    ),
    Member(
      name: 'Daranciang, Angelica T.',
      image: const AssetImage('lib/images/markus.png'),
    ),
    Member(
      name: 'Franco, Markus Xyren L.',
      image: const AssetImage('lib/images/markus.png'),
    ),
    Member(
      name: 'Manaois, Shelley Pe L.',
      image: const AssetImage('lib/images/shelley.png'),
    ),
    Member(
      name: 'Sapno, Randolf Sergio L.',
      image: const AssetImage('lib/images/ran.png'),
    ),
    // Add more group members here
  ];

  CreditsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 57, 90, 64),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: 1,
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
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Group Members',
                        style: TextStyle(
                          fontSize: 25,
                          color: Color.fromARGB(255, 34, 18, 0),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: Center(
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: groupMembers.length,
                            itemBuilder: (context, index) {
                              final member = groupMembers[index];
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    image: const DecorationImage(
                                      image: AssetImage('lib/images/wood.jpg'),
                                      repeat: ImageRepeat.repeat,
                                      fit: BoxFit.cover,
                                      scale: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  child: ListTile(
                                    leading: ClipOval(
                                      // Clip the image into a circle shape
                                      child: Image(image: member.image),
                                    ),
                                    title: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        member.name,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color: Color.fromARGB(255, 34, 18, 0),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
