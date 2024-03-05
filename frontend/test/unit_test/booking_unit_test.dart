
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tripplanner/core/failure/failure.dart';
import 'package:tripplanner/features/booking_requests/domain/entity/booking_request_entity.dart';
import 'package:tripplanner/features/booking_requests/domain/use_case/booking_request_use_case.dart';
import 'package:tripplanner/features/booking_requests/presentation/viewmodel/booking_request_view_model.dart';

import '../../test_data/booking_entity_test.dart';
import 'booking_unit_test.mocks.dart';
@GenerateNiceMocks([
 
  MockSpec<BookingRequestUseCase>(),
])

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late ProviderContainer container;
  late BookingRequestUseCase mockBookingRequestUseCase;
  late List<BookingRequestEntity> bookingRequestEntity;

  setUpAll(() async {
    mockBookingRequestUseCase = MockBookingRequestUseCase();
    bookingRequestEntity = await getBookingRequestsList();
    when(mockBookingRequestUseCase.getBookingRequests())
        .thenAnswer((_) async => Right(bookingRequestEntity));

    container = ProviderContainer(
      overrides: [
        bookingRequestViewModelProvider.overrideWith(
          (ref) => BookingRequestViewModel(mockBookingRequestUseCase),
        )
      ],
    );
  });

  test('check booking initial state', () async {
    await container.read(bookingRequestViewModelProvider.notifier).getBookingRequests();

    final bookingState = container.read(bookingRequestViewModelProvider);
    expect(bookingState.isLoading, false);
    expect(bookingState.bookingRequests, isNotEmpty);
  });

  test('should get booking request', () async {
    when(mockBookingRequestUseCase.getBookingRequests())
        .thenAnswer((_) => Future.value(Right(bookingRequestEntity)));

    await container.read(bookingRequestViewModelProvider.notifier).getBookingRequests();

    final bookingState = container.read(bookingRequestViewModelProvider);

    expect(bookingState.isLoading, false);
    expect(bookingState.bookingRequests.length, 1);
  });

    test('should not get booking request', () async {
    when(mockBookingRequestUseCase.getBookingRequests())
        .thenAnswer((_) => Future.value(Left(Failure(error: 'Invalid'))));

    await container.read(bookingRequestViewModelProvider.notifier).getBookingRequests();

    final watchListState = container.read(bookingRequestViewModelProvider);

    expect(watchListState.isLoading, false);
    expect(watchListState.error, isNotNull);
  });

  tearDownAll(() {
    container.dispose();
  });
}