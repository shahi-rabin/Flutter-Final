// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_user_packages_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetUserPackagesDTO _$GetUserPackagesDTOFromJson(Map<String, dynamic> json) =>
    GetUserPackagesDTO(
      data: (json['data'] as List<dynamic>)
          .map((e) => PackagehomeApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetUserPackagesDTOToJson(GetUserPackagesDTO instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
