import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tripplanner/features/home/domain/entity/package_entity.dart';
import 'package:tripplanner/features/home/domain/entity/review_entity.dart';

import '../../../../core/failure/failure.dart';
import '../../data/repository/home_remote_repo_impl.dart';

final homeRepositoryProvider = Provider.autoDispose<IHomeRepository>(
  (ref) {
    return ref.watch(homeRemoteRepoProvider);
  },
);

abstract class IHomeRepository {
  Future<Either<Failure, List<PackageEntity>>> getAllPackages();
  Future<Either<Failure, List<PackageEntity>>> getPackageById(String bookId);
  Future<Either<Failure, List<PackageEntity>>> getBookmarkedPackages();
  Future<Either<Failure, List<PackageEntity>>> getUserPackages();
  Future<Either<Failure, bool>> addPackage(PackageEntity book);
  Future<Either<Failure, bool>> updatePackage(
      PackageEntity book, String bookId);
  Future<Either<Failure, bool>> deletePackage(String bookId);
  Future<Either<Failure, String>> uploadPackageCover(File file);
  Future<Either<Failure, bool>> bookmarkPackage(String bookId);
  Future<Either<Failure, bool>> unbookmarkPackage(String bookId);
  Future<Either<Failure, List<ReviewEntity>>> get_all_reviews(String packageId);
  Future<Either<Failure, bool>> addReviews(
      String review, String rating, String packageId);
}
