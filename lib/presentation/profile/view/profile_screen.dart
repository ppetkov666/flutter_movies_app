import 'package:flutter/material.dart';
import 'package:movies_app/constants/ui_strings.dart';
import 'package:provider/provider.dart';
import 'package:movies_app/presentation/profile/view_model/profile_view_model.dart';
import 'package:movies_app/core/providers/navigator_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileViewModel>(
      builder: (context, viewModel, _) {
        return Scaffold(
          appBar: AppBar(title: const Text(UIStrings.profileTooltip)),
          body: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  UIStrings.acccountInfoLabel,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Text('${UIStrings.emailLabel}: ${viewModel.userEmail}'),
                const SizedBox(height: 8),
                Text('${UIStrings.savedMoviesLabel}: ${viewModel.savedMoviesCount}'),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: () async {
                    await viewModel.logout();
                    // Navigate safely after the current frame to avoid animation errors
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      Provider.of<NavigatorProvider>(context, listen: false)
                          .pushAndRemoveUntil('/');
                    });
                  },
                  icon: const Icon(Icons.logout),
                  label: const Text(UIStrings.logoutTooltip),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
