import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entity/review_entity.dart';

part 'review_api_model.g.dart';

final reviewApiModelProvider =
    Provider<ReviewApiModel>((ref) => ReviewApiModel.empty());

@JsonSerializable()
class ReviewApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: 'package_id')
  final String packageId;
  @JsonKey(name: 'user_id')
  final String userId;
  @JsonKey(name: 'ratings')
  final double rating;
  @JsonKey(name: 'review')
  final String review;


  ReviewApiModel({
    this.id,
    required this.packageId,
    required this.userId,
    required this.rating,
    required this.review,
   
  });

  ReviewApiModel.empty()
      : id = '',
        userId = '',
        rating = 0,
        review = '',
        packageId = '';
       
  // Convert API Object to Entity
  ReviewEntity toEntity() => ReviewEntity(
        id: id ?? '',
        userId: userId,
        packageId: packageId,
        rating: rating,
        review: review,

       
      );

  // Convert Entity to API Object
  ReviewApiModel fromEntity(ReviewEntity entity) => ReviewApiModel(
        id: entity.id,
        userId: entity.userId,
        packageId: entity.packageId,
        rating: entity.rating,
        review: entity.review,
        
      );

  // Convert API List to Entity List
  List<ReviewEntity> toEntityList(List<ReviewApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  List<Object?> get props => [
        id,
        userId,
        rating,
        review,
       
      ];

  factory ReviewApiModel.fromJson(Map<String, dynamic> json) =>
      _$ReviewApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewApiModelToJson(this);
}