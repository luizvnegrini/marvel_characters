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

  void fetch();
}

class HomePageViewModelImpl extends HomePageViewModel {
  @override
  final FetchCharacters fetchCharacters;

  HomePageViewModelImpl({
    required this.fetchCharacters,
  }) : super(HomePageStateImpl.initial()) {
    fetch();
  }

  @override
  Future<void> fetch() async {
    state = state.copyWith(isLoading: true);

    final result = await fetchCharacters();

    state = result.fold(
      (failure) => state.copyWith(errorMessage: 'Please try again later'),
      (characters) => state.copyWith(
        characters: List.from(
          [
            ...state.characters,
            ...characters.results,
          ],
        ),
      ),
    );

    state = state.copyWith(isLoading: false);
  }
}
