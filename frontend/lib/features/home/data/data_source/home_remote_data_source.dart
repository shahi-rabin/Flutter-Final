import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tripplanner/features/home/data/dto/get_all_reviews_dto.dart';
import 'package:tripplanner/features/home/data/model/review_api_model.dart';
import 'package:tripplanner/features/home/domain/entity/review_entity.dart';

import '../../../../config/constants/api_endpoint.dart';
import '../../../../core/failure/failure.dart';
import '../../../../core/network/remote/http_service.dart';
import '../../../../core/shared_prefs/user_shared_prefs.dart';
import '../../domain/entity/package_entity.dart';
import '../dto/get_all_packages_dto.dart';
import '../dto/get_package_by_id_dto.dart';
import '../dto/get_bookmarked_packages_dto.dart';
import '../dto/get_user_packages_dto.dart';
import '../model/packagehome_api_model.dart';
import '../model/home_hive_model.dart';

final homeRemoteDataSourceProvider = Provider(
  (ref) => HomeRemoteDataSource(
    dio: ref.read(httpServiceProvider),
    reviewApiModel: ref.read(reviewApiModelProvider),
    homeApiModel: ref.read(packagehomeApiModelProvider),
    homeHiveModel: ref.read(packagehomeHiveModelProvider),
    userSharedPrefs: ref.read(userSharedPrefsProvider),
  ),
);

class HomeRemoteDataSource {
  final Dio dio;
  final PackagehomeApiModel homeApiModel;
  final ReviewApiModel reviewApiModel;
  final PackagehomeHiveModel homeHiveModel;
  final UserSharedPrefs userSharedPrefs;

  HomeRemoteDataSource({
    required this.dio,
    required this.reviewApiModel,
    required this.homeApiModel,
    required this.homeHiveModel,
    required this.userSharedPrefs,
  });

