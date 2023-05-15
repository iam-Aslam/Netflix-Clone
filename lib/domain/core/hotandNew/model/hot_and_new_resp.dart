import 'package:json_annotation/json_annotation.dart';

part 'hot_and_new_resp.g.dart';

@JsonSerializable()
class HotAndNewResp {
  @JsonKey(name: 'page')
  num? page;

  @JsonKey(name: 'results')
  List<HotAndNewData>? results;

  HotAndNewResp({
    this.page,
    this.results = const [],
  });

  factory HotAndNewResp.fromJson(Map<String, dynamic> json) {
    return _$HotAndNewRespFromJson(json);
  }

  Map<String, dynamic> toJson() => _$HotAndNewRespToJson(this);
}

@JsonSerializable()
class HotAndNewData {
  @JsonKey(name: 'backdrop_path')
  String? backdropPath;

  num? id;
  @JsonKey(name: 'original_language')
  String? originalLanguage;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'original_title')
  String? originalTitle;
  String? overview;

  @JsonKey(name: 'poster_path')
  String? posterPath;
  @JsonKey(name: 'release_date')
  String? releaseDate;
  String? title;

  HotAndNewData({
    this.backdropPath,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.name,
  });

  factory HotAndNewData.fromJson(Map<String, dynamic> json) {
    return _$HotAndNewDataFromJson(json);
  }

  Map<String, dynamic> toJson() => _$HotAndNewDataToJson(this);
}
