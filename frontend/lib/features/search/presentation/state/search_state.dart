import '../../../home/domain/entity/package_entity.dart';

class SearchState {
  final bool isLoading;
  final List<PackageEntity> searchedPackages;
  final String? error;

  SearchState({
    required this.isLoading,
    required this.searchedPackages,
    this.error,
  });

  factory SearchState.initial() {
    return SearchState(isLoading: false, searchedPackages: []);
  }

  SearchState copyWith({
    bool? isLoading,
    List<PackageEntity>? searchedPackages,
    String? error,
  }) {
    return SearchState(
      isLoading: isLoading ?? this.isLoading,
      searchedPackages: searchedPackages ?? this.searchedPackages,
      error: error ?? this.error,
    );
  }
}
