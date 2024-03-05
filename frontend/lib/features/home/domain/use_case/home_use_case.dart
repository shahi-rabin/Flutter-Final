import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tripplanner/features/home/domain/entity/review_entity.dart';

import '../../../../core/failure/failure.dart';
import '../entity/package_entity.dart';
import '../repository/home_repository.dart';

final homeUsecaseProvider = Provider.autoDispose<HomeUseCase>(
  (ref) => HomeUseCase(
    homeRepository: ref.watch(homeRepositoryProvider),
  ),
);

class HomeUseCase {
  final IHomeRepository homeRepository;

  HomeUseCase({required this.homeRepository});

  Future<Either<Failure, List<PackageEntity>>> getAllPackages() {
    return homeRepository.getAllPackages();
  }

  Future<Either<Failure, List<PackageEntity>>> getPackageById(
      String packageId) {
    return homeRepository.getPackageById(packageId);
  }

  Future<Either<Failure, List<PackageEntity>>> getBookmarkedPackages() {
    return homeRepository.getBookmarkedPackages();
  }

  Future<Either<Failure, List<PackageEntity>>> getUserPackages() {
    return homeRepository.getUserPackages();
  }

  Future<Either<Failure, bool>> addPackage(PackageEntity package) {
    return homeRepository.addPackage(package);
  }

  Future<Either<Failure, bool>> updatePackage(
      PackageEntity package, String packageId) {
    return homeRepository.updatePackage(package, packageId);
  }

  Future<Either<Failure, bool>> deletePackage(String packageId) {
    return homeRepository.deletePackage(packageId);
  }

  Future<Either<Failure, String>> uploadPackageCover(File file) async {
    return await homeRepository.uploadPackageCover(file);
  }

  Future<Either<Failure, bool>> bookmarkPackage(String packageId) {
    return homeRepository.bookmarkPackage(packageId);
  }

  Future<Either<Failure, bool>> unbookmarkPackage(String packageId) {
    return homeRepository.unbookmarkPackage(packageId);
  }

  Future<Either<Failure, List<ReviewEntity>>> get_all_reviews(
      String packageId) {
    return homeRepository.get_all_reviews(packageId);
  }

  Future<Either<Failure, bool>> addReviews(
      String review, String rating, String packageId) {
    return homeRepository.addReviews(review, rating, packageId);
  }
}
