import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:movies_app/presentation/profile/view_model/profile_view_model.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileViewModel>(
      builder: (context, viewModel, _) {
        return Scaffold(
          appBar: AppBar(title: const Text('Profile')),
          body: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Account Info',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Text('Email: ${viewModel.userEmail}'),
                const SizedBox(height: 8),
                Text('Saved Movies: ${viewModel.savedMoviesCount}'),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: viewModel.logout,
                  icon: const Icon(Icons.logout),
                  label: const Text('Logout'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
