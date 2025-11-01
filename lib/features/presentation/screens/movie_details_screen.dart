import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/movie_model.dart';
import '../cubit/movie_details_cubit/movie_details_cubit.dart';
import '../widgets/error_view.dart';
import '../widgets/loading_view.dart';
import '../widgets/movie_details_content.dart';

class MovieDetailsScreen extends StatelessWidget {
  final MovieModel movie;

  const MovieDetailsScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Movie Details', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: BlocBuilder<MovieDetailsCubit, MovieDetailsState>(
        builder: (context, state) {
          if (state is MovieDetailsLoading) {
            return const LoadingView();
          }

          if (state is MovieDetailsError) {
            return ErrorView(message: state.message, onRetry: () => context.read<MovieDetailsCubit>().fetchMovieDetails(movie.id));
          }

          if (state is MovieDetailsLoaded) {
            return MovieDetailsContent(movieDetails: state.movieDetails);
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
