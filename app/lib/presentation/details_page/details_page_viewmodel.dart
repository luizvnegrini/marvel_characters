import 'package:external_dependencies/external_dependencies.dart';
import 'package:marvel_characters/domain/domain.dart';

import '../base/viewmodel.dart';
import '../providers/providers.dart';
import 'details_page_state.dart';

final detailsPageViewModel =
    StateNotifierProvider.autoDispose<DetailsPageViewModel, DetailsPageState>(
  (ref) => DetailsPageViewModelImpl(
    charactersRepository: ref.read(charactersRepository),
  ),
);

abstract class DetailsPageViewModel extends ViewModel<DetailsPageState> {
  abstract final CharactersRepository charactersRepository;

  DetailsPageViewModel(super.state);

  Future<void> fetchCharacter(int characterId);
}

class DetailsPageViewModelImpl extends DetailsPageViewModel {
  @override
  final CharactersRepository charactersRepository;

  DetailsPageViewModelImpl({
    required this.charactersRepository,
  }) : super(DetailsPageStateImpl.initial());

  @override
  Future<void> fetchCharacter(int characterId) async {
    state = state.copyWith(isLoading: true, errorMessage: '');

    // this is the case where that we didn't have a business rule and need to
    // fetch making api call but to reduce boilerplate I prefer to call directly
    // the repository, skipping a layer. But as I sad, if we had business rules
    // we should create an use case for this.
    final result = await charactersRepository.fetchCharacterDetails(
      characterId: characterId,
    );

    state = result.fold(
      (failure) => state.copyWith(errorMessage: 'Please try again later'),
      (character) => state.copyWith(character: character),
    );

    state = state.copyWith(isLoading: false);
  }
}
