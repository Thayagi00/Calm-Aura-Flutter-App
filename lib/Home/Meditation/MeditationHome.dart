import 'package:calm_aura/Common/color.dart';
import 'package:calm_aura/Home/Meditation/MeditaionTechniques.dart';
import 'package:calm_aura/Home/Meditation/MeditationBeginner.dart';
import 'package:calm_aura/Home/Meditation/MeditationBenefits.dart';
import 'package:flutter/material.dart';

class MeditationHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: const Text(
          'Meditation',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        backgroundColor: Coloors.purple,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/logo.png'),
            fit: BoxFit.cover,
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const SizedBox(height: 30),
            buildMeditationCard(
              context,
              'Meditation Techniques',
              Icons.self_improvement,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MeditaionTechniques(),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            buildMeditationCard(
              context,
              'Benefits of Meditation',
              Icons.thumb_up,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MeditationBenefits(),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            buildMeditationCard(
              context,
              'Beginner Guide',
              Icons.lightbulb,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MeditationBeginner(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMeditationCard(
      BuildContext context, String title, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.only(bottom: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 8,
        shadowColor: Colors.black.withOpacity(0.2),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [Colors.white, Coloors.purple.withOpacity(0.1)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Coloors.blue.withOpacity(0.2),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Icon(icon, size: 50, color: Coloors.blue),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Coloors.purple,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Tap to explore more',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
