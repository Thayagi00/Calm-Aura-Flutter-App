import 'package:calm_aura/Common/color.dart';
import 'package:flutter/material.dart';

class MeditationBeginner extends StatelessWidget {
  const MeditationBeginner({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: const Text(
          'Beginner Guide',
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
          _buildTipCard(
            title: "Start Small",
            description:
                "Begin with just 5-10 minutes of meditation daily. Gradually increase the duration as you become more comfortable.",
          ),
          _buildTipCard(
            title: "Create a Comfortable Space",
            description:
                "Find a quiet, comfortable spot free from distractions where you can sit or lie down peacefully.",
          ),
          _buildTipCard(
            title: "Focus on Your Breath",
            description:
                "Use your breath as an anchor. Inhale deeply, hold for a moment, and exhale slowly, bringing your awareness back whenever your mind wanders.",
          ),
          _buildTipCard(
            title: "Use Resources",
            description:
                "Consider using meditation apps (like Headspace, Calm, or Insight Timer) or online guided sessions to help you get started.",
          ),
          _buildTipCard(
            title: "Be Patient",
            description:
                "Understand that meditation is a skill that takes time to develop. Don’t be discouraged by distractions or difficulties; they are part of the process.",
          ),
        ],
      ),
    );
  }

  Widget _buildTipCard({
    required String title,
    required String description,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
          ],
        ),
      ),
    );
  }
}
