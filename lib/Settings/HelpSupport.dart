import 'package:calm_aura/Common/color.dart';
import 'package:calm_aura/Help&Support/AboutUs.dart';
import 'package:calm_aura/Help&Support/ContactSupport.dart';
import 'package:calm_aura/Help&Support/FrequentlyQuestions.dart';
import 'package:calm_aura/Settings/TermsConditions.dart';
import 'package:flutter/material.dart';

class HelpSupportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: const Text(
          'Help & Support',
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Coloors.purple,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        color: Colors.grey[200],
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "How can we help you?",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Coloors.purple,
              ),
            ),
            const SizedBox(height: 20),
            _buildSupportOption(
              icon: Icons.help_outline,
              title: "Frequently Asked Questions",
              description: "Find answers to common questions.",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FAQPage(),
                  ),
                );
              },
            ),
            _buildSupportOption(
              icon: Icons.phone_in_talk_outlined,
              title: "Contact Support",
              description: "Get in touch with our support team.",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ContactSupportPage(),
                  ),
                );
              },
            ),
            _buildSupportOption(
              icon: Icons.article_outlined,
              title: "Terms and Conditions",
              description: "Read the terms and conditions for Calm Aura.",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TermsAndConditionsPage(),
                  ),
                );
              },
            ),
            _buildSupportOption(
              icon: Icons.info_outline,
              title: "About Calm Aura",
              description: "Learn more about the Calm Aura app.",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AboutCalmAuraPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSupportOption({
    required IconData icon,
    required String title,
    required String description,
    required Function() onTap,
  }) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          radius: 20,
          backgroundColor: Coloors.purple.withOpacity(0.1),
          child: Icon(icon, color: Coloors.purple),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        subtitle: Text(
          description,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }
}
