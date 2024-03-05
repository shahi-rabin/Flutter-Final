import '../../domain/entity/booking_request_entity.dart';

class BookingRequestState {
  final bool isLoading;
  final List<BookingRequestEntity> bookingRequests;
  final String? error;

  BookingRequestState({
    required this.isLoading,
    required this.bookingRequests,
    this.error,
  });

  factory BookingRequestState.initial() {
    return BookingRequestState(isLoading: false, bookingRequests: []);
  }

  BookingRequestState copyWith({
    bool? isLoading,
    List<BookingRequestEntity>? bookingRequests,
    String? error,
  }) {
    return BookingRequestState(
      isLoading: isLoading ?? this.isLoading,
      bookingRequests: bookingRequests ?? this.bookingRequests,
      error: error ?? this.error,
    );
  }
}
