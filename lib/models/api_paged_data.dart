import 'package:json_annotation/json_annotation.dart';

part 'api_paged_data.g.dart';

@JsonSerializable()
class APIPagedData {
  final int currentPage;
  final int totalItems;
  final int totalPages;
  final List<dynamic>? items;

  APIPagedData({
    required this.currentPage,
    required this.totalItems,
    required this.totalPages,
    this.items,
  });

  factory APIPagedData.fromJson(Map<String, dynamic> json) =>
      _$APIPagedDataFromJson(json);

  Map<String, dynamic> toJson() => _$APIPagedDataToJson(this);
}
