import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tripplanner/features/home/domain/entity/review_entity.dart';

import '../../../../core/failure/failure.dart';
import '../../domain/entity/package_entity.dart';
import '../../domain/repository/home_repository.dart';
import '../data_source/home_local_data_source.dart';

final homeLocalRepoProvider = Provider<IHomeRepository>((ref) {
  return HomeLocalRepositoryImpl(
    homeLocalDataSource: ref.read(homeLocalDataSourceProvider),
  );
});

class HomeLocalRepositoryImpl implements IHomeRepository {
  final HomeLocalDataSource homeLocalDataSource;

  HomeLocalRepositoryImpl({required this.homeLocalDataSource});
  @override
  Future<Either<Failure, bool>> addPackage(PackageEntity package) {
    return homeLocalDataSource.addPackage(package);
  }

  @override
  Future<Either<Failure, List<PackageEntity>>> getAllPackages() {
    return homeLocalDataSource.getAllPackages();
  }

  @override
  Future<Either<Failure, List<PackageEntity>>> getBookmarkedPackages() {
    return homeLocalDataSource.getBookmarkedPackages();
  }

  @override
  Future<Either<Failure, List<PackageEntity>>> getUserPackages() {
    return homeLocalDataSource.getUserPackages();
  }

  @override
  Future<Either<Failure, bool>> bookmarkPackage(String packageId) {
    // TODO: implement bookmarkPackage
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> uploadPackageCover(File file) async {
    return const Right("");
  }

  @override
  Future<Either<Failure, bool>> unbookmarkPackage(String packageId) {
    // TODO: implement unbookmarkPackage
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<PackageEntity>>> getPackageById(
      String packageId) {
    // TODO: implement getPackageById
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> deletePackage(String packageId) {
    // TODO: implement deletePackage
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> updatePackage(
      PackageEntity package, String packageId) {
    // TODO: implement updatePackage
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<ReviewEntity>>> get_all_reviews(
      String packakeId) {
    // TODO: implement get_all_reviews
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> addReviews(
      String review, String rating, String packageId) {
    // TODO: implement addReview
    throw UnimplementedError();
  }
}
