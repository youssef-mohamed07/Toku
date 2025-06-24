import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class ColorsPage extends StatefulWidget {
  const ColorsPage({super.key});

  @override
  State<ColorsPage> createState() => _ColorsPageState();
}

class _ColorsPageState extends State<ColorsPage> {
  final AudioPlayer audioPlayer = AudioPlayer();
  bool isPlaying = false;
  String? currentlyPlaying;

  final List<Map<String, dynamic>> colors = [
    {
      'jp': 'kuro',
      'en': 'black',
      'image': 'assets/images/colors/color_black.png',
      'sound': 'sounds/colors/black.wav',
      'color': const Color(0xFF2C3E50),
      'icon': Icons.circle,
    },
    {
      'jp': 'chairo',
      'en': 'brown',
      'image': 'assets/images/colors/color_brown.png',
      'sound': 'sounds/colors/brown.wav',
      'color': const Color(0xFF8D4004),
      'icon': Icons.circle,
    },
    {
      'jp': 'hokori iro no kiiro',
      'en': 'dusty yellow',
      'image': 'assets/images/colors/color_dusty_yellow.png',
      'sound': 'sounds/colors/dusty yellow.wav',
      'color': const Color(0xFFDAA520),
      'icon': Icons.circle,
    },
    {
      'jp': 'haiiro',
      'en': 'gray',
      'image': 'assets/images/colors/color_gray.png',
      'sound': 'sounds/colors/gray.wav',
      'color': const Color(0xFF7F8C8D),
      'icon': Icons.circle,
    },
    {
      'jp': 'midori',
      'en': 'green',
      'image': 'assets/images/colors/color_green.png',
      'sound': 'sounds/colors/green.wav',
      'color': const Color(0xFF27AE60),
      'icon': Icons.circle,
    },
    {
      'jp': 'aka',
      'en': 'red',
      'image': 'assets/images/colors/color_red.png',
      'sound': 'sounds/colors/red.wav',
      'color': const Color(0xFFE74C3C),
      'icon': Icons.circle,
    },
    {
      'jp': 'shiro',
      'en': 'white',
      'image': 'assets/images/colors/color_white.png',
      'sound': 'sounds/colors/white.wav',
      'color': const Color(0xFFECF0F1),
      'icon': Icons.circle,
    },
    {
      'jp': 'kiiro',
      'en': 'yellow',
      'image': 'assets/images/colors/yellow.png',
      'sound': 'sounds/colors/yellow.wav',
      'color': const Color(0xFFF1C40F),
      'icon': Icons.circle,
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
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF6C5CE7),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Colors',
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
          itemCount: colors.length,
          itemBuilder: (context, index) {
            final item = colors[index];
            return buildColorItem(
              imagePath: item['image']!,
              jpName: item['jp']!,
              enName: item['en']!,
              isPlaying: isPlaying && currentlyPlaying == item['sound'],
              onPlay: () => playSound(item['sound']!),
              index: index,
            );
          },
        ),
      ),
    );
  }

  Widget buildColorItem({
    required String imagePath,
    required String jpName,
    required String enName,
    required bool isPlaying,
    required VoidCallback onPlay,
    required int index,
  }) {
    // Beautiful color-themed gradients
    final gradients = [
      [const Color(0xFF2C3E50), const Color(0xFF34495E)], // Black gradient
      [const Color(0xFF8D4004), const Color(0xFFA0522D)], // Brown gradient
      [const Color(0xFFDAA520), const Color(0xFFFFD700)], // Dusty yellow gradient
      [const Color(0xFF7F8C8D), const Color(0xFF95A5A6)], // Gray gradient
      [const Color(0xFF27AE60), const Color(0xFF2ECC71)], // Green gradient
      [const Color(0xFFE74C3C), const Color(0xFFF39C12)], // Red gradient
      [const Color(0xFFECF0F1), const Color(0xFFBDC3C7)], // White gradient
      [const Color(0xFFF1C40F), const Color(0xFFF39C12)], // Yellow gradient
    ];

    final gradient = gradients[index % gradients.length];
    final mainColor = colors[index]['color'] as Color;

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
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Image container with color preview
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
                      // Show color circle if image fails
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: mainColor,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.grey.shade300,
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // Color indicator dot
                Positioned(
                  bottom: 4,
                  right: 4,
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: mainColor,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
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
                Text(
                  jpName,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
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
          // Color preview circle
          Container(
            width: 35,
            height: 35,
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              color: mainColor,
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
                width: 3,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
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