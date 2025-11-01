import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../../../data/models/movie_details_model.dart';
import '../../../data/repository/movie_repository.dart';
import '../../../../core/network/api_error_handler.dart';

part 'movie_details_state.dart';

class MovieDetailsCubit extends Cubit<MovieDetailsState> {
  final MovieRepository _repository;

  MovieDetailsCubit(this._repository) : super(MovieDetailsInitial());

  Future<void> fetchMovieDetails(int movieId) async {
    if (isClosed) return;
    emit(MovieDetailsLoading());
    try {
      final movieDetails = await _repository.getMovieDetails(movieId);
      if (isClosed) return;
      emit(MovieDetailsLoaded(movieDetails: movieDetails));
    } catch (e) {
      final error = ApiErrorHandler.handle(e);
      if (isClosed) return;
      emit(MovieDetailsError(message: error.message!));
    }
  }
}
