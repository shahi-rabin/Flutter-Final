// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'packagehome_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PackagehomeApiModel _$PackagehomeApiModelFromJson(Map<String, dynamic> json) =>
    PackagehomeApiModel(
      packageId: json['_id'] as String?,
      destinationName: json['destination_name'] as String?,
      packageName: json['package_name'] as String,
      packageDescription: json['package_description'] as String,
      packageTime: json['package_time'] as String,
      location: json['location'] as String,
      price: json['price'] as int?,
      remaining: json['remaining'] as int?,
      route: json['route'] as String?,
      packageCover: json['package_cover'] as String?,
      packagePlan: json['package_plan'] as String,
      isBookmarked: json['isBookmarked'] as bool?,
      user: json['user'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$PackagehomeApiModelToJson(
        PackagehomeApiModel instance) =>
    <String, dynamic>{
      '_id': instance.packageId,
      'destination_name': instance.destinationName,
      'package_name': instance.packageName,
      'package_description': instance.packageDescription,
      'package_time': instance.packageTime,
      'location': instance.location,
      'price': instance.price,
      'remaining': instance.remaining,
      'route': instance.route,
      'package_cover': instance.packageCover,
      'package_plan': instance.packagePlan,
      'isBookmarked': instance.isBookmarked,
      'user': instance.user,
    };
