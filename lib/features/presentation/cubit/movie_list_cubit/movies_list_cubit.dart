import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import '../../../data/models/movie_model.dart';
import '../../../data/repository/movie_repository.dart';
import '../../../../core/network/api_error_handler.dart';

part 'movies_list_state.dart';

class MoviesListCubit extends Cubit<MoviesListState> {
  final MovieRepository _repository;
  int _currentPage = 1;
  bool _hasMore = true;
  List<MovieModel> _movies = [];

  MoviesListCubit(this._repository) : super(MoviesListInitial());

  Future<void> fetchMovies({bool loadMore = false}) async {
    if (!loadMore) {
      _currentPage = 1;
      _hasMore = true;
      _movies = [];
      if (isClosed) return;
      emit(MoviesListLoading());
    } else if (!_hasMore) {
      return;
    } else {
      if (isClosed) return;
      emit(MoviesListLoadingMore());
    }

    try {
      final response = await _repository.getPopularMovies(_currentPage);

      final newMovies = response.results;
      if (loadMore) {
        _movies.addAll(newMovies);
      } else {
        _movies = newMovies;
      }

      _hasMore = _currentPage < response.totalPages;
      _currentPage++;

      if (isClosed) return;
      emit(MoviesListLoaded(movies: _movies, hasMore: _hasMore));
    } catch (e) {
      final error = ApiErrorHandler.handle(e);
      
      // Send error to Sentry (safe to call even if Sentry is not initialized)
      try {
        await Sentry.captureException(
          e,
          hint: Hint.withMap({
            'errorMessage': error.message,
            'action': 'fetchMovies',
            'loadMore': loadMore.toString(),
            'currentPage': _currentPage.toString(),
          }),
        );
      } catch (_) {
        // Ignore Sentry errors to not interrupt error handling
      }
      
      if (isClosed) return;
      emit(MoviesListError(message: error.message!));
    }
  }

  Future<void> refreshMovies() async {
    _currentPage = 1;
    _hasMore = true;
    _movies = [];
    await fetchMovies();
  }

  void loadMoreMovies() {
    if (_hasMore && state is! MoviesListLoadingMore) {
      fetchMovies(loadMore: true);
    }
  }
}
