import 'package:calm_aura/Common/color.dart';
import 'package:flutter/material.dart';

class MeditationBenefits extends StatelessWidget {
  const MeditationBenefits({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: const Text(
          'Meditation Benifits',
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
          _buildImprovementCard(
            title: "Reduced Stress",
            description:
                "Lowers cortisol levels, contributing to lower stress and anxiety.",
          ),
          _buildImprovementCard(
            title: "Decreased Symptoms of Anxiety and Depression",
            description:
                "Studies indicate significant reductions in anxiety and depressive symptoms.",
          ),
          _buildImprovementCard(
            title: "Enhanced Focus and Concentration",
            description:
                "Research shows improvements in attention span and cognitive flexibility, leading to better task performance.",
          ),
          _buildImprovementCard(
            title: "Emotional Well-Being",
            description:
                "Increased levels of positive emotions, improved self-esteem, and greater emotional regulation.",
          ),
          _buildImprovementCard(
            title: "Physical Health Benefits",
            description:
                "Improved immune function, reduced blood pressure, and alleviation of chronic pain symptoms.",
          ),
          _buildImprovementCard(
            title: "Better Sleep",
            description:
                "Meditation has been shown to improve sleep quality and reduce insomnia symptoms.",
          ),
        ],
      ),
    );
  }

  Widget _buildImprovementCard({
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
