import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tripplanner/features/booking_requests/domain/repository/booking_request_repository.dart';

import '../../../../core/failure/failure.dart';
import '../entity/booking_request_entity.dart';

final bookingRequestUsecaseProvider =
    Provider.autoDispose<BookingRequestUseCase>(
  (ref) => BookingRequestUseCase(
    bookingRequestRepository: ref.watch(bookingRequestRepositoryProvider),
  ),
);

class BookingRequestUseCase {
  final IBookingRequestRepository bookingRequestRepository;

  BookingRequestUseCase({required this.bookingRequestRepository});

  Future<Either<Failure, List<BookingRequestEntity>>> getBookingRequests() {
    return bookingRequestRepository.getBookingRequests();
  }

  Future<Either<Failure, bool>> createBookingRequest(
      BookingRequestEntity bookingRequest, String requestedBook) {
    return bookingRequestRepository.createBookingRequest(
        bookingRequest, requestedBook);
  }

  Future<Either<Failure, bool>> acceptBookingRequest(String requestId) {
    return bookingRequestRepository.acceptBookingRequest(requestId);
  }

  Future<Either<Failure, bool>> declineBookingRequest(String requestId) {
    return bookingRequestRepository.declineBookingRequest(requestId);
  }

  Future<Either<Failure, List<BookingRequestEntity>>>
      getAcceptedBookingRequest() {
    return bookingRequestRepository.getAcceptedBookingRequest();
  }
}
