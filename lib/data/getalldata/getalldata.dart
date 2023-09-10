import 'package:crud/data/notedata/notedata.dart';
import 'package:json_annotation/json_annotation.dart';


part 'getalldata.g.dart';

@JsonSerializable()
class Getalldata {
  @JsonKey(name:"data")
  List<Notedata> data;

  Getalldata({this.data=const[]});

  factory Getalldata.fromJson(Map<String, dynamic> json) {
    return _$GetalldataFromJson(json);
  }

  Map<String, dynamic> toJson() => _$GetalldataToJson(this);
}
