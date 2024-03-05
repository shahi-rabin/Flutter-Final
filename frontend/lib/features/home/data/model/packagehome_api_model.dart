import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entity/package_entity.dart';

part 'packagehome_api_model.g.dart';

final packagehomeApiModelProvider =
    Provider<PackagehomeApiModel>((ref) => PackagehomeApiModel.empty());

@JsonSerializable()
class PackagehomeApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? packageId;
  @JsonKey(name: 'destination_name')
  final String? destinationName;
  @JsonKey(name: 'package_name')
  final String packageName;
  @JsonKey(name: 'package_description')
  final String packageDescription;
  @JsonKey(name: 'package_time')
  final String packageTime;
  @JsonKey(name: 'location')
  final String location;
  @JsonKey(name: 'price')
  final int? price;
  @JsonKey(name: 'remaining')
  final int? remaining;
  @JsonKey(name: 'route')
  final String? route;
  @JsonKey(name: 'package_cover')
  final String? packageCover;
  @JsonKey(name: 'package_plan')
  final String packagePlan;
  @JsonKey(name: 'isBookmarked')
  final bool? isBookmarked;
  @JsonKey(name: 'user')
  final Map<String, dynamic>? user;


   PackagehomeApiModel({
    this.packageId,
    this.destinationName,
    required this.packageName,
    required this.packageDescription,
    required this.packageTime,
    required this.location,
    this.price,
    this.remaining,
    this.route,
    this.packageCover,
    required this.packagePlan,
    this.isBookmarked,
    this.user,

  

  });

   PackagehomeApiModel.empty()
      : packageId = '',
        destinationName = '',
        packageName = '',
        packageDescription = '',
        packageTime = '',
        location = '',
        price = 0,
        remaining = 0,
        route = '',
        packageCover = "",
        packagePlan = "",
        isBookmarked = false,
        user = {};

       

  // Convert API Object to Entity
  PackageEntity toEntity() => PackageEntity(
        packageId: packageId ?? '',
        destinationName: destinationName ?? '',
        packageName: packageName,
        packageDescription: packageDescription,
        packageTime: packageTime,
        location: location,
        price: price ?? 0,
        remaining: remaining ?? 0,
        route: route ?? "",
        packageCover: packageCover ?? "",
        packagePlan: packagePlan,
        isBookmarked: isBookmarked ?? false,
        user: user ,

      );

  // Convert Entity to API Object
  PackagehomeApiModel fromEntity(PackageEntity entity) => PackagehomeApiModel(
        packageId: packageId ?? '',
        destinationName: destinationName ?? '',
        packageName: packageName,
        packageDescription: packageDescription,
        packageTime: packageTime,
        location: location,
        price: price,
        remaining: remaining,
        route: route,
        packageCover: packageCover,
        packagePlan: packagePlan,
        isBookmarked: isBookmarked,
        user: user,


      );

  // Convert API List to Entity List
  List<PackageEntity> toEntityList(List<PackagehomeApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  List<Object?> get props => [
        packageId,
        destinationName,
        packageName,
        packageDescription,
        packageTime,
        location,
        price,
        remaining,
        route,
        packageCover,
        packagePlan,
        isBookmarked,
        user,

      ];

  factory PackagehomeApiModel.fromJson(Map<String, dynamic> json) =>
      _$PackagehomeApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$PackagehomeApiModelToJson(this);
}
