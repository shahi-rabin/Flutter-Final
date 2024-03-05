import 'package:tripplanner/features/home/domain/entity/review_entity.dart';

import '../../domain/entity/package_entity.dart';

class HomeState {
  final bool isLoading;
  final List<PackageEntity> packages;
  final List<PackageEntity> bookmarkedPackages;
  final List<ReviewEntity>? reviews;
  final List<PackageEntity> userPackages;
  final List<PackageEntity> packageById;
  final String? error;
  final String? imageName;

  HomeState({
    required this.isLoading,
    required this.reviews,
    required this.packages,
    required this.bookmarkedPackages,
    required this.userPackages,
    required this.packageById,
    this.error,
    this.imageName,
  });

  factory HomeState.initial() {
    return HomeState(
      isLoading: false,
      reviews: [],
      packages: [],
      bookmarkedPackages: [],
      userPackages: [],
      packageById: [],
      error: null,
      imageName: null,
    );
  }

  HomeState copyWith({
    bool? isLoading,
    List<PackageEntity>? packages,
    List<ReviewEntity>? reviews,
    List<PackageEntity>? bookmarkedPackages,
    List<PackageEntity>? userPackages,
    List<PackageEntity>? packageById,
    String? imageName,
    String? error,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      packages: packages ?? this.packages,
      reviews: reviews ?? this.reviews,
      bookmarkedPackages: bookmarkedPackages ?? this.bookmarkedPackages,
      userPackages: userPackages ?? this.userPackages,
      packageById: packageById ?? this.packageById,
      error: error ?? this.error,
      imageName: imageName ?? this.imageName,
    );
  }
}
