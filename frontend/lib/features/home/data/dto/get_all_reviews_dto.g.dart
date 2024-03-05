// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_reviews_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllReviewsDTO _$GetAllReviewsDTOFromJson(Map<String, dynamic> json) =>
    GetAllReviewsDTO(
      reviews: (json['reviews'] as List<dynamic>)
          .map((e) => ReviewApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllReviewsDTOToJson(GetAllReviewsDTO instance) =>
    <String, dynamic>{
      'reviews': instance.reviews,
    };
