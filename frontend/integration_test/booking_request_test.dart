// import 'package:dartz/dartz.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:integration_test/integration_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:tripplanner/config/router/app_route.dart';
// import 'package:tripplanner/features/booking_requests/domain/entity/booking_request_entity.dart';
// import 'package:tripplanner/features/booking_requests/domain/use_case/booking_request_use_case.dart';
// import 'package:tripplanner/features/booking_requests/presentation/viewmodel/booking_request_view_model.dart';

// import '../test/unit_test/home_test.mocks.dart';
// import '../test_data/booking_entity_test.dart';

// void main() {
//   IntegrationTestWidgetsFlutterBinding.ensureInitialized();
//   TestWidgetsFlutterBinding.ensureInitialized();
//   late BookingRequestUseCase mockBookingRequestUseCase;
//   late List<BookingRequestEntity> bookingRequestEntity;

//   setUpAll(() async {
//     mockBookingRequestUseCase = MockBookingRequestUseCase();
//     bookingRequestEntity = await getBookingRequestsList();
//   });

//   testWidgets('Booking Request View', (tester) async {
//     when(mockBookingRequestUseCase.getBookingRequests())
//         .thenAnswer((_) async => Right(bookingRequestEntity));

//     await tester.pumpWidget(
//       ProviderScope(
//         overrides: [
//           bookingRequestViewModelProvider
//               .overrideWith((ref) => BookingRequestViewModel(mockBookingRequestUseCase)),
//         ],
//         child: MaterialApp(
//           routes: AppRoute.getApplicationRoute(),
//           initialRoute: AppRoute.exchangeRequestView,
//           debugShowCheckedModeBanner: false,
//         ),
//       ),
//     );

//     await tester.pumpAndSettle();

//     expect(find.text('Booking Requests'), findsOneWidget);
//   });
// }
