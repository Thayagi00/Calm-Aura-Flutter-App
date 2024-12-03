import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:calm_aura/Common/color.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // Firebase Auth instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Reset Password function
  Future<void> _resetPassword() async {
    try {
      if (_formKey.currentState!.validate()) {
        String email = _emailController.text.trim();
        String newPassword = _newPasswordController.text.trim();

        // Re-authenticate the user first if needed (for security purposes)
        User? user = _auth.currentUser;

        // If there's a user, update the password
        if (user != null) {
          // Update the password in Firebase
          await user.updatePassword(newPassword);

          // Optionally, you can also reauthenticate the user to ensure they're properly logged in
          await user.reload();
          user = _auth.currentUser;

          // Success message or navigate back
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Password successfully updated')));
          Navigator.pop(context); // Go back after password reset
        }
      }
    } catch (e) {
      // Handle errors (e.g., password strength, invalid email)
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error resetting password: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: Text(
          'Reset Password',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Coloors.purple,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/recreate.png',
                  width: 300,
                  height: 250,
                ),
                SizedBox(height: 30),
                Text(
                  'Enter your email and new password to reset your password.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
                SizedBox(height: 30),
                // Email TextFormField
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Coloors.purple),
                    prefixIcon: Icon(Icons.email, color: Coloors.purple),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                // New Password TextFormField
                TextFormField(
                  controller: _newPasswordController,
                  decoration: InputDecoration(
                    labelText: 'New Password',
                    labelStyle: TextStyle(color: Coloors.purple),
                    prefixIcon: Icon(Icons.lock, color: Coloors.purple),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a new password';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                // Confirm Password TextFormField
                TextFormField(
                  controller: _confirmPasswordController,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    labelStyle: TextStyle(color: Coloors.purple),
                    prefixIcon: Icon(Icons.lock, color: Coloors.purple),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your new password';
                    }
                    if (value != _newPasswordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 30),
                // Reset Password Button
                ElevatedButton(
                  onPressed: _resetPassword,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Coloors.purple,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 100.0, vertical: 16.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    textStyle: const TextStyle(fontSize: 18.0),
                  ),
                  child: Text('Reset Password',
                      style: TextStyle(color: Colors.white)),
                ),
                SizedBox(height: 20),
                // Cancel Button
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 140.0, vertical: 16.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    textStyle: const TextStyle(fontSize: 18.0),
                  ),
                  child:
                      Text('Cancel', style: TextStyle(color: Coloors.purple)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
