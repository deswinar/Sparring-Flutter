import 'package:auto_route/auto_route.dart';
import 'package:cloudinary_flutter/image/cld_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sparring/features/auth/presentation/cubit/auth_cubit.dart';

import '../../../../../core/utils/constants.dart';
import '../../../../../router/app_router.dart';
import '../../cubit/profile/profile_cubit.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ProfileCubit>().getProfile();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProfileSuccess) {
            final user = state
                .user; // Assuming `AuthAuthenticated` state holds the user entity

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Profile Picture Section using Cloudinary
                    SizedBox(
                      width: 120,
                      height: 120,
                      child: ClipOval(
                        child: kIsWeb
                            ? Image.network(
                                user.photoUrl ??
                                    '', // Provide the full URL for the image
                                fit: BoxFit.cover,
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child; // Image is fully loaded
                                  }
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value: loadingProgress
                                                  .expectedTotalBytes !=
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
                                publicId: user.photoUrl ?? '',
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
                    const SizedBox(height: 16),
                    Text(
                      user.name, // Replace with user's name
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      user.email, // Replace with user's email
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Action Buttons
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade200,
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          _buildProfileOption(
                            icon: Icons.edit,
                            title: 'Edit Profile',
                            onTap: () {
                              // Navigate to Edit Profile Page
                              context.pushRoute(EditProfileRoute(user: user));
                            },
                          ),
                          const Divider(height: 1),
                          _buildProfileOption(
                            icon: Icons.lock,
                            title: 'Change Password',
                            onTap: () {
                              // Navigate to Change Password Page
                              context.pushRoute(const ChangePasswordRoute());
                            },
                          ),
                          const Divider(height: 1),
                          _buildProfileOption(
                            icon: Icons.notifications,
                            title: 'Notification Preferences',
                            onTap: () {
                              // Navigate to Notification Preferences Page
                            },
                          ),
                          const Divider(height: 1),
                          _buildProfileOption(
                            icon: Icons.info,
                            title: 'About App',
                            onTap: () {
                              // Show App Info or Navigate to About Page
                              context.pushRoute(const AboutAppRoute());
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Logout Button
                    BlocConsumer<AuthCubit, AuthState>(
                        listener: (context, state) {
                      if (state is AuthInitial) {
                        context.replaceRoute(const LoginRoute());
                      }
                    }, builder: (context, state) {
                      if (state is AuthLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        return ElevatedButton.icon(
                          onPressed: () {
                            // Perform Logout
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Confirm Logout'),
                                content: const Text(
                                    'Are you sure you want to log out?'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // Handle logout logic
                                      Navigator.pop(context); // Close dialog
                                      // Navigate to Login Screen
                                      context.read<AuthCubit>().logout();
                                    },
                                    child: const Text('Logout'),
                                  ),
                                ],
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 16,
                            ),
                          ),
                          icon: const Icon(Icons.logout),
                          label: const Text(
                            'Logout',
                            style: TextStyle(fontSize: 16),
                          ),
                        );
                      }
                    }),
                  ],
                ),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  /// Build profile option item with Hero animation
  Widget _buildProfileOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.blueAccent),
      title: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}
