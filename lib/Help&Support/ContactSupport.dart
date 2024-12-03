import 'package:calm_aura/Common/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class ContactSupportPage extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: const Text(
          'Contact Support',
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
            const SizedBox(height: 20),
            _buildHeaderSection(),
            const SizedBox(height: 30),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildTextField("Your Name", _nameController, Icons.person),
                  const SizedBox(height: 20),
                  _buildTextField(
                      "Email Address", _emailController, Icons.email,
                      isEmail: true),
                  const SizedBox(height: 20),
                  _buildMessageField("Message", _messageController),
                ],
              ),
            ),
            const SizedBox(height: 30),
            const Center(
              child: Text(
                "We aim to respond within 24 hours.",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    String name = _nameController.text;
                    String email = _emailController.text;
                    String message = _messageController.text;

                    await sendEmail(context, name, email, message);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Coloors.purple,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 100,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  shadowColor: Coloors.purple.withOpacity(0.5),
                  elevation: 8,
                ),
                child: const Text(
                  "Submit",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Column(
      children: [
        Image.asset(
          'assets/images/contact.jpg',
          width: 400,
          height: 300,
        ),
        const SizedBox(height: 12),
        const Text(
          "Need Assistance?",
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Coloors.purple,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          "We're here to help you!",
          style: TextStyle(
            fontSize: 18,
            fontStyle: FontStyle.italic,
            color: Colors.grey.shade700,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Future<void> sendEmail(
      BuildContext context, String name, String email, String message) async {
    final Email emailMessage = Email(
      body: 'Message: $message\n\nFrom: $name\nEmail: $email',
      subject: 'Support Request from $name',
      recipients: ['thayagiperera@gmail.com'],
      isHTML: false,
    );

    try {
      await FlutterEmailSender.send(emailMessage);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Your message has been sent!')),
      );
      _nameController.clear();
      _emailController.clear();
      _messageController.clear();
      Navigator.pop(context);
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Text('Failed to send message.'),
              TextButton(
                onPressed: () async {
                  await sendEmail(context, name, email, message);
                },
                child: const Text(
                  'Retry',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  Widget _buildTextField(
      String label, TextEditingController controller, IconData icon,
      {bool isEmail = false}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Coloors.blue),
          labelText: label,
          labelStyle: const TextStyle(color: Coloors.blue),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.grey[200],
          contentPadding:
              const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        ),
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          if (isEmail && !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
            return 'Please enter a valid email address';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildMessageField(String label, TextEditingController controller) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        maxLines: 5,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Coloors.purple),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.grey[200],
          contentPadding:
              const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your message';
          }
          return null;
        },
      ),
    );
  }
}
