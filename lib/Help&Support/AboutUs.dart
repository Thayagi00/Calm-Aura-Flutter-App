import 'package:calm_aura/Common/color.dart';
import 'package:flutter/material.dart';

class AboutCalmAuraPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: const Text(
          'About Calm Aura',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Coloors.purple,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const SizedBox(height: 30),
            Center(
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20), // Rounded corners
                    child: Image.asset(
                      'assets/images/logo.png',
                      width: 360,
                      height: 300,
                      fit: BoxFit.cover, // Adjusts image to cover the space
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Calm Aura",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color:
                          Coloors.purple, // Changed color for brand consistency
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "Your Companion in Panic Attack Prevention",
                    style: TextStyle(
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                      color: Coloors.blue,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  const Divider(
                      thickness: 2, color: Coloors.blue), // Decorative divider
                ],
              ),
            ),
            const SizedBox(height: 20),
            _buildSectionTitle("Our Mission"),
            _buildParagraph(
              "Calm Aura aims to empower individuals who experience panic attacks by providing techniques and tools to navigate moments of anxiety. Our mission is to help you regain control and find calm in the midst of panic.",
            ),
            const SizedBox(height: 20),
            _buildSectionTitle("Features"),
            _buildFeatureList([
              "Real-time heart rate monitoring",
              "Relaxation techniques and breathing exercises",
              "Mood tracking and journaling",
              "Guided meditation",
              "Customizable notifications for regular self-check-ins",
            ]),
            const SizedBox(height: 20),
            _buildSectionTitle("Responsible Use of AI"),
            _buildParagraph(
              "Calm Aura uses AI to personalize your experience and suggest techniques based on your current state. We prioritize privacy, ensuring all data is secure and used responsibly to benefit your well-being.",
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Coloors.blue,
        ),
      ),
    );
  }

  Widget _buildParagraph(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 16,
        height: 1.5,
        color: Colors.grey.shade800,
      ),
      textAlign: TextAlign.justify,
    );
  }

  Widget _buildFeatureList(List<String> features) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: features
          .map((feature) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  children: [
                    const Icon(Icons.check_circle,
                        color: Coloors.blue, size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        feature,
                        style: TextStyle(
                          fontSize: 16,
                          height: 1.5,
                          color: Colors.grey.shade800,
                        ),
                      ),
                    ),
                  ],
                ),
              ))
          .toList(),
    );
  }
}
