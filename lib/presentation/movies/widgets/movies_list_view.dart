import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:movies_app/domain/entities/movie.dart';
import 'package:movies_app/presentation/movies/widgets/movie_card.dart';
import 'package:movies_app/presentation/movies/view_model/movies_view_model.dart';

class MoviesListView extends StatefulWidget {
  final List<Movie> movies;

  const MoviesListView({super.key, required this.movies});

  @override
  State<MoviesListView> createState() => _MoviesListViewState();
}

class _MoviesListViewState extends State<MoviesListView> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final viewModel = Provider.of<MoviesViewModel>(context, listen: false);

    if (!_scrollController.hasClients || viewModel.isLoading) return;

    const thresholdPixels = 200.0;
    if (_scrollController.position.pixels + thresholdPixels >=
        _scrollController.position.maxScrollExtent) {
      viewModel.loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.separated(
        controller: _scrollController,
        itemCount: widget.movies.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final movie = widget.movies[index];
          return MovieCard(
            movie: movie,
            hasValidImage: movie.hasValidImage,
          );
        },
      ),
    );
  }
}
