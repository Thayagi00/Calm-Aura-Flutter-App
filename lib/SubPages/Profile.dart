import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:calm_aura/Common/color.dart';
import 'package:calm_aura/SubPages/Settings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: const Text(
          "My Profile",
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
                    builder: (context) => SettingsPage(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('users')
            .doc('4qG8U2k0NuTLWeKdmgEkkWBrkAe2')
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text('User not found'));
          }

          var userData = snapshot.data!.data() as Map<String, dynamic>;

          String? email = FirebaseAuth.instance.currentUser?.email;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Column(
                    children: [
                      const CircleAvatar(
                        radius: 50,
                        backgroundImage:
                            AssetImage('assets/images/Profile.png'),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        userData['user_name'] ?? 'User',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: Coloors.purple),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Divider(),
                // Profile Details
                buildProfileDetail(Icons.person_outline, 'User Name',
                    userData['user_name'] ?? ''),
                buildProfileDetail(Icons.health_and_safety, "Doctor's Name",
                    userData['doctor_name'] ?? ''),
                buildProfileDetail(
                    Icons.person, 'Gender', userData['gender'] ?? ''),
                buildProfileDetail(
                    Icons.cake, 'Age', userData['age']?.toString() ?? ''),
                // Display email from Firebase Authentication
                buildProfileDetail(
                    Icons.email, 'Email', email ?? 'No email found'),
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
          Column(
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
              Text(
                value,
                style: const TextStyle(fontSize: 16, color: Colors.blueGrey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
