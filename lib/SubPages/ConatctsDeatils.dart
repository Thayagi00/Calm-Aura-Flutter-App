import 'package:calm_aura/Register/EmergencyContacts.dart';
import 'package:calm_aura/Settings/EmergencyContactUpdate.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:calm_aura/Common/color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ConatctsPage extends StatelessWidget {
  const ConatctsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: const Text(
          "Emergency Contacts ",
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
        backgroundColor: Coloors.purple,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              icon: const Icon(Icons.settings, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EmergencyContactsUpdatePage(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('emergency_contacts')
            .doc('vkyZ84FexSN6Zp4EtYkI')
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text('User not found'));
          }

          var userData = snapshot.data!.data() as Map<String, dynamic>;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/call.jpg',
                  height: 250,
                  width: 250,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 20),
                const Divider(),
                buildProfileDetail(
                    Icons.person_outline,
                    'Emergency Contact Name 01',
                    userData['contact1_name'] ?? ''),
                buildProfileDetail(
                    Icons.health_and_safety,
                    "Emergency Contact Number 01",
                    userData['contact1_phone'] ?? ''),
                buildProfileDetail(
                    Icons.person_outline,
                    'Emergency Contact Name 02',
                    userData['contact2_name'] ?? ''),
                buildProfileDetail(
                    Icons.health_and_safety,
                    "Emergency Contact Number 02",
                    userData['contact2_phone'] ?? ''),
                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildProfileDetail(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(icon, color: Coloors.blue, size: 30),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                GestureDetector(
                  onTap: () => _launchPhoneNumber(value),
                  child: Text(
                    value,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchPhoneNumber(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }
}
