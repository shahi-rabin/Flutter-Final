import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tripplanner/features/booking_requests/data/data_source/booking_request_remote_data_source.dart';
import 'package:tripplanner/features/booking_requests/domain/repository/booking_request_repository.dart';

import '../../../../core/failure/failure.dart';
import '../../domain/entity/booking_request_entity.dart';

final bookingRequestRemoteRepoProvider = Provider<IBookingRequestRepository>(
  (ref) => BookingRequestRemoteRepositoryImpl(
    bookingRequestRemoteDataSource:
        ref.read(bookingRequestRemoteDataSourceProvider),
  ),
);

class BookingRequestRemoteRepositoryImpl implements IBookingRequestRepository {
  final BookingRequestRemoteDataSource bookingRequestRemoteDataSource;

  BookingRequestRemoteRepositoryImpl(
      {required this.bookingRequestRemoteDataSource});

  @override
  Future<Either<Failure, List<BookingRequestEntity>>> getBookingRequests() {
    return bookingRequestRemoteDataSource.getBookingRequests();
  }

  @override
  Future<Either<Failure, bool>> createBookingRequest(
      BookingRequestEntity bookingRequest, String requestedBook) {
    return bookingRequestRemoteDataSource.createBookingRequest(
        bookingRequest, requestedBook);
  }

  @override
  Future<Either<Failure, bool>> acceptBookingRequest(String requestId) {
    return bookingRequestRemoteDataSource.acceptBookingRequest(requestId);
  }

  @override
  Future<Either<Failure, bool>> declineBookingRequest(String requestId) {
    return bookingRequestRemoteDataSource.declineBookingRequest(requestId);
  }

  @override
  Future<Either<Failure, List<BookingRequestEntity>>>
      getAcceptedBookingRequest() {
    return bookingRequestRemoteDataSource.getAcceptedBookingRequests();
  }
}
