import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/routes/routes.dart';
import '../../../core/theme/theme_manager.dart';
import '../cubit/movie_list_cubit/movies_list_cubit.dart';
import '../widgets/error_view.dart';
import '../widgets/loading_view.dart';
import '../widgets/movie_card.dart';

class MoviesListScreen extends StatefulWidget {
  const MoviesListScreen({super.key});

  @override
  State<MoviesListScreen> createState() => _MoviesListScreenState();
}

class _MoviesListScreenState extends State<MoviesListScreen> {
  final ScrollController _scrollController = ScrollController();
  MoviesListLoaded? _lastLoadedState;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    context.read<MoviesListCubit>().fetchMovies();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    final cubit = context.read<MoviesListCubit>();
    final state = cubit.state;

    if (state is MoviesListLoaded && state.hasMore) {
      final threshold = _scrollController.position.maxScrollExtent * 0.8;
      if (_scrollController.position.pixels >= threshold) {
        cubit.loadMoreMovies();
      }
    }
  }

  void _toggleTheme() async {
    final isDark = !ThemeManager.isDarkTheme;
    await ThemeManager.setDarkTheme(isDark);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocListener<MoviesListCubit, MoviesListState>(
      listener: (context, state) {
        if (state is MoviesListLoaded) {
          _lastLoadedState = state;
        }
      },
      child: BlocBuilder<MoviesListCubit, MoviesListState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: AppBar(
              centerTitle: true,
              title: const Text('Movies', style: TextStyle(fontWeight: FontWeight.bold)),
              actions: [
                IconButton(
                  icon: Icon(
                    isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
                    color: isDark ? const Color(0xFFFFFFFF) : const Color(0xFF000000),
                  ),
                  onPressed: _toggleTheme,
                  tooltip: isDark ? 'Switch to Light Mode' : 'Switch to Dark Mode',
                ),
              ],
            ),
            body: _buildBody(state),
          );
        },
      ),
    );
  }

  Widget _buildBody(MoviesListState state) {
    if (state is MoviesListLoading) {
      return const LoadingView();
    }

    if (state is MoviesListError) {
      return ErrorView(message: state.message, onRetry: () => context.read<MoviesListCubit>().fetchMovies());
    }

    if (state is MoviesListLoaded || state is MoviesListLoadingMore) {
      final loadedState = state is MoviesListLoaded ? state : _lastLoadedState;

      if (loadedState == null) {
        return const LoadingView();
      }

      final movies = loadedState.movies;
      final isLoadingMore = state is MoviesListLoadingMore;

      return ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.all(8),
        itemCount: movies.length + (isLoadingMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index >= movies.length) {
            return const Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(child: CircularProgressIndicator()),
            );
          }

          final movie = movies[index];
          return MovieCard(
            movie: movie,
            onTap: () {
              Navigator.pushNamed(context, Routes.movieDetailsScreen, arguments: movie);
            },
          );
        },
      );
    }

    return const SizedBox.shrink();
  }
}
