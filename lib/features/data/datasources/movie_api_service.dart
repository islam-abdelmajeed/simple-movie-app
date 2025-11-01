import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../../core/network/api_constants.dart';
import '../models/movie_details_model.dart';
import '../models/movies_response_model.dart';

part 'movie_api_service.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class MovieApiService {
  factory MovieApiService(Dio dio) = _MovieApiService;

  @GET(ApiConstants.popularMovies)
  Future<MoviesResponseModel> getPopularMovies(@Query('api_key') String apiKey, @Query('page') int page, @Query('language') String language);

  @GET('/movie/{id}')
  Future<MovieDetailsModel> getMovieDetails(@Path('id') int id, @Query('api_key') String apiKey, @Query('language') String language);
}
