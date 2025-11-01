import 'package:json_annotation/json_annotation.dart';
import 'movie_model.dart';

part 'movies_response_model.g.dart';

@JsonSerializable()
class MoviesResponseModel {
  final int page;
  final List<MovieModel> results;
  @JsonKey(name: 'total_pages')
  final int totalPages;
  @JsonKey(name: 'total_results')
  final int totalResults;

  MoviesResponseModel({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory MoviesResponseModel.fromJson(Map<String, dynamic> json) =>
      _$MoviesResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$MoviesResponseModelToJson(this);
}
