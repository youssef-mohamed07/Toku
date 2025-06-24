import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class PhrasesPage extends StatefulWidget {
  const PhrasesPage({super.key});

  @override
  State<PhrasesPage> createState() => _PhrasesPageState();
}

class _PhrasesPageState extends State<PhrasesPage> {
  final AudioPlayer audioPlayer = AudioPlayer();
  bool isPlaying = false;
  String? currentlyPlaying;

  final List<Map<String, dynamic>> phrases = [
    {
      'jp': 'Kimasu ka?',
      'en': 'Are you coming?',
      'sound': 'sounds/phrases/are_you_coming.wav',
      'icon': Icons.directions_walk,
      'category': 'Question',
    },
    {
      'jp': 'Wasurezu ni kōdoku shite ne',
      'en': 'Don\'t forget to subscribe',
      'sound': 'sounds/phrases/dont_forget_to_subscribe.wav',
      'icon': Icons.notifications,
      'category': 'Reminder',
    },
    {
      'jp': 'Kibun wa dō?',
      'en': 'How are you feeling?',
      'sound': 'sounds/phrases/how_are_you_feeling.wav',
      'icon': Icons.mood,
      'category': 'Question',
    },
    {
      'jp': 'Anime ga daisuki',
      'en': 'I love anime',
      'sound': 'sounds/phrases/i_love_anime.wav',
      'icon': Icons.favorite,
      'category': 'Expression',
    },
    {
      'jp': 'Puroguramingu ga daisuki',
      'en': 'I love programming',
      'sound': 'sounds/phrases/i_love_programming.wav',
      'icon': Icons.code,
      'category': 'Expression',
    },
    {
      'jp': 'Puroguramingu wa kantan desu',
      'en': 'Programming is easy',
      'sound': 'sounds/phrases/programming_is_easy.wav',
      'icon': Icons.lightbulb,
      'category': 'Statement',
    },
    {
      'jp': 'Anata no namae wa nan desu ka?',
      'en': 'What is your name?',
      'sound': 'sounds/phrases/what_is_your_name.wav',
      'icon': Icons.person,
      'category': 'Question',
    },
    {
      'jp': 'Doko ni itteimasu ka?',
      'en': 'Where are you going?',
      'sound': 'sounds/phrases/where_are_you_going.wav',
      'icon': Icons.place,
      'category': 'Question',
    },
    {
      'jp': 'Hai, ikimasu',
      'en': 'Yes, I\'m coming',
      'sound': 'sounds/phrases/yes_im_coming.wav',
      'icon': Icons.check_circle,
      'category': 'Response',
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
      backgroundColor: const Color(0xFFF8F6F3),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF6B35),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Phrases',
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
          itemCount: phrases.length,
          itemBuilder: (context, index) {
            final item = phrases[index];
            return buildPhraseItem(
              jp: item['jp']!,
              en: item['en']!,
              icon: item['icon']!,
              category: item['category']!,
              isPlaying: isPlaying && currentlyPlaying == item['sound'],
              onPlay: () => playSound(item['sound']!),
              index: index,
            );
          },
        ),
      ),
    );
  }

  Widget buildPhraseItem({
    required String jp,
    required String en,
    required IconData icon,
    required String category,
    required bool isPlaying,
    required VoidCallback onPlay,
    required int index,
  }) {
    // Beautiful phrase-themed gradients
    final gradients = [
      [const Color(0xFF667EEA), const Color(0xFF764BA2)], // Question - Purple-Blue
      [const Color(0xFFFF8A80), const Color(0xFFFF5722)], // Reminder - Red-Orange
      [const Color(0xFF4FC3F7), const Color(0xFF29B6F6)], // Question - Light Blue
      [const Color(0xFFE91E63), const Color(0xFFAD1457)], // Expression - Pink
      [const Color(0xFF66BB6A), const Color(0xFF43A047)], // Expression - Green
      [const Color(0xFFFFB74D), const Color(0xFFF57C00)], // Statement - Orange
      [const Color(0xFF9575CD), const Color(0xFF7E57C2)], // Question - Purple
      [const Color(0xFF4DB6AC), const Color(0xFF00897B)], // Question - Teal
      [const Color(0xFF81C784), const Color(0xFF66BB6A)], // Response - Green
    ];

    final gradient = gradients[index % gradients.length];
    final mainColor = gradient[0];

    // Category colors
    final categoryColors = {
      'Question': const Color(0xFF2196F3),
      'Reminder': const Color(0xFFFF5722),
      'Expression': const Color(0xFFE91E63),
      'Statement': const Color(0xFFFF9800),
      'Response': const Color(0xFF4CAF50),
    };

    final categoryColor = categoryColors[category] ?? mainColor;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(18),
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
      child: Column(
        children: [
          // Header with icon and category
          Row(
            children: [
              Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    category,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      letterSpacing: 0.5,
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
          const SizedBox(height: 16),
          // Phrases content
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: Colors.white.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Japanese phrase
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'JP',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        jp,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          height: 1.3,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // English phrase
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'EN',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        en,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                          height: 1.3,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}