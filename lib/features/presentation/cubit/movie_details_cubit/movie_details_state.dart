part of 'movie_details_cubit.dart';

@immutable
abstract class MovieDetailsState {}

class MovieDetailsInitial extends MovieDetailsState {}

class MovieDetailsLoading extends MovieDetailsState {}

class MovieDetailsLoaded extends MovieDetailsState {
  final MovieDetailsModel movieDetails;

  MovieDetailsLoaded({required this.movieDetails});
}

class MovieDetailsError extends MovieDetailsState {
  final String message;

  MovieDetailsError({required this.message});
}
