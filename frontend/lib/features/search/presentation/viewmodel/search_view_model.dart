import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/use_case/search_use_case.dart';
import '../state/search_state.dart';

final searchViewModelProvider =
    StateNotifierProvider<SearchViewModel, SearchState>(
  (ref) => SearchViewModel(ref.read(searchUsecaseProvider)),
);

class SearchViewModel extends StateNotifier<SearchState> {
  final SearchUseCase searchUseCase;

  SearchViewModel(this.searchUseCase) : super(SearchState.initial()) {
    // getSearchedPackages(searchQuery);
  }

  getSearchedPackages(String searchQuery) async {
    state = state.copyWith(isLoading: true);
    final result = await searchUseCase.getSearchedPackages(searchQuery);
    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        error: failure.error,
        searchedPackages: [],
      ),
      
      (packages) => state = state.copyWith(
        
        isLoading: false,
        searchedPackages: packages,
      ),
    );
  }
}
