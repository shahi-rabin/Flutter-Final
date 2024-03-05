import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tripplanner/features/booking_requests/domain/use_case/booking_request_use_case.dart';
import 'package:tripplanner/features/booking_requests/presentation/state/booking_request_state.dart';

import '../../domain/entity/booking_request_entity.dart';

final bookingRequestViewModelProvider =
    StateNotifierProvider<BookingRequestViewModel, BookingRequestState>(
  (ref) => BookingRequestViewModel(ref.read(bookingRequestUsecaseProvider)),
);

class BookingRequestViewModel extends StateNotifier<BookingRequestState> {
  final BookingRequestUseCase bookingRequestUseCase;

  BookingRequestViewModel(this.bookingRequestUseCase)
      : super(BookingRequestState.initial()) {
    getBookingRequests();
  }

  getBookingRequests() async {
    state = state.copyWith(isLoading: true);
    var data = await bookingRequestUseCase.getBookingRequests();

    data.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.error),
      (r) => state =
          state.copyWith(isLoading: false, bookingRequests: r, error: null),
    );
  }

  createBookingRequest(
      BookingRequestEntity bookingRequest, String requestedPackage) async {
    state = state.copyWith(isLoading: true);
    var data = await bookingRequestUseCase.createBookingRequest(
        bookingRequest, requestedPackage);
    state = state.copyWith(isLoading: false);

    data.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.error),
      (r) => state = state.copyWith(isLoading: false, error: null),
    );
  }

  acceptBookingRequest(String requestId) async {
    state = state.copyWith(isLoading: true);
    var data = await bookingRequestUseCase.acceptBookingRequest(requestId);
    state = state.copyWith(isLoading: false);

    data.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.error),
      (r) => state = state.copyWith(isLoading: false, error: null),
    );
  }

  declineBookingRequest(String requestId) async {
    state = state.copyWith(isLoading: true);
    var data = await bookingRequestUseCase.declineBookingRequest(requestId);
    state = state.copyWith(isLoading: false);

    data.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.error),
      (r) => state = state.copyWith(isLoading: false, error: null),
    );
  }

  getAcceptedBookingRequest() async {
    state = state.copyWith(isLoading: true);
    var data = await bookingRequestUseCase.getAcceptedBookingRequest();

    data.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.error),
      (r) => state =
          state.copyWith(isLoading: false, bookingRequests: r, error: null),
    );
  }
}
