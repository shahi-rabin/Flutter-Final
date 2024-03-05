

// import 'package:dartz/dartz.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:integration_test/integration_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:tripplanner/config/router/app_route.dart';
// import 'package:tripplanner/features/auth/domain/use_case/auth_usecase.dart';
// import 'package:tripplanner/features/auth/presentation/viewmodel/auth_view_model.dart';
// import 'package:tripplanner/features/booking_requests/domain/entity/booking_request_entity.dart';
// import 'package:tripplanner/features/booking_requests/domain/use_case/booking_request_use_case.dart';
// import 'package:tripplanner/features/home/domain/entity/package_entity.dart';
// import 'package:tripplanner/features/home/domain/use_case/home_use_case.dart';
// import 'package:tripplanner/features/home/presentation/viewmodel/home_view_model.dart';
// import 'package:tripplanner/features/user_profile/domain/entity/profile_entity.dart';
// import 'package:tripplanner/features/user_profile/domain/use_case/profile_use_case.dart';
// import 'package:tripplanner/features/user_profile/presentation/viewmodel/profile_view_model.dart';

// import '../test/unit_test/auth_test.mocks.dart';
// import '../test/unit_test/home_test.mocks.dart';
// import '../test_data/booking_entity_test.dart';
// import '../test_data/package_entity_test.dart';
// import '../test_data/profile_entity_test.dart';

// void main() {
//   IntegrationTestWidgetsFlutterBinding.ensureInitialized();
//   TestWidgetsFlutterBinding.ensureInitialized();

//   late AuthUseCase mockAuthUsecase;
//   late HomeUseCase mockHomeUseCase;
//   late BookingRequestUseCase mockBookingRequestUseCase;
//   late List<PackageEntity> allPackages;
//   late List<PackageEntity> userPackages;
//   late List<PackageEntity> bookmarkedPackages;
//   late List<ProfileEntity> profileEntity;
//   late List<BookingRequestEntity> bookingRequestEntity;
//   late ProfileUseCase mockProfileUseCase;
//   late bool isLogin;

//   setUpAll(() async {
//     mockAuthUsecase = MockAuthUseCase();
//     mockHomeUseCase = MockHomeUseCase();
//     mockBookingRequestUseCase = MockBookingRequestUseCase();
//     mockProfileUseCase = MockProfileUseCase();
//     allPackages = await getAllPackages();
//     userPackages = await getUserPackages();
//     bookmarkedPackages = await getBookmarkedPackages();
//     profileEntity = await getProfileTest();
//     bookingRequestEntity = await getBookingRequestsList();
//     isLogin = true;
//   });

//   testWidgets('login test with username and password and open dashboard',
//       (tester) async {
//     when(mockAuthUsecase.loginUser('nischal', 'nischal'))
//         .thenAnswer((_) async => Right(isLogin));
//     when(mockHomeUseCase.getAllPackages())
//         .thenAnswer((_) async => Right(allPackages));
//     when(mockHomeUseCase.getUserPackages())
//         .thenAnswer((_) async => Right(userPackages));
//     when(mockHomeUseCase.getBookmarkedPackages())
//         .thenAnswer((_) async => Right(bookmarkedPackages));
//     when(mockProfileUseCase.getUserInfo())
//         .thenAnswer((_) async => Right(profileEntity));
//     when(mockBookingRequestUseCase.getBookingRequests())
//         .thenAnswer((_) async => Right(bookingRequestEntity));

//     await tester.pumpWidget(
//       ProviderScope(
//         overrides: [
//           authViewModelProvider
//               .overrideWith((ref) => AuthViewModel(mockAuthUsecase)),
//           homeViewModelProvider
//               .overrideWith((ref) => HomeViewModel(mockHomeUseCase)),
//           profileViewModelProvider
//               .overrideWith((ref) => ProfileViewModel(mockProfileUseCase)),
//         ],
//         child: MaterialApp(
//           initialRoute: AppRoute.loginRoute,
//           routes: AppRoute.getApplicationRoute(),
//         ),
//       ),
//     );

//     await tester.pumpAndSettle();

//     await tester.enterText(find.byType(TextFormField).at(0), 'nischal');
//     await tester.enterText(find.byType(TextFormField).at(1), 'nischal');

//     final loginbuttonFinder = find.widgetWithText(ElevatedButton, 'Login');

//     await tester.dragUntilVisible(
//       loginbuttonFinder,
//       find.byType(SingleChildScrollView),
//       const Offset(201.4, 574.7),
//     );

//     await tester.tap(loginbuttonFinder);

//     await tester.pumpAndSettle();

//     expect(find.text('SwapReads'), findsOneWidget);
//   });
// }
