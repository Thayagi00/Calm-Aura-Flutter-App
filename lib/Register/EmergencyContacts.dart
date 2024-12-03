import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:calm_aura/Common/color.dart';
import 'package:calm_aura/MyHome.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EmergencyContactsPage extends StatefulWidget {
  const EmergencyContactsPage({super.key});

  @override
  State<EmergencyContactsPage> createState() => _EmergencyContactsPageState();
}

class _EmergencyContactsPageState extends State<EmergencyContactsPage> {
  final TextEditingController _contactName1Controller = TextEditingController();
  final TextEditingController _contactNumber1Controller =
      TextEditingController();
  final TextEditingController _contactName2Controller = TextEditingController();
  final TextEditingController _contactNumber2Controller =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final RegExp _phoneRegExp = RegExp(r'^[0-9]{10}$');

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: const Text(
          'Emergency Contacts',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        backgroundColor: Coloors.purple,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  'assets/images/emergency.jpg',
                  height: 300,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "Please add an emergency contact for your safety in case of urgent situations.",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16.0),
              _buildContactField(
                contactNameController: _contactName1Controller,
                contactNumberController: _contactNumber1Controller,
                contactLabel: 'Emergency Contact 1',
              ),
              const SizedBox(height: 24.0),
              _buildContactField(
                contactNameController: _contactName2Controller,
                contactNumberController: _contactNumber2Controller,
                contactLabel: 'Emergency Contact 2',
              ),
              const SizedBox(height: 32.0),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      saveContacts();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Coloors.purple,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 60.0, vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    textStyle: const TextStyle(fontSize: 18.0),
                  ),
                  child: const Text(
                    'SAVE CONTACTS',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> saveContacts() async {
    try {
      await _firestore.collection('emergency_contacts').add({
        'contact1_name': _contactName1Controller.text,
        'contact1_phone': _contactNumber1Controller.text,
        'contact2_name': _contactName2Controller.text,
        'contact2_phone': _contactNumber2Controller.text,
      });

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyHome()),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Contacts saved successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save contacts: $e')),
      );
    }
  }

  Widget _buildContactField({
    required TextEditingController contactNameController,
    required TextEditingController contactNumberController,
    required String contactLabel,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(contactLabel,
                style: const TextStyle(
                    fontSize: 18.0, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12.0),
            TextFormField(
              controller: contactNameController,
              decoration: InputDecoration(
                labelText: 'Name',
                hintText: 'Enter name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                filled: true,
                fillColor: Colors.grey.shade100,
                prefixIcon: const Icon(Icons.person_outline),
              ),
              style: const TextStyle(fontSize: 16.0),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a contact name.';
                }
                return null;
              },
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: contactNumberController,
              keyboardType: TextInputType.phone,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                labelText: 'Phone Number',
                hintText: 'Enter phone number',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                filled: true,
                fillColor: Colors.grey.shade100,
                prefixIcon: const Icon(Icons.phone_outlined),
              ),
              style: const TextStyle(fontSize: 16.0),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a phone number.';
                }
                if (!_phoneRegExp.hasMatch(value)) {
                  return 'Please enter a valid phone number.';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}
