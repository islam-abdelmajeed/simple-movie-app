import 'package:hive_flutter/hive_flutter.dart';
import 'dart:convert';
import '../models/movies_response_model.dart';
import '../models/movie_details_model.dart';

abstract class MovieLocalDataSource {
  Future<void> cacheMovies(MoviesResponseModel moviesResponse);
  Future<MoviesResponseModel?> getCachedMovies();
  Future<void> cacheMovieDetails(MovieDetailsModel movieDetails);
  Future<MovieDetailsModel?> getCachedMovieDetails(int movieId);
  Future<void> clearCache();
}

class MovieLocalDataSourceImpl implements MovieLocalDataSource {
  static const String _moviesBoxName = 'movies_box';
  static const String _movieDetailsBoxName = 'movie_details_box';
  static const String _cachedMoviesKey = 'cached_movies';
  static const int _cacheExpiryHours = 24;

  Box<dynamic>? _moviesBox;
  Box<dynamic>? _movieDetailsBox;

  MovieLocalDataSourceImpl() {
    _initBoxes();
  }

  void _initBoxes() {
    _moviesBox = Hive.box(_moviesBoxName);
    _movieDetailsBox = Hive.box(_movieDetailsBoxName);
  }

  @override
  Future<void> cacheMovies(MoviesResponseModel moviesResponse) async {
    await _moviesBox?.put(_cachedMoviesKey, jsonEncode(moviesResponse.toJson()));
    await _moviesBox?.put('_cache_timestamp', DateTime.now().millisecondsSinceEpoch);
  }

  @override
  Future<MoviesResponseModel?> getCachedMovies() async {
    final cachedData = _moviesBox?.get(_cachedMoviesKey);
    if (cachedData == null) return null;

    final timestamp = _moviesBox?.get('_cache_timestamp') as int?;
    if (timestamp != null) {
      final cacheTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
      final now = DateTime.now();
      if (now.difference(cacheTime).inHours > _cacheExpiryHours) {
        await clearCache();
        return null;
      }
    }

    final jsonData = jsonDecode(cachedData as String);
    return MoviesResponseModel.fromJson(jsonData as Map<String, dynamic>);
  }

  @override
  Future<void> cacheMovieDetails(MovieDetailsModel movieDetails) async {
    await _movieDetailsBox?.put(movieDetails.id, jsonEncode(movieDetails.toJson()));
  }

  @override
  Future<MovieDetailsModel?> getCachedMovieDetails(int movieId) async {
    final cachedData = _movieDetailsBox?.get(movieId);
    if (cachedData == null) return null;

    final jsonData = jsonDecode(cachedData as String);
    return MovieDetailsModel.fromJson(jsonData as Map<String, dynamic>);
  }

  @override
  Future<void> clearCache() async {
    await _moviesBox?.clear();
    await _movieDetailsBox?.clear();
  }
}
