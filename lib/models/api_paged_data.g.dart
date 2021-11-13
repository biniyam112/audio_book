// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_paged_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

APIPagedData _$APIPagedDataFromJson(Map<String, dynamic> json) {
  return APIPagedData(
    currentPage: json['currentPage'] as int,
    totalItems: json['totalItems'] as int,
    totalPages: json['totalPages'] as int,
    items: json['items'] as List<dynamic>?,
  );
}

Map<String, dynamic> _$APIPagedDataToJson(APIPagedData instance) =>
    <String, dynamic>{
      'currentPage': instance.currentPage,
      'totalItems': instance.totalItems,
      'totalPages': instance.totalPages,
      'items': instance.items,
    };
