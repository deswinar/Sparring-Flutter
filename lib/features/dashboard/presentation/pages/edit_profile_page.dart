import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/utils/constants.dart';
import '../../../auth/domain/entities/user.dart';

@RoutePage()
class EditProfilePage extends StatefulWidget {
  final User user;

  const EditProfilePage({super.key, required this.user});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _websiteController;
  late TextEditingController _streetController;
  late TextEditingController _suiteController;
  late TextEditingController _cityController;
  late TextEditingController _zipcodeController;

  @override
  void initState() {
    super.initState();
    // Initialize controllers with the current user's data
    _nameController = TextEditingController(text: widget.user.name);
    _emailController = TextEditingController(text: widget.user.email);
    _phoneController = TextEditingController(text: widget.user.phone ?? '');
    _websiteController = TextEditingController(text: widget.user.website ?? '');
    _streetController =
        TextEditingController(text: widget.user.address?.street ?? '');
    _suiteController =
        TextEditingController(text: widget.user.address?.suite ?? '');
    _cityController =
        TextEditingController(text: widget.user.address?.city ?? '');
    _zipcodeController =
        TextEditingController(text: widget.user.address?.zipcode ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _websiteController.dispose();
    _streetController.dispose();
    _suiteController.dispose();
    _cityController.dispose();
    _zipcodeController.dispose();
    super.dispose();
  }

  void _saveProfile() {
    // This is where you can save the updated profile
    // For example, you might call a repository method to update the user details
    print("Profile saved");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: Hero(
        tag: 'profile-option-$editProfileHeroTag',
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              // Profile Photo Section
              GestureDetector(
                onTap: () {
                  // Handle photo upload action (e.g., pick an image from the gallery)
                },
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: widget.user.photoUrl != null
                      ? NetworkImage(widget.user.photoUrl!)
                      : const AssetImage('assets/images/default_profile.png')
                          as ImageProvider,
                  child: widget.user.photoUrl == null
                      ? const Icon(Icons.camera_alt,
                          size: 40, color: Colors.white)
                      : null,
                ),
              ),
              const SizedBox(height: 16),

              // Name Field
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Email Field
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Phone Field
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Phone',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Website Field
              TextField(
                controller: _websiteController,
                keyboardType: TextInputType.url,
                decoration: const InputDecoration(
                  labelText: 'Website',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Address Section
              const Text(
                'Address',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),

              // Street Field
              TextField(
                controller: _streetController,
                decoration: const InputDecoration(
                  labelText: 'Street',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Suite Field
              TextField(
                controller: _suiteController,
                decoration: const InputDecoration(
                  labelText: 'Suite',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // City Field
              TextField(
                controller: _cityController,
                decoration: const InputDecoration(
                  labelText: 'City',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Zipcode Field
              TextField(
                controller: _zipcodeController,
                decoration: const InputDecoration(
                  labelText: 'Zipcode',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 32),

              // Save Button
              ElevatedButton(
                onPressed: _saveProfile,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Theme.of(context).secondaryHeaderColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                child: const Text('Save Profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
