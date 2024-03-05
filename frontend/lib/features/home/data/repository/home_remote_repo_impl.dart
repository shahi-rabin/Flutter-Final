import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tripplanner/features/home/data/data_source/home_local_data_source.dart';
import 'package:tripplanner/features/home/domain/entity/review_entity.dart';

import '../../../../core/common/provider/network_connection.dart';
import '../../../../core/failure/failure.dart';
import '../../domain/entity/package_entity.dart';
import '../../domain/repository/home_repository.dart';
import '../data_source/home_remote_data_source.dart';

final homeRemoteRepoProvider = Provider<IHomeRepository>(
  (ref) => HomeRemoteRepositoryImpl(
    homeRemoteDataSource: ref.read(homeRemoteDataSourceProvider),
    localDataSource: ref.read(homeLocalDataSourceProvider),
  ),
);

class HomeRemoteRepositoryImpl implements IHomeRepository {
  final HomeRemoteDataSource homeRemoteDataSource;
  final HomeLocalDataSource localDataSource;

  HomeRemoteRepositoryImpl({
    required this.homeRemoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, bool>> addPackage(PackageEntity package) {
    return homeRemoteDataSource.addPackage(package);
  }

  @override
  Future<Either<Failure, bool>> deletePackage(String packageId) {
    return homeRemoteDataSource.deletePackage(packageId);
  }

  @override
  Future<Either<Failure, List<PackageEntity>>> getAllPackages() async {
    final a = await checkConnectivity();

    if (a) {
      return await homeRemoteDataSource.getAllPackages();
    } else {
      return localDataSource.getAllPackages();
    }
  }

  @override
  Future<Either<Failure, List<PackageEntity>>> getPackageById(
      String packageId) {
    return homeRemoteDataSource.getPackageById(packageId);
  }

  @override
  Future<Either<Failure, List<PackageEntity>>> getBookmarkedPackages() {
    return homeRemoteDataSource.getBookmarkedPackages();
  }

  @override
  Future<Either<Failure, List<PackageEntity>>> getUserPackages() {
    return homeRemoteDataSource.getUserPackages();
  }

  @override
  Future<Either<Failure, bool>> bookmarkPackage(String packageId) {
    return homeRemoteDataSource.bookmarkPackage(packageId);
  }

  @override
  Future<Either<Failure, bool>> unbookmarkPackage(String packageId) {
    return homeRemoteDataSource.unbookmarkPackage(packageId);
  }

  @override
  Future<Either<Failure, String>> uploadPackageCover(File file) {
    return homeRemoteDataSource.uploadPackageCover(file);
  }

  @override
  Future<Either<Failure, bool>> updatePackage(
      PackageEntity package, String packageId) {
    return homeRemoteDataSource.updatePackage(package, packageId);
  }

  @override
  Future<Either<Failure, List<ReviewEntity>>> get_all_reviews(
      String packageId) {
    return homeRemoteDataSource.get_all_reviews(packageId);
  }

  @override
  Future<Either<Failure, bool>> addReviews(
      String review, String rating, String packageId) {
    return homeRemoteDataSource.addreviews(packageId, review, rating);
  }
}
