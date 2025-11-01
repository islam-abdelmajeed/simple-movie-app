import 'package:json_annotation/json_annotation.dart';

part 'movie_details_model.g.dart';

@JsonSerializable()
class GenreModel {
  final int id;
  final String name;

  GenreModel({required this.id, required this.name});

  factory GenreModel.fromJson(Map<String, dynamic> json) =>
      _$GenreModelFromJson(json);

  Map<String, dynamic> toJson() => _$GenreModelToJson(this);
}

@JsonSerializable()
class MovieDetailsModel {
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
  final int? runtime;
  final List<GenreModel> genres;

  MovieDetailsModel({
    required this.id,
    required this.title,
    this.overview,
    this.posterPath,
    this.backdropPath,
    this.releaseDate,
    this.voteAverage,
    this.voteCount,
    this.runtime,
    required this.genres,
  });

  factory MovieDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$MovieDetailsModelToJson(this);

  String get posterUrl => posterPath != null 
      ? 'https://image.tmdb.org/t/p/w500$posterPath' 
      : '';
      
  String get backdropUrl => backdropPath != null 
      ? 'https://image.tmdb.org/t/p/w500$backdropPath' 
      : '';
}
