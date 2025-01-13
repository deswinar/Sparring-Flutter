import 'package:auto_route/auto_route.dart';
import 'package:cloudinary_flutter/image/cld_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/constants.dart';
import '../../../auth/domain/entities/user.dart';
import '../cubit/profile/profile_cubit.dart';

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
    // Collect updated user data from the form
    final updatedUser = widget.user.copyWith(
      name: _nameController.text,
      email: _emailController.text,
      phone: _phoneController.text,
      website: _websiteController.text,
      address: widget.user.address?.copyWith(
        street: _streetController.text,
        suite: _suiteController.text,
        city: _cityController.text,
        zipcode: _zipcodeController.text,
      ),
    );
    context.read<ProfileCubit>().updateProfile(updatedUser);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state is ProfileError) {
              // Show failure message if update profile fails
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            } else if (state is ProfileSuccess) {
              // Show success message if update profile is successful
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Profile updated successfully')),
              );
              context.router.popUntilRoot();
            }
          },
          builder: (context, state) {
            if (state is ProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return ListView(
              children: [
                // Profile Photo Section
                GestureDetector(
                  onTap: () {
                    // Handle photo upload action (e.g., pick an image from the gallery)
                  },
                  child: SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipOval(
                      child: kIsWeb
                          ? Image.network(
                              widget.user.photoUrl ??
                                  '', // Provide the full URL for the image
                              fit: BoxFit.cover,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) {
                                  return child; // Image is fully loaded
                                }
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            (loadingProgress
                                                    .expectedTotalBytes ??
                                                1)
                                        : null, // Shows progress if total bytes are known
                                  ),
                                );
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return CircleAvatar(
                                  radius: 60,
                                  backgroundColor: Colors.grey.shade300,
                                  child: Icon(
                                    Icons.person,
                                    size: 60,
                                    color: Colors.grey.shade600,
                                  ),
                                );
                              },
                            )
                          : CldImageWidget(
                              publicId: widget.user.photoUrl ?? '',
                              errorBuilder: (context, error, stackTrace) {
                                return CircleAvatar(
                                  radius: 60,
                                  backgroundColor: Colors.grey.shade300,
                                  child: Icon(
                                    Icons.person,
                                    size: 60,
                                    color: Colors.grey.shade600,
                                  ),
                                );
                              },
                              placeholder: (context, _) {
                                return const CircularProgressIndicator();
                              },
                            ),
                    ),
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
            );
          },
        ),
      ),
    );
  }
}
