import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movies_app/constants/ui_strings.dart';
import 'package:provider/provider.dart';
import 'package:movies_app/presentation/profile/view_model/profile_view_model.dart';
import 'package:movies_app/core/providers/navigator_provider.dart';
import 'package:movies_app/presentation/components/movie_profile_info_row.dart';
import 'package:movies_app/presentation/components/movie_logout_button.dart';
import 'package:movies_app/presentation/components/movie_loading_view.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _showSavedMovies = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileViewModel>(
      builder: (context, viewModel, _) {
        final creationDate = viewModel.accountCreationDate;
        final formattedDate = creationDate != null
            ? DateFormat.yMMMMd().format(creationDate)
            : UIStrings.noDateAvailable;

        final savedMovies = viewModel.savedMovies;

        return Scaffold(
          appBar: AppBar(title: const Text(UIStrings.profileTooltip)),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 0, left: 24, right: 24, bottom: 24),
              child: Column(
                children: [
                  // Scrollable content
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            UIStrings.acccountInfoLabel,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 16),
                          Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MovieProfileInfoRow(
                                    label: UIStrings.emailLabel,
                                    value: viewModel.userEmail,
                                  ),
                                  const Divider(),
                                  MovieProfileInfoRow(
                                    label: 'Member since',
                                    value: formattedDate,
                                  ),
                                  const Divider(),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _showSavedMovies = !_showSavedMovies;
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: MovieProfileInfoRow(
                                            label: UIStrings.savedMoviesLabel,
                                            value:
                                                savedMovies.length.toString(),
                                          ),
                                        ),
                                        Icon(
                                          _showSavedMovies
                                              ? Icons.expand_less
                                              : Icons.expand_more,
                                          color: Colors.deepPurple,
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (_showSavedMovies &&
                                      savedMovies.isNotEmpty) ...[
                                    const SizedBox(height: 8),
                                    ...savedMovies.map(
                                      (movie) => Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 2.0, horizontal: 8.0),
                                        child: Row(
                                          children: [
                                            const Icon(Icons.movie,
                                                size: 18,
                                                color: Colors.deepPurple),
                                            const SizedBox(width: 6),
                                            Expanded(
                                              child: Text(
                                                movie.title,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Fixed logout button
                  Center(
                    child: viewModel.isLoading
                        ? const MovieLoadingView(size: 32, strokeWidth: 3)
                        : MovieLogoutButton(
                            onPressed: () async {
                              await viewModel.logout();
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                Provider.of<NavigatorProvider>(context,
                                        listen: false)
                                    .pushAndRemoveUntil('/');
                              });
                            },
                          ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
