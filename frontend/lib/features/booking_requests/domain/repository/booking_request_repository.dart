import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tripplanner/features/booking_requests/data/repository/booking_request_remote_repo_impl.dart';

import '../../../../core/common/provider/internet_connectivity.dart';
import '../../../../core/failure/failure.dart';

import '../entity/booking_request_entity.dart';

final bookingRequestRepositoryProvider =
    Provider.autoDispose<IBookingRequestRepository>(
  (ref) {
    // return ref.watch(batchLocalRepoProvider);
    // // Check for the internet
    final internetStatus = ref.watch(connectivityStatusProvider);

    return ref.watch(bookingRequestRemoteRepoProvider);

    // if (ConnectivityStatus.isConnected == internetStatus) {
    //   // If internet is available then return remote repo
    //   return ref.watch(bookingRequestRemoteRepoProvider);
    // } else {
    //   // If internet is not available then return local repo
    //   return ref.watch(bookingRequestLocalRepoProvider);
    // }
  },
);

abstract class IBookingRequestRepository {
  Future<Either<Failure, List<BookingRequestEntity>>> getBookingRequests();
  Future<Either<Failure, bool>> createBookingRequest(
      BookingRequestEntity bookingRequest, String requestedBook);
  Future<Either<Failure, bool>> acceptBookingRequest(String requestId);
  Future<Either<Failure, bool>> declineBookingRequest(String requestId);
  Future<Either<Failure, List<BookingRequestEntity>>>
      getAcceptedBookingRequest();
}
