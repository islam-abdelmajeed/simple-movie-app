import 'package:json_annotation/json_annotation.dart';
import 'package:week_5/core/network/api_constants.dart';

part 'movie_model.g.dart';

@JsonSerializable()
class MovieModel {
  final int id;
  final String title;
  final String? overview;
  @JsonKey(name: 'poster_path')
  final String? posterPath;
  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;
  @JsonKey(name: 'release_date')
  final String? releaseDate;
  @JsonKey(name: 'vote_average')
  final double? voteAverage;
  @JsonKey(name: 'vote_count')
  final int? voteCount;
  @JsonKey(name: 'genre_ids')
  final List<int>? genreIds;

  MovieModel({
    required this.id,
    required this.title,
    this.overview,
    this.posterPath,
    this.backdropPath,
    this.releaseDate,
    this.voteAverage,
    this.voteCount,
    this.genreIds,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) =>
      _$MovieModelFromJson(json);

  Map<String, dynamic> toJson() => _$MovieModelToJson(this);

  String get posterUrl =>
      posterPath != null ? '${ApiConstants.imageBaseUrl}$posterPath' : '';

  String get backdropUrl =>
      backdropPath != null ? '${ApiConstants.imageBaseUrl}$backdropPath' : '';
}
