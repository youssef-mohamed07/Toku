import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class FamilyMembersPage extends StatefulWidget {
  const FamilyMembersPage({super.key});

  @override
  State<FamilyMembersPage> createState() => _FamilyMembersPageState();
}

class _FamilyMembersPageState extends State<FamilyMembersPage> {
  final AudioPlayer audioPlayer = AudioPlayer();
  bool isPlaying = false;
  String? currentlyPlaying;

  final List<Map<String, String>> members = [
    {
      'jp': 'musume',
      'en': 'daughter',
      'image': 'assets/images/family_members/family_daughter.png',
      'sound': 'sounds/family_members/daughter.wav',
    },
    {
      'jp': 'chichi',
      'en': 'father',
      'image': 'assets/images/family_members/family_father.png',
      'sound': 'sounds/family_members/father.wav',
    },
    {
      'jp': 'ojiisan',
      'en': 'grandfather',
      'image': 'assets/images/family_members/family_grandfather.png',
      'sound': 'sounds/family_members/grand father.wav',
    },
    {
      'jp': 'obaasan',
      'en': 'grandmother',
      'image': 'assets/images/family_members/family_grandmother.png',
      'sound': 'sounds/family_members/grand mother.wav',
    },
    {
      'jp': 'haha',
      'en': 'mother',
      'image': 'assets/images/family_members/family_mother.png',
      'sound': 'sounds/family_members/mother.wav',
    },
    {
      'jp': 'ani',
      'en': 'older brother',
      'image': 'assets/images/family_members/family_older_brother.png',
      'sound': 'sounds/family_members/older bother.wav',
    },
    {
      'jp': 'ane',
      'en': 'older sister',
      'image': 'assets/images/family_members/family_older_sister.png',
      'sound': 'sounds/family_members/older sister.wav',
    },
    {
      'jp': 'musuko',
      'en': 'son',
      'image': 'assets/images/family_members/family_son.png',
      'sound': 'sounds/family_members/son.wav',
    },
    {
      'jp': 'otouto',
      'en': 'younger brother',
      'image': 'assets/images/family_members/family_younger_brother.png',
      'sound': 'sounds/family_members/younger brohter.wav',
    },
    {
      'jp': 'imouto',
      'en': 'younger sister',
      'image': 'assets/images/family_members/family_younger_sister.png',
      'sound': 'sounds/family_members/younger sister.wav',
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
      backgroundColor: const Color(0xFFF0F8F0),
      appBar: AppBar(
        backgroundColor: const Color(0xFF4CAF50),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Family Members',
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
          itemCount: members.length,
          itemBuilder: (context, index) {
            final item = members[index];
            return buildFamilyItem(
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

  Widget buildFamilyItem({
    required String imagePath,
    required String jpName,
    required String enName,
    required bool isPlaying,
    required VoidCallback onPlay,
    required int index,
  }) {
    // Beautiful family-themed colors
    final colors = [
      const Color(0xFFFF6B9D), // Pink for daughter
      const Color(0xFF4ECDC4), // Teal for father
      const Color(0xFF95A5A6), // Gray for grandfather
      const Color(0xFFF39C12), // Orange for grandmother
      const Color(0xFFE74C3C), // Red for mother
      const Color(0xFF3498DB), // Blue for older brother
      const Color(0xFF9B59B6), // Purple for older sister
      const Color(0xFF2ECC71), // Green for son
      const Color(0xFF1ABC9C), // Turquoise for younger brother
      const Color(0xFFE67E22), // Orange-red for younger sister
    ];

    final cardColor = colors[index % colors.length];

    // Family member icons
    final icons = [
      Icons.girl, // daughter
      Icons.man, // father
      Icons.elderly, // grandfather
      Icons.elderly_woman, // grandmother
      Icons.woman, // mother
      Icons.boy, // older brother
      Icons.girl_outlined, // older sister
      Icons.boy_outlined, // son
      Icons.child_care, // younger brother
      Icons.child_friendly, // younger sister
    ];

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: cardColor.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Image container
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
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  // Show family icon if image fails
                  return Container(
                    color: Colors.white,
                    child: Icon(
                      icons[index % icons.length],
                      size: 35,
                      color: cardColor,
                    ),
                  );
                },
              ),
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