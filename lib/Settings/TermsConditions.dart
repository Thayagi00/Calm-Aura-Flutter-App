import 'package:calm_aura/Common/color.dart';
import 'package:flutter/material.dart';

class TermsAndConditionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: Text(
          'Teems & Conditions',
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Coloors.purple,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            SizedBox(height: 30),
            Center(
              child: Column(
                children: [
                  Icon(Icons.verified_user, color: Coloors.blue, size: 60),
                  const SizedBox(height: 8),
                  Text(
                    "Terms and Conditions",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Introductory Text
            _buildParagraph(
              "Thank you for choosing Calm Aura. We prioritize your well-being. By using this app, you agree to the following terms designed to ensure the best experience.",
            ),
            const SizedBox(height: 20),

            // Usage Restriction with a Gradient Card for Emphasis
            _buildSectionTitle("Usage Restriction"),
            SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.yellow.shade100, Colors.orange.shade100],
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.orange.withOpacity(0.2),
                    blurRadius: 6,
                    offset: Offset(2, 3),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.medical_services, color: Colors.orange.shade800),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "Note: Calm Aura is intended for individuals with panic disorders who have a certified healthcare provider's recommendation. Please consult your doctor before using this app.",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.orange.shade800,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ],
              ),
            ),
            _buildParagraph(
              "Calm Aura serves as a supportive tool, offering resources and techniques for managing panic symptoms. It does not replace medical treatment.",
            ),
            const SizedBox(height: 20),

            // Disclaimer Section with Icon
            _buildSectionTitle("Disclaimer"),
            _buildParagraph(
              "The information provided in Calm Aura is for educational support and does not substitute professional medical advice. Consult a healthcare provider with any medical concerns. Calm Aura’s creators are not responsible for consequences arising from its use.",
            ),
            const SizedBox(height: 20),

            // Updates Section
            _buildSectionTitle("Updates to Terms"),
            _buildParagraph(
              "These terms may be updated periodically. Please check back occasionally to stay informed. Your continued use of Calm Aura after updates indicates acceptance of the revised terms.",
            ),
            const SizedBox(height: 60),

            // Accept Button with Enhanced Styling
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Coloors.purple,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 120,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "I Accept",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.black,
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
}
