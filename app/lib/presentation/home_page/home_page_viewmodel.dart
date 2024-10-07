import 'package:external_dependencies/external_dependencies.dart';
import 'package:marvel_characters/domain/domain.dart';

import '../base/viewmodel.dart';
import '../providers/providers.dart';
import 'home_page_state.dart';

final homePageViewModel =
    StateNotifierProvider.autoDispose<HomePageViewModel, HomePageState>(
  (ref) => HomePageViewModelImpl(
    fetchCharacters: ref.read(fetchCharacters),
  ),
);

abstract class HomePageViewModel extends ViewModel<HomePageState> {
  abstract final FetchCharacters fetchCharacters;

  HomePageViewModel(super.state);

  Future<void> fetch({int offset = 0, String? searchTerm});
  void cleanSearch();
}

class HomePageViewModelImpl extends HomePageViewModel {
  @override
  final FetchCharacters fetchCharacters;

  final paginationLimit = 20;

  HomePageViewModelImpl({
    required this.fetchCharacters,
  }) : super(HomePageStateImpl.initial()) {
    fetch();
  }

  @override
  void cleanSearch() {
    state = state.copyWith(
      characters: [],
      currentOffset: 0,
      hasReachedMax: false,
      searchTerm: '',
    );
  }

  @override
  Future<void> fetch({int offset = 0, String? searchTerm}) async {
    state = state.copyWith(
      isLoading: offset == 0,
      isLoadingNextPage: offset >= paginationLimit,
    );

    final result = await fetchCharacters(
      offset: offset,
      limit: paginationLimit,
      nameStartsWith: searchTerm,
    );

    state = result.fold(
      (failure) => state.copyWith(errorMessage: 'Please try again later'),
      (pagination) {
        final updatedOffset = pagination.offset + pagination.count;
        final updatedCharacters = offset == 0
            ? pagination.results
            : [...state.characters, ...pagination.results];

        return state.copyWith(
          characters: updatedCharacters,
          currentOffset: updatedOffset,
          hasReachedMax: updatedOffset >= pagination.total,
          searchTerm: searchTerm,
        );
      },
    );

    state = state.copyWith(
      isLoading: false,
      isLoadingNextPage: false,
    );
  }
}
