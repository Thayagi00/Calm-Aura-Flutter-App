import 'dart:io';
import 'package:calm_aura/Common/color.dart';
import 'package:calm_aura/Register/EmergencyContacts.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserInfoPage extends StatefulWidget {
  const UserInfoPage({Key? key}) : super(key: key);

  @override
  State<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  String gender = 'Male';
  int age = 25;
  File? _profileImage;
  String? _profileImageUrl;
  final TextEditingController _doctorNameController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  Future<String?> _uploadProfileImage(File image) async {
    try {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('profile_images/${DateTime.now().toString()}');
      final uploadTask = storageRef.putFile(image);
      final snapshot = await uploadTask.whenComplete(() => null);
      final imageUrl = await snapshot.ref.getDownloadURL();
      return imageUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  Future<void> _saveData() async {
    String? imageUrl;

    if (_profileImage != null) {
      imageUrl = await _uploadProfileImage(_profileImage!);
    }

    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;

      await FirebaseFirestore.instance.collection('users').doc(userId).set({
        'user_name': _userNameController.text,
        'doctor_name': _doctorNameController.text,
        'gender': gender,
        'age': age,
        'profile_image': imageUrl ?? _profileImageUrl,
      });

      print('Data saved successfully!');

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => EmergencyContactsPage()),
      );
    } catch (e) {
      print('Error saving data: $e');
    }
  }

  Future<void> _loadData() async {
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;

      final docSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (docSnapshot.exists) {
        final data = docSnapshot.data();
        setState(() {
          _userNameController.text = data?['user_name'] ?? '';
          _doctorNameController.text = data?['doctor_name'] ?? '';
          gender = data?['gender'] ?? 'Male';
          age = data?['age'] ?? 25;
          _profileImageUrl = data?['profile_image'];
        });
      }
    } catch (e) {
      print('Error loading data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: const Text(
          'About Me',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 25,
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
            GestureDetector(
              onTap: () => _showImageSourceSelection(context),
              child: CircleAvatar(
                radius: 60.0,
                backgroundImage: _profileImage != null
                    ? FileImage(_profileImage!)
                    : (_profileImageUrl != null
                        ? NetworkImage(_profileImageUrl!)
                        : null),
                child: _profileImage == null && _profileImageUrl == null
                    ? const Icon(Icons.person, size: 60.0, color: Colors.white)
                    : null,
                backgroundColor: Colors.deepPurple.shade100,
              ),
            ),
            const SizedBox(height: 24.0),
            _buildTextField(
              controller: _userNameController,
              label: 'User Name',
              icon: Icons.person,
            ),
            const SizedBox(height: 16.0),
            _buildTextField(
              controller: _doctorNameController,
              label: 'Doctor\'s Name',
              icon: Icons.local_hospital,
            ),
            const SizedBox(height: 16.0),
            _buildDropdown(
              label: 'Gender',
              value: gender,
              items: ['Male', 'Female', 'Other'],
              onChanged: (value) {
                setState(() {
                  gender = value!;
                });
              },
            ),
            const SizedBox(height: 16.0),
            _buildNumberField(
              label: 'Age',
              value: age,
              onChanged: (value) {
                setState(() {
                  age = value;
                });
              },
            ),
            const SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: _saveData,
              child: const Text(
                'Save',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Coloors.purple,
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      onChanged: onChanged,
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  Widget _buildNumberField({
    required String label,
    required int value,
    required ValueChanged<int> onChanged,
  }) {
    return TextField(
      keyboardType: TextInputType.number,
      controller: TextEditingController(text: value.toString()),
      onChanged: (value) {
        onChanged(int.tryParse(value) ?? 0);
      },
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: const Icon(Icons.calendar_today),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }

  void _showImageSourceSelection(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Image Source'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.camera),
                title: const Text('Camera'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo),
                title: const Text('Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
