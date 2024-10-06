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

  Future<void> fetch({int offset = 0});
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
  Future<void> fetch({int offset = 0}) async {
    state = state.copyWith(
      isLoading: offset == 0,
      isLoadingNextPage: offset >= paginationLimit,
    );

    final result = await fetchCharacters(
      offset: offset,
      limit: paginationLimit,
    );

    state = result.fold(
      (failure) => state.copyWith(errorMessage: 'Please try again later'),
      (pagination) {
        final updatedOffset = pagination.offset + pagination.count;

        return state.copyWith(
          characters: List.from(
            [
              ...state.characters,
              ...pagination.results,
            ],
          ),
          currentOffset: updatedOffset,
          hasReachedMax: updatedOffset >= pagination.total,
        );
      },
    );

    state = state.copyWith(
      isLoading: false,
      isLoadingNextPage: false,
    );
  }
}
