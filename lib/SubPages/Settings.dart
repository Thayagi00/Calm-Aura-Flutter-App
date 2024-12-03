import 'package:calm_aura/Auth/LoginPage.dart';
import 'package:calm_aura/Auth/Welcome.dart';
import 'package:calm_aura/Common/color.dart';
import 'package:calm_aura/Register/EmergencyContacts.dart';
import 'package:calm_aura/Settings/EmergencyContactUpdate.dart';
import 'package:calm_aura/Settings/HelpSupport.dart';
import 'package:calm_aura/Settings/ResetPassword.dart';
import 'package:calm_aura/Settings/TermsConditions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: const Text(
          'Settings',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Coloors.purple,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const SizedBox(height: 16),
            _buildSectionTitle('Account'),
            _buildListTile(Icons.edit, 'Reset Password', () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ResetPasswordPage(),
                ),
              );
            }),
            _buildListTile(Icons.call, 'Emergency Contacts update', () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EmergencyContactsUpdatePage(),
                ),
              );
            }),
            /* _buildListTile(Icons.notifications, 'Notifications', () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NotificationPage(),
                ),
              );
            }),*/

            const SizedBox(height: 24),

            // Support & About Section
            _buildSectionTitle('Support & About'),
            _buildListTile(Icons.help, 'Help & Support', () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HelpSupportPage(),
                ),
              );
            }),
            _buildListTile(Icons.description, 'Terms and Conditions', () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TermsAndConditionsPage(),
                ),
              );
            }),
            const SizedBox(height: 24),

            _buildSectionTitle('Actions'),
            _buildLogOutTile(context),
            //_buildDeleteAccountTile(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildListTile(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
      iconColor: Coloors.blue,
      tileColor: Colors.grey.shade300,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    );
  }

  Widget _buildLogOutTile(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.logout, color: Colors.red),
      title: const Text('Log out'),
      onTap: () {
        _showLogoutConfirmationDialog(context);
      },
      tileColor: Colors.grey.shade300,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    );
  }

  /* Widget _buildDeleteAccountTile(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.delete, color: Colors.red),
      title: const Text('Delete Account'),
      onTap: () {
        _showDeleteAccountConfirmationDialog(context);
      },
      tileColor: Colors.grey.shade300,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    );
  }*/

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          title: const Text(
            'Log Out',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          content: const Row(
            children: [
              Icon(Icons.warning, color: Colors.red, size: 40),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Are you sure you want to log out? You will need to log in again to access your account.',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Coloors.purple,
              ),
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: const Text('Log Out'),
              onPressed: () {
                Navigator.of(context).pop();
                _performLogout(context);
              },
            ),
          ],
        );
      },
    );
  }

  /* void _showDeleteAccountConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          title: const Text(
            'Delete Account',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          content: Row(
            children: [
              Icon(Icons.warning, color: Colors.red, size: 40),
              const SizedBox(width: 10),
              Expanded(
                child: const Text(
                  'Are you sure you want to delete your account? This action cannot be undone.',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Coloors.purple,
              ),
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
             TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: const Text('Delete Account'),
              onPressed: () {
                Navigator.of(context).pop();
                _performDeleteAccount(context);
              },
            ),
          ],
        );
      },
    );
  }*/

  void _performLogout(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const Loginpage()),
    );
  }

  /* void _performDeleteAccount(BuildContext context) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .delete();

        await user.delete();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Your account has been deleted.')),
        );

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => WelcomePage()),
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'requires-recent-login') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Please log in again to delete your account.')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${e.message}')),
          );
        }
      }
    }
  }*/
}
