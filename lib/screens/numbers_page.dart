import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class NumbersPage extends StatefulWidget {
  const NumbersPage({super.key});

  @override
  State<NumbersPage> createState() => _NumbersPageState();
}

class _NumbersPageState extends State<NumbersPage> {
  final AudioPlayer audioPlayer = AudioPlayer();
  bool isPlaying = false;
  String? currentlyPlaying;

  final List<Map<String, dynamic>> numbers = [
    {
      'jp': 'ichi',
      'en': 'one',
      'number': '1',
      'image': 'assets/images/numbers/number_one.png',
      'sound': 'sounds/numbers/number_one_sound.mp3',
    },
    {
      'jp': 'ni',
      'en': 'two',
      'number': '2',
      'image': 'assets/images/numbers/number_two.png',
      'sound': 'sounds/numbers/number_two_sound.mp3',
    },
    {
      'jp': 'san',
      'en': 'three',
      'number': '3',
      'image': 'assets/images/numbers/number_three.png',
      'sound': 'sounds/numbers/number_three_sound.mp3',
    },
    {
      'jp': 'shi',
      'en': 'four',
      'number': '4',
      'image': 'assets/images/numbers/number_four.png',
      'sound': 'sounds/numbers/number_four_sound.mp3',
    },
    {
      'jp': 'go',
      'en': 'five',
      'number': '5',
      'image': 'assets/images/numbers/number_five.png',
      'sound': 'sounds/numbers/number_five_sound.mp3',
    },
    {
      'jp': 'roku',
      'en': 'six',
      'number': '6',
      'image': 'assets/images/numbers/number_six.png',
      'sound': 'sounds/numbers/number_six_sound.mp3',
    },
    {
      'jp': 'nana',
      'en': 'seven',
      'number': '7',
      'image': 'assets/images/numbers/number_seven.png',
      'sound': 'sounds/numbers/number_seven_sound.mp3',
    },
    {
      'jp': 'hachi',
      'en': 'eight',
      'number': '8',
      'image': 'assets/images/numbers/number_eight.png',
      'sound': 'sounds/numbers/number_eight_sound.mp3',
    },
    {
      'jp': 'kyuu',
      'en': 'nine',
      'number': '9',
      'image': 'assets/images/numbers/number_nine.png',
      'sound': 'sounds/numbers/number_nine_sound.mp3',
    },
    {
      'jp': 'juu',
      'en': 'ten',
      'number': '10',
      'image': 'assets/images/numbers/number_ten.png',
      'sound': 'sounds/numbers/number_ten_sound.mp3',
    },
  ];

  Future<void> playSound(String soundPath) async {
    try {
      if (isPlaying && currentlyPlaying == soundPath) {
        await audioPlayer.stop();
        setState(() {
          isPlaying = false;
          currentlyPlaying = null;
        });
        return;
      }

      await audioPlayer.stop();
      await audioPlayer.play(AssetSource(soundPath));
      setState(() {
        isPlaying = true;
        currentlyPlaying = soundPath;
      });

      audioPlayer.onPlayerComplete.listen((_) {
        setState(() {
          isPlaying = false;
          currentlyPlaying = null;
        });
      });
    } catch (e) {
      print("Error playing sound: $e");
    }
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8FC),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2196F3),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Numbers',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: numbers.length,
          itemBuilder: (context, index) {
            final item = numbers[index];
            return buildNumberItem(
              imagePath: item['image']!,
              jpName: item['jp']!,
              enName: item['en']!,
              number: item['number']!,
              isPlaying: isPlaying && currentlyPlaying == item['sound'],
              onPlay: () => playSound(item['sound']!),
              index: index,
            );
          },
        ),
      ),
    );
  }

  Widget buildNumberItem({
    required String imagePath,
    required String jpName,
    required String enName,
    required String number,
    required bool isPlaying,
    required VoidCallback onPlay,
    required int index,
  }) {
    // Beautiful number-themed gradients
    final gradients = [
      [const Color(0xFF667EEA), const Color(0xFF764BA2)], // Purple-Blue (1)
      [const Color(0xFFFF6B6B), const Color(0xFFFFE66D)], // Red-Yellow (2)
      [const Color(0xFF4ECDC4), const Color(0xFF44A08D)], // Teal-Green (3)
      [const Color(0xFFFFA726), const Color(0xFFFB8C00)], // Orange (4)
      [const Color(0xFF9C27B0), const Color(0xFFE91E63)], // Purple-Pink (5)
      [const Color(0xFF26A69A), const Color(0xFF00ACC1)], // Cyan-Teal (6)
      [const Color(0xFFFF5722), const Color(0xFFFF9800)], // Deep Orange (7)
      [const Color(0xFF3F51B5), const Color(0xFF2196F3)], // Indigo-Blue (8)
      [const Color(0xFF4CAF50), const Color(0xFF8BC34A)], // Green (9)
      [const Color(0xFF673AB7), const Color(0xFF9C27B0)], // Deep Purple (10)
    ];

    final gradient = gradients[index % gradients.length];
    final mainColor = gradient[0];

    // Number icons for visual appeal
    final numberIcons = [
      Icons.looks_one,
      Icons.looks_two,
      Icons.looks_3,
      Icons.looks_4,
      Icons.looks_5,
      Icons.looks_6,
      Icons.filter_7,
      Icons.filter_8,
      Icons.filter_9,
      Icons.exposure_plus_1,
    ];

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: mainColor.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          // Image container with number overlay
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                    errorBuilder: (context, error, stackTrace) {
                      // Show number and icon if image fails
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              number,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: mainColor,
                              ),
                            ),
                            Icon(
                              numberIcons[index % numberIcons.length],
                              size: 16,
                              color: mainColor.withOpacity(0.7),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                // Number badge overlay
                Positioned(
                  top: 4,
                  right: 4,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: mainColor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        number,
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          // Text content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      jpName,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        number,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  enName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          // Number indicator circle
          Container(
            width: 35,
            height: 35,
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Center(
              child: Text(
                number,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: mainColor,
                ),
              ),
            ),
          ),
          // Play button
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: onPlay,
              icon: Icon(
                isPlaying ? Icons.pause : Icons.play_arrow,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}