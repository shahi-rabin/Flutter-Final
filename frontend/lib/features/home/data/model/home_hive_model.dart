import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tripplanner/features/home/data/model/packagehome_api_model.dart';
import 'package:uuid/uuid.dart';

import '../../../../config/constants/hive_table_constants.dart';
import '../../domain/entity/package_entity.dart';

part 'home_hive_model.g.dart';

final packagehomeHiveModelProvider =
    Provider((ref) => PackagehomeHiveModel.empty());

@HiveType(typeId: HiveTableConstant.packageTableId)
class PackagehomeHiveModel {
  @HiveField(0)
  final String packageId;
  @HiveField(1)
  final String packageName;
  @HiveField(2)
  final String packageDescription;
  @HiveField(3)
  final String packageTime;
  @HiveField(4)
  final String location;
  @HiveField(5)
  final int? price;
  @HiveField(6)
  final int? remaining;
  @HiveField(7)
  final String? route;

  @HiveField(8)
  final String? packageCover;
  @HiveField(9)
  final String packagePlan;

  // empty constructor
  PackagehomeHiveModel.empty()
      : packageId = '',
        packageName = '',
        packageDescription = '',
        packageTime = '',
        location = '',
        price = 0,
        remaining = 0,
        route = '',
        packageCover = "",
        packagePlan = "";

  PackagehomeHiveModel({
    String? packageId,
    required this.packageName,
    required this.packageDescription,
    required this.packageTime,
    required this.location,
    required this.price,
    required this.remaining,
    required this.route,
    this.packageCover,
    required this.packagePlan,
  }) : packageId = packageId ?? const Uuid().v4();

  // Convert Hive Object to Entity
  PackageEntity toEntity() => PackageEntity(
        packageId: packageId,
        packageName: packageName,
        packageDescription: packageDescription,
        packageTime: packageTime,
        location: location,
        price: price,
        remaining: remaining,
        route: route,
        packageCover: packageCover,
        packagePlan: packagePlan,
      );

  // Convert Entity to Hive Object
  PackagehomeHiveModel toHiveModel(PackageEntity entity) =>
      PackagehomeHiveModel(
        packageId: entity.packageId,
        packageName: entity.packageName,
        packageDescription: entity.packageDescription,
        packageTime: entity.packageTime,
        location: entity.location,
        price: entity.price,
        remaining: entity.remaining,
        route: entity.route,
        packageCover: entity.packageCover,
        packagePlan: entity.packagePlan,
      );

  List<PackagehomeHiveModel> fromApiModelList(
      List<PackagehomeApiModel> apiModels) {
    return apiModels
        .map((apiModel) => PackagehomeHiveModel(
              packageId: apiModel.packageId,
              packageName: apiModel.packageName,
              packageDescription: apiModel.packageDescription,
              packageTime: apiModel.packageTime,
              location: apiModel.location,
              price: apiModel.price,
              remaining: apiModel.remaining,
              route: apiModel.route,
              packageCover: apiModel.packageCover,
              packagePlan: apiModel.packagePlan,
            ))
        .toList();
  }

  // Convert Hive List to Entity List
  List<PackageEntity> toEntityList(List<PackagehomeHiveModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  String toString() {
    return 'PackagehomeHiveModel(packageId: $packageId, packageName: $packageName, packageDescription: $packageDescription, packageTime: $packageTime, location: $location, price: $price, remaining: $remaining, route: $route, packageCover: $packageCover, packagePlan: $packagePlan)';
  }
}