  Future<Either<Failure, bool>> addPackage(PackageEntity package) async {
    try {
      String? token;
      await userSharedPrefs.getUserToken().then(
            (value) => value.fold((l) => null, (r) => token = r),
          );
      print("sdfsdfs");
      print(package);

      var response = await dio.post(
        ApiEndpoints.addPackage,
        data: {
          "package_name": package.packageName,
          "package_description": package.packageDescription,
          "package_time": package.packageTime,
          "location": package.location,
          "price": package.price,
          "remaining": package.remaining,
          "route": package.route,
          "package_plan": package.packagePlan,
          "package_cover": package.packageCover,
          "destination_name": package.destinationName,
        },
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      if (response.statusCode == 201) {
        return const Right(true);
      } else {
        return Left(
          Failure(
            error: response.data['message'],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.message.toString(),
        ),
      );
    }
  }

  Future<Either<Failure, bool>> updatePackage(
      PackageEntity package, String packageId) async {
    try {
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r!,
      );

      var response = await dio.put(
        ApiEndpoints.updatePackage(packageId),
        data: {
          "package_name": package.packageName,
          "package_description": package.packageDescription,
          "package_time": package.packageTime,
          "location": package.location,
          "package_plan": package.packagePlan,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 204) {
        // Profile edited successfully
        return const Right(true);
      } else {
        return Left(
          Failure(
            error: 'Failed to update package. Please try again.',
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
        ),
      );
    }
  }

  Future<Either<Failure, bool>> deletePackage(String packageId) async {
    try {
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r!,
      );

      var response = await dio.delete(
        ApiEndpoints.deletePackage(packageId),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return Left(
          Failure(
            error: response.data['message'],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
        ),
      );
    }
  }

  // Upload image using multipart
  Future<Either<Failure, String>> uploadPackageCover(
    File image,
  ) async {
    try {
      String? token;
      await userSharedPrefs.getUserToken().then(
            (value) => value.fold((l) => null, (r) => token = r!),
          );
      String fileName = image.path.split('/').last;
      FormData formData = FormData.fromMap(
        {
          'profilePicture': await MultipartFile.fromFile(
            image.path,
            filename: fileName,
          ),
        },
      );

      Response response = await dio.post(
        ApiEndpoints.uploadPackageCover,
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      return Right(response.data["data"]);
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }

  Future<Either<Failure, List<PackageEntity>>> getAllPackages() async {
    try {
      String? token;
      await userSharedPrefs.getUserToken().then(
            (value) => value.fold((l) => null, (r) => token = r),
          );

      var response = await dio.get(
        ApiEndpoints.getAllPackages,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      if (response.statusCode == 200) {
        GetAllPackagesDTO homeAddDTO =
            GetAllPackagesDTO.fromJson(response.data);

        final packageEntities = homeApiModel.toEntityList(homeAddDTO.data);

        final packageHiveModels =
            homeHiveModel.fromApiModelList(homeAddDTO.data);

        var directory = await getApplicationDocumentsDirectory();
        Hive.init(directory.path);

        final box = await Hive.openBox<PackagehomeHiveModel>('packageBox');

        box.clear();
        box.addAll(packageHiveModels);

        return Right(packageEntities);
      } else {
        return Left(
          Failure(
            error: response.statusMessage.toString(),
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
        ),
      );
    }
  }

  Future<Either<Failure, List<PackageEntity>>> getPackageById(
      String packageId) async {
    try {
      String? token;
      await userSharedPrefs.getUserToken().then(
            (value) => value.fold((l) => null, (r) => token = r),
          );

      var response = await dio.get(
        ApiEndpoints.getPackageById(packageId),
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      if (response.statusCode == 200) {
        GetPackageByIdDTO homeAddDTO =
            GetPackageByIdDTO.fromJson(response.data);
        return Right(homeApiModel.toEntityList(homeAddDTO.data));
      } else {
        return Left(
          Failure(
            error: response.statusMessage.toString(),
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
        ),
      );
    }
  }

  Future<Either<Failure, List<PackageEntity>>> getBookmarkedPackages() async {
    try {
      String? token;
      await userSharedPrefs.getUserToken().then(
            (value) => value.fold((l) => null, (r) => token = r),
          );

      var response = await dio.get(
        ApiEndpoints.getBookmarkedPackages,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      if (response.statusCode == 200) {
        GetBookmarkedPackagesDTO profileAddDTO =
            GetBookmarkedPackagesDTO.fromJson(response.data);
        return Right(homeApiModel.toEntityList(profileAddDTO.data));
      } else {
        return Left(
          Failure(
            error: response.statusMessage.toString(),
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
        ),
      );
    }
  }

  Future<Either<Failure, List<PackageEntity>>> getUserPackages() async {
    try {
      String? token;
      await userSharedPrefs.getUserToken().then(
            (value) => value.fold((l) => null, (r) => token = r),
          );

      var response = await dio.get(
        ApiEndpoints.getUserPackages,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      if (response.statusCode == 200) {
        GetUserPackagesDTO profileAddDTO =
            GetUserPackagesDTO.fromJson(response.data);
        return Right(homeApiModel.toEntityList(profileAddDTO.data));
      } else {
        return Left(
          Failure(
            error: response.statusMessage.toString(),
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
        ),
      );
    }
  }

  Future<Either<Failure, bool>> bookmarkPackage(String packageId) async {
    try {
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r!,
      );

      var response = await dio.post(
        ApiEndpoints.bookmarkPackage(packageId),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return Left(
          Failure(
            error: response.data['message'],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
        ),
      );
    }
  }

  Future<Either<Failure, List<ReviewEntity>>> get_all_reviews(
      String packageId) async {
    try {
      String? token;
      await userSharedPrefs.getUserToken().then(
            (value) => value.fold((l) => null, (r) => token = r),
          );

      var response = await dio.get(
        ApiEndpoints.get_all_reviews(packageId),
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      if (response.statusCode == 200) {
        GetAllReviewsDTO reviewAddDTO =
            GetAllReviewsDTO.fromJson(response.data);

        return Right(reviewApiModel.toEntityList(reviewAddDTO.reviews));
      } else {
        return Left(
          Failure(
            error: response.statusMessage.toString(),
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
        ),
      );
    }
  }

  Future<Either<Failure, bool>> addreviews(
      String packageId, String review, String rating) async {
    try {
      String? token;
      await userSharedPrefs.getUserToken().then(
            (value) => value.fold((l) => null, (r) => token = r),
          );

      var response = await dio.post(
        ApiEndpoints.addReview(packageId),
        data: {
          "review": review,
          "ratings": rating,
        },
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return Left(
          Failure(
            error: response.statusMessage.toString(),
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
        ),
      );
    }
  }

  Future<Either<Failure, bool>> unbookmarkPackage(String packageId) async {
    try {
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r!,
      );

      var response = await dio.delete(
        ApiEndpoints.bookmarkPackage(packageId),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return Left(
          Failure(
            error: response.data['message'],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
        ),
      );
    }
  }
}
