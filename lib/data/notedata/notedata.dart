import 'package:json_annotation/json_annotation.dart';
part 'notedata.g.dart';

@JsonSerializable()
class Notedata {
  @JsonKey(name: '_id')
  String? id;
  @JsonKey(name: 'title')
  String? title;
  @JsonKey(name: 'content')
  String? content;

  Notedata({this.id, this.title, this.content});
  Notedata.create(
      {required this.id, required this.title, required this.content});

  factory Notedata.fromJson(Map<String, dynamic> json) {
    return _$NotedataFromJson(json);
  }

  Map<String, dynamic> toJson() => _$NotedataToJson(this);
}
