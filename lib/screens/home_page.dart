import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:language/screens/colors_page.dart';
import 'package:language/screens/family_page.dart';
import 'package:language/screens/numbers_page.dart';
import 'package:language/screens/phrases_page.dart';
import '../components/category_item.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F6EE),
      appBar: AppBar(
        backgroundColor: Colors.brown.shade700,
        elevation: 2,
        centerTitle: true,
        title: Text(
          'Toku',
          style: GoogleFonts.poppins(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.2,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            buildCategory(
              title: 'Numbers',
              icon: Icons.looks_one_rounded,
              color: Colors.amber.shade700,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) =>  NumbersPage()),
              ),
            ),
            buildCategory(
              title: 'Family Members',
              icon: Icons.family_restroom,
              color: Colors.teal.shade600,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) =>  FamilyMembersPage()),
              ),
            ),
            buildCategory(
              title: 'Colors',
              icon: Icons.color_lens_rounded,
              color: Colors.deepPurple.shade400,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) =>  ColorsPage()),
              ),
            ),
            buildCategory(
              title: 'Phrases',
              icon: Icons.chat_rounded,
              color: Colors.deepOrangeAccent,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) =>  PhrasesPage()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
