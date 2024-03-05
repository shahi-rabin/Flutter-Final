import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tripplanner/features/home/domain/entity/review_entity.dart';

import '../../domain/entity/package_entity.dart';
import '../../domain/use_case/home_use_case.dart';
import '../state/home_state.dart';

final homeViewModelProvider = StateNotifierProvider<HomeViewModel, HomeState>(
  (ref) => HomeViewModel(ref.read(homeUsecaseProvider)),
);

class HomeViewModel extends StateNotifier<HomeState> {
  final HomeUseCase homeUseCase;

  HomeViewModel(this.homeUseCase) : super(HomeState.initial()) {
    getAllPackages();
    getBookmarkedPackages();
    getUserPackages();
  }

  addPackage(PackageEntity package) async {
    state.copyWith(isLoading: true);
    var data = await homeUseCase.addPackage(package);

    data.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.error),
      (r) => state = state.copyWith(isLoading: false, error: null),
    );
  }

  addReviews(review, rating, packageId) async {
    state.copyWith(isLoading: true);
    var data = await homeUseCase.addReviews(review, rating, packageId);

    data.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.error),
      (r) => state = state.copyWith(isLoading: false, error: null),
    );
  }

  updatePackage(PackageEntity package, String packageId) async {
    state = state.copyWith(isLoading: true);
    var data = await homeUseCase.updatePackage(package, packageId);
    state = state.copyWith(isLoading: false);

    data.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.error),
      (r) => state = state.copyWith(isLoading: false, error: null),
    );
  }

  get_all_reviews(String packageId) async {
    state = state.copyWith(isLoading: true);
    var data = await homeUseCase.get_all_reviews(packageId);

    state = state.copyWith(reviews: []);

    data.fold(
        (l) => state = state.copyWith(isLoading: false, error: l.error),
        (r) =>
            state = state.copyWith(isLoading: false, reviews: r, error: null));
  }

  deletePackage(String packageId) async {
    state = state.copyWith(isLoading: true);
    var data = await homeUseCase.deletePackage(packageId);
    state = state.copyWith(isLoading: false);

    data.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.error),
      (r) => state = state.copyWith(isLoading: false, error: null),
    );
  }

  Future<void> uploadPackageCover(File? file) async {
    state = state.copyWith(isLoading: true);
    var data = await homeUseCase.uploadPackageCover(file!);
    data.fold(
      (l) {
        state = state.copyWith(isLoading: false, error: l.error);
      },
      (imageName) {
        state =
            state.copyWith(isLoading: false, error: null, imageName: imageName);
      },
    );
  }

  getAllPackages() async {
    state = state.copyWith(isLoading: true);
    var data = await homeUseCase.getAllPackages();
    state = state.copyWith(packages: []);

    data.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.error),
      (r) => state = state.copyWith(isLoading: false, packages: r, error: null),
    );
  }

  getPackageById(String packageId) async {
    state = state.copyWith(isLoading: true);
    var data = await homeUseCase.getPackageById(packageId);
    state = state.copyWith(packageById: []);

    data.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.error),
      (r) =>
          state = state.copyWith(isLoading: false, packageById: r, error: null),
    );
  }

  getBookmarkedPackages() async {
    state = state.copyWith(isLoading: true);
    var data = await homeUseCase.getBookmarkedPackages();
    state = state.copyWith(bookmarkedPackages: []);

    data.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.error),
      (r) => state =
          state.copyWith(isLoading: false, bookmarkedPackages: r, error: null),
    );
  }

  getUserPackages() async {
    state = state.copyWith(isLoading: true);
    var data = await homeUseCase.getUserPackages();
    state = state.copyWith(userPackages: []);

    data.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.error),
      (r) => state =
          state.copyWith(isLoading: false, userPackages: r, error: null),
    );
  }

  bookmarkPackage(String packageId) async {
    state = state.copyWith(isLoading: true);
    var data = await homeUseCase.bookmarkPackage(packageId);
    state = state.copyWith(isLoading: false);

    data.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.error),
      (r) => state = state.copyWith(isLoading: false, error: null),
    );
  }

  unbookmarkPackage(String packageId) async {
    state = state.copyWith(isLoading: true);
    var data = await homeUseCase.unbookmarkPackage(packageId);
    state = state.copyWith(isLoading: false);

    data.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.error),
      (r) => state = state.copyWith(isLoading: false, error: null),
    );
  }
}
