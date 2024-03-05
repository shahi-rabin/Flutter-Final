// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_searched_packages_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetSearchedPackagesDTO _$GetSearchedPackagesDTOFromJson(
        Map<String, dynamic> json) =>
    GetSearchedPackagesDTO(
      data: (json['data'] as List<dynamic>)
          .map((e) => PackagehomeApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetSearchedPackagesDTOToJson(
        GetSearchedPackagesDTO instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
