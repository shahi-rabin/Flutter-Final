// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_packages_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllPackagesDTO _$GetAllPackagesDTOFromJson(Map<String, dynamic> json) =>
    GetAllPackagesDTO(
      data: (json['data'] as List<dynamic>)
          .map((e) => PackagehomeApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllPackagesDTOToJson(GetAllPackagesDTO instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
