part of 'movies_list_cubit.dart';

@immutable
abstract class MoviesListState {}

class MoviesListInitial extends MoviesListState {}

class MoviesListLoading extends MoviesListState {}

class MoviesListLoadingMore extends MoviesListState {}

class MoviesListLoaded extends MoviesListState {
  final List<MovieModel> movies;
  final bool hasMore;

  MoviesListLoaded({required this.movies, required this.hasMore});
}

class MoviesListError extends MoviesListState {
  final String message;

  MoviesListError({required this.message});
}
