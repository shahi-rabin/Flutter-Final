import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../../../../core/network/local/hive_service.dart';
import '../../domain/entity/package_entity.dart';
import '../model/home_hive_model.dart';

// Dependency Injection using Riverpod
final homeLocalDataSourceProvider = Provider<HomeLocalDataSource>((ref) {
  return HomeLocalDataSource(
      hiveService: ref.read(hiveServiceProvider),
      packagehomeHiveModel: ref.read(packagehomeHiveModelProvider));
});

class HomeLocalDataSource {
  final HiveService hiveService;
  final PackagehomeHiveModel packagehomeHiveModel;

  HomeLocalDataSource({
    required this.hiveService,
    required this.packagehomeHiveModel,
  });

  // Add Batch
  Future<Either<Failure, bool>> addPackage(PackageEntity package) async {
    try {
      // Convert Entity to Hive Object
      final hivePackage = packagehomeHiveModel.toHiveModel(package);
      // Add to Hive
      await hiveService.addPackage(hivePackage);
      return const Right(true);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }

  Future<Either<Failure, List<PackageEntity>>> getAllPackages() async {
    try {
      // Get all batches from Hive
      final packages = await hiveService.getAllPackages();
      // Convert Hive Object to Entity
      final homeEntities = packagehomeHiveModel.toEntityList(packages);
      print(homeEntities);
      return Right(homeEntities);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }

  Future<Either<Failure, List<PackageEntity>>> getBookmarkedPackages() async {
    try {
      // Get all batches from Hive
      final packages = await hiveService.getBookmarkedPackages();
      // Convert Hive Object to Entity
      final homeEntities = packagehomeHiveModel.toEntityList(packages);
      return Right(homeEntities);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }

  Future<Either<Failure, List<PackageEntity>>> getUserPackages() async {
    try {
      // Get all batches from Hive
      final packages = await hiveService.getUserPackages();
      // Convert Hive Object to Entity
      final homeEntities = packagehomeHiveModel.toEntityList(packages);
      return Right(homeEntities);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }
}
