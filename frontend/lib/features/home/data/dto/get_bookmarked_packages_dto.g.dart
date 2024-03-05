// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_bookmarked_packages_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetBookmarkedPackagesDTO _$GetBookmarkedPackagesDTOFromJson(
        Map<String, dynamic> json) =>
    GetBookmarkedPackagesDTO(
      data: (json['data'] as List<dynamic>)
          .map((e) => PackagehomeApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetBookmarkedPackagesDTOToJson(
        GetBookmarkedPackagesDTO instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
