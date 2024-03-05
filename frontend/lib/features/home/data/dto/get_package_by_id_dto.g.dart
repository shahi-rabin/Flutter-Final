// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_package_by_id_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetPackageByIdDTO _$GetPackageByIdDTOFromJson(Map<String, dynamic> json) =>
    GetPackageByIdDTO(
      data: (json['data'] as List<dynamic>)
          .map((e) => PackagehomeApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetPackageByIdDTOToJson(GetPackageByIdDTO instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
