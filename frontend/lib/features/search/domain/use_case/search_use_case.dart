import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../../../home/domain/entity/package_entity.dart';
import '../repository/search_repository.dart';

final searchUsecaseProvider = Provider.autoDispose<SearchUseCase>(
  (ref) => SearchUseCase(
    searchRepository: ref.watch(searchRepositoryProvider),
  ),
);

class SearchUseCase {
  final ISearchRepository searchRepository;

  SearchUseCase({required this.searchRepository});

  Future<Either<Failure, List<PackageEntity>>> getSearchedPackages(
      String searchQuery) {
    return searchRepository.getSearchedPackages(searchQuery);
  }
}
