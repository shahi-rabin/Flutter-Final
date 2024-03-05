import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tripplanner/core/failure/failure.dart';
import 'package:tripplanner/features/booking_requests/domain/use_case/booking_request_use_case.dart';
import 'package:tripplanner/features/home/domain/entity/package_entity.dart';
import 'package:tripplanner/features/home/domain/use_case/home_use_case.dart';
import 'package:tripplanner/features/home/presentation/viewmodel/home_view_model.dart';
import 'package:tripplanner/features/user_profile/domain/use_case/profile_use_case.dart';


import '../../test_data/package_entity_test.dart';
import 'home_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<HomeUseCase>(),
  MockSpec<ProfileUseCase>(),
  MockSpec<BookingRequestUseCase>(),
])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late ProviderContainer container;
  late HomeUseCase mockHomeUsecase;
  late ProfileUseCase mockProfileUsecase;
  late BookingRequestUseCase mockBookingRequestUsecase;
  late List<PackageEntity> homeEntity;

  setUpAll(() async {
    mockHomeUsecase = MockHomeUseCase();
    mockProfileUsecase = MockProfileUseCase();
    mockBookingRequestUsecase = MockBookingRequestUseCase();
    homeEntity = await getAllPackages();

    when(mockHomeUsecase.getAllPackages())
        .thenAnswer((_) async => const Right([]));
    when(mockHomeUsecase.getUserPackages())
        .thenAnswer((_) async => const Right([]));
    when(mockHomeUsecase.getBookmarkedPackages())
        .thenAnswer((_) async => const Right([]));
    when(mockProfileUsecase.getUserInfo())
        .thenAnswer((_) async => const Right([]));
    when(mockBookingRequestUsecase.getBookingRequests())
        .thenAnswer((_) async => const Right([]));

    container = ProviderContainer(
      overrides: [
        homeViewModelProvider.overrideWith(
          (ref) => HomeViewModel(mockHomeUsecase),
        ),
      ],
    );
  });

  test('check home initial state', () async {
    await container.read(homeViewModelProvider.notifier).getAllPackages();
    final homeState = container.read(homeViewModelProvider);

    expect(homeState.isLoading, false);
    expect(homeState.packages, isEmpty);
  });

  test('check for the list of packages when calling getAllPackages', () async {
    when(mockHomeUsecase.getAllPackages())
        .thenAnswer((_) => Future.value(Right(homeEntity)));

    await container.read(homeViewModelProvider.notifier).getAllPackages();

    final homeState = container.read(homeViewModelProvider);

    expect(homeState.isLoading, false);
    expect(homeState.packages, isNotEmpty);
  });

  test('add home entity and return true if sucessfully added', () async {
    when(mockHomeUsecase.addPackage(homeEntity[0]))
        .thenAnswer((_) => Future.value(const Right(true)));

    await container.read(homeViewModelProvider.notifier).addPackage(homeEntity[0]);

    final homeState = container.read(homeViewModelProvider);

    expect(homeState.error, isNull);
  });

  test('should not get packages when added', () async {
    when(mockHomeUsecase.getAllPackages())
        .thenAnswer((_) => Future.value(Left(Failure(error: 'Invalid'))));

    await container.read(homeViewModelProvider.notifier).getAllPackages();

    final homeState = container.read(homeViewModelProvider);

    expect(homeState.error, 'Invalid');
    // to fail the test, we have to write isNull instead of isNotNull
  });

  test('check for the list of packages by posted by user', () async {
    when(mockHomeUsecase.getUserPackages())
        .thenAnswer((_) => Future.value(Right(homeEntity)));

    await container.read(homeViewModelProvider.notifier).getUserPackages();

    final homeState = container.read(homeViewModelProvider);

    expect(homeState.isLoading, false);
    expect(homeState.userPackages, isNotEmpty);
  });

  test('should get list of packages by id', () async {
    when(mockHomeUsecase.getPackageById("12"))
        .thenAnswer((_) => Future.value(Right([homeEntity[0]])));

    await container.read(homeViewModelProvider.notifier).getPackageById("12");

    final homeState = container.read(homeViewModelProvider);

    expect(homeState.isLoading, false);
    expect(homeState.packageById.length, 1);
  });

  test('should get packagemarked packages', () async {
    when(mockHomeUsecase.getBookmarkedPackages())
        .thenAnswer((_) => Future.value(Right(homeEntity)));

    await container.read(homeViewModelProvider.notifier).getBookmarkedPackages();

    final homeState = container.read(homeViewModelProvider);

    expect(homeState.isLoading, false);
    expect(homeState.bookmarkedPackages, isNotEmpty);
  });

  tearDownAll(() {
    container.dispose();
  });
}
