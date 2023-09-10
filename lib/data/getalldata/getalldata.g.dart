// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'getalldata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Getalldata _$GetalldataFromJson(Map<String, dynamic> json) => Getalldata(
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => Notedata.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$GetalldataToJson(Getalldata instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
