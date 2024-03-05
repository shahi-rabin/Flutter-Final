import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tripplanner/features/home/data/model/packagehome_api_model.dart';

import '../../../../config/constants/api_endpoint.dart';
import '../../../../core/failure/failure.dart';
import '../../../../core/network/remote/http_service.dart';
import '../../../../core/shared_prefs/user_shared_prefs.dart';
import '../../../home/domain/entity/package_entity.dart';
import '../dto/get_searched_packages_dto.dart';

final searchRemoteDataSourceProvider = Provider(
  (ref) => SearchRemoteDataSource(
    dio: ref.read(httpServiceProvider),
    packagehomeApiModel: ref.read(packagehomeApiModelProvider),
    userSharedPrefs: ref.read(userSharedPrefsProvider),
  ),
);

class SearchRemoteDataSource {
  final Dio dio;
  final PackagehomeApiModel packagehomeApiModel;
  final UserSharedPrefs userSharedPrefs;

  SearchRemoteDataSource({
    required this.dio,
    required this.packagehomeApiModel,
    required this.userSharedPrefs,
  });

  Future<Either<Failure, List<PackageEntity>>> getSearchedPackages(
      String searchQuery) async {
    try {
      String? token;
      await userSharedPrefs.getUserToken().then(
            (value) => value.fold((l) => null, (r) => token = r),
          );

      var response = await dio.get(
        ApiEndpoints.searchPackages,
        queryParameters: {'query': searchQuery},
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      if (response.statusCode == 200) {
        // OR
        // 2nd way
        print(response.data);
        GetSearchedPackagesDTO homeAddDTO =
            GetSearchedPackagesDTO.fromJson(response.data);

        return Right(packagehomeApiModel.toEntityList(homeAddDTO.data));
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
}
