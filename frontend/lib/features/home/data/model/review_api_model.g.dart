// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewApiModel _$ReviewApiModelFromJson(Map<String, dynamic> json) =>
    ReviewApiModel(
      id: json['_id'] as String?,
      packageId: json['package_id'] as String,
      userId: json['user_id'] as String,
      rating: (json['ratings'] as num).toDouble(),
      review: json['review'] as String,
    );

Map<String, dynamic> _$ReviewApiModelToJson(ReviewApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'package_id': instance.packageId,
      'user_id': instance.userId,
      'ratings': instance.rating,
      'review': instance.review,
    };
