import 'package:dio/dio.dart';
import '../../../core/network/api_constants.dart';
import '../datasources/movie_api_service.dart';
import '../datasources/movie_local_datasource.dart';
import '../models/movie_details_model.dart';
import '../models/movies_response_model.dart';

abstract class MovieRepository {
  Future<MoviesResponseModel> getPopularMovies(int page);
  Future<MovieDetailsModel> getMovieDetails(int movieId);
}

class MovieRepositoryImpl implements MovieRepository {
  final MovieApiService _apiService;
  final MovieLocalDataSource _localDataSource;

  MovieRepositoryImpl(this._apiService, this._localDataSource);

  @override
  Future<MoviesResponseModel> getPopularMovies(int page) async {
    try {
      final response = await _apiService.getPopularMovies(ApiConstants.apiKey, page, 'en-US');

      if (page == 1) {
        await _localDataSource.cacheMovies(response);
      }

      return response;
    } on DioException {
      if (page == 1) {
        final cachedData = await _localDataSource.getCachedMovies();
        if (cachedData != null) {
          return cachedData;
        }
      }
      rethrow;
    }
  }

  @override
  Future<MovieDetailsModel> getMovieDetails(int movieId) async {
    try {
      final response = await _apiService.getMovieDetails(movieId, ApiConstants.apiKey, 'en-US');

      await _localDataSource.cacheMovieDetails(response);
      return response;
    } on DioException {
      final cachedData = await _localDataSource.getCachedMovieDetails(movieId);
      if (cachedData != null) {
        return cachedData;
      }
      rethrow;
    }
  }
}
