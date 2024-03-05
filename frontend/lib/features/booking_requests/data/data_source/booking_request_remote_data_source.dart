import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/constants/api_endpoint.dart';
import '../../../../core/failure/failure.dart';
import '../../../../core/network/remote/http_service.dart';
import '../../../../core/shared_prefs/user_shared_prefs.dart';
import '../../domain/entity/booking_request_entity.dart';
import '../dto/get_booking_requests_dto.dart';
import '../model/booking_request_api_model.dart';

final bookingRequestRemoteDataSourceProvider = Provider(
  (ref) => BookingRequestRemoteDataSource(
    dio: ref.read(httpServiceProvider),
    bookingRequestApiModel: ref.read(bookingRequestApiModelProvider),
    userSharedPrefs: ref.read(userSharedPrefsProvider),
  ),
);

class BookingRequestRemoteDataSource {
  final Dio dio;
  final BookingRequestApiModel bookingRequestApiModel;
  final UserSharedPrefs userSharedPrefs;

  BookingRequestRemoteDataSource({
    required this.dio,
    required this.bookingRequestApiModel,
    required this.userSharedPrefs,
  });

  Future<Either<Failure, List<BookingRequestEntity>>>
      getBookingRequests() async {
    try {
      String? token;
      await userSharedPrefs.getUserToken().then(
            (value) => value.fold((l) => null, (r) => token = r),
          );

      var response = await dio.get(
        ApiEndpoints.getBookingRequests,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      
      if (response.statusCode == 200) {
        print("asd");
        print(response.data);
        GetBookingRequestsDTO bookingAddDTO =
            GetBookingRequestsDTO.fromJson(response.data);
          print(bookingAddDTO.data);
        return Right(bookingRequestApiModel.toEntityList(bookingAddDTO.data));
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

  Future<Either<Failure, bool>> createBookingRequest(
      BookingRequestEntity bookingRequest, String requestedPackage) async {
    try {
      String? token;
      await userSharedPrefs.getUserToken().then(
            (value) => value.fold((l) => null, (r) => token = r),
          );
      
      var response = await dio.post(
        ApiEndpoints.createBookingRequest(requestedPackage),
        data: {
          "requestedPackage": requestedPackage,
          "email": bookingRequest.email,
          "contactNum": bookingRequest.contactNum,
          "furtherRequirements": bookingRequest.furtherRequirements,

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

  Future<Either<Failure, bool>> acceptBookingRequest(String requestId) async {
    try {
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r!,
      );

      var response = await dio.put(
        ApiEndpoints.acceptBookingRequest(requestId),
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

  Future<Either<Failure, bool>> declineBookingRequest(String requestId) async {
    try {
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r!,
      );

      var response = await dio.delete(
        ApiEndpoints.declineBookingRequest(requestId),
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

  Future<Either<Failure, List<BookingRequestEntity>>>
      getAcceptedBookingRequests() async {
    try {
      String? token;
      await userSharedPrefs.getUserToken().then(
            (value) => value.fold((l) => null, (r) => token = r),
          );

      var response = await dio.get(
        ApiEndpoints.getAcceptedBookingRequest,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      
      if (response.statusCode == 200) {
        print("asd");
        print(response.data);
        GetBookingRequestsDTO bookingAddDTO =
            GetBookingRequestsDTO.fromJson(response.data);
          print(bookingAddDTO.data);
        return Right(bookingRequestApiModel.toEntityList(bookingAddDTO.data));
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
