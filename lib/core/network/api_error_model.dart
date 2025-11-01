import 'package:json_annotation/json_annotation.dart';
part 'api_error_model.g.dart';

@JsonSerializable()
class ApiErrorModel {
  String? field;
  String? message;
  int? code;

  ApiErrorModel({this.field, this.message, this.code});

  factory ApiErrorModel.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorModelFromJson(json);

  Map<String, dynamic> toJson() => _$ApiErrorModelToJson(this);
}
