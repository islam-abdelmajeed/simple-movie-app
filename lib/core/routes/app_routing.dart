import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:week_5/features/presentation/cubit/movie_details_cubit/movie_details_cubit.dart';
import 'package:week_5/features/presentation/cubit/movie_list_cubit/movies_list_cubit.dart';
import '../../core/di/dependency_injection.dart';
import '../../features/data/models/movie_model.dart';
import '../../features/presentation/screens/movies_list_screen.dart';
import '../../features/presentation/screens/movie_details_screen.dart';
import 'routes.dart';

class AppRouting {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.moviesListScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(create: (context) => getIt<MoviesListCubit>(), child: const MoviesListScreen()),
        );

      case Routes.movieDetailsScreen:
        final movie = settings.arguments as MovieModel;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<MovieDetailsCubit>()..fetchMovieDetails(movie.id),
            child: MovieDetailsScreen(movie: movie),
          ),
        );
    }
    return null;
  }
}
