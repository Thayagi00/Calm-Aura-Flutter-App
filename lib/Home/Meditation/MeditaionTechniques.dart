import 'package:calm_aura/Common/color.dart';
import 'package:flutter/material.dart';

class MeditaionTechniques extends StatelessWidget {
  const MeditaionTechniques({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: const Text(
          'Meditation Techniques',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        centerTitle: true,
        backgroundColor: Coloors.purple,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const SizedBox(height: 20),
          _buildTechniqueCard(
            title: "Mindfulness Meditation",
            description:
                "Focusing on the present moment, observing thoughts and feelings without judgment.",
            practice:
                "Sit quietly, focus on your breath, and return to it whenever your mind wanders.",
            imagePath: 'assets/images/mind.png',
          ),
          _buildTechniqueCard(
            title: "Transcendental Meditation (TM)",
            description:
                "Involves silently repeating a specific mantra for about 20 minutes, twice a day.",
            practice:
                "Find a quiet space, sit comfortably, and repeat your mantra while keeping your focus inward.",
            imagePath: 'assets/images/TM.png',
          ),
          _buildTechniqueCard(
            title: "Loving-Kindness Meditation (Metta)",
            description:
                "Cultivating an attitude of love and kindness toward oneself and others.",
            practice:
                "Start with self-directed wishes for well-being, then extend these wishes to others.",
            imagePath: 'assets/images/self.jpg',
          ),
          _buildTechniqueCard(
            title: "Body Scan Meditation",
            description:
                "Focusing attention on different parts of the body to promote relaxation and awareness.",
            practice:
                "Lie down comfortably, bring attention to each body part sequentially, and observe sensations.",
            imagePath: 'assets/images/metta.jpg',
          ),
          _buildTechniqueCard(
            title: "Guided Meditation",
            description:
                "Involves following a recording or live guide that leads you through meditation.",
            practice:
                "Use an app or online resource to follow along with a guided session focused on relaxation or visualization.",
            imagePath: 'assets/images/guidedMed.jpg',
          ),
        ],
      ),
    );
  }

  Widget _buildTechniqueCard({
    required String title,
    required String description,
    required String practice,
    required String imagePath,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              imagePath,
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 8.0),
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              description,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8.0),
            const Text(
              "Practice:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              practice,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
