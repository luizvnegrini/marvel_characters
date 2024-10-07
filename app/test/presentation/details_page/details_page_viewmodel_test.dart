import 'package:external_dependencies/external_dependencies.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_characters/core/core.dart';
import 'package:marvel_characters/domain/domain.dart';
import 'package:marvel_characters/presentation/details_page/details_page_viewmodel.dart';
import 'package:mocktail/mocktail.dart';

class MockCharactersRepository extends Mock implements CharactersRepository {}

void main() {
  late DetailsPageViewModel viewModel;
  late MockCharactersRepository mockRepository;

  setUp(() {
    mockRepository = MockCharactersRepository();
    viewModel = DetailsPageViewModelImpl(charactersRepository: mockRepository);
  });

  group('DetailsPageViewModel', () {
    const characterId = 1;
    final character = Character(
      id: characterId,
      name: 'Spider-Man',
      description: 'Friendly neighborhood Spider-Man',
      thumbnail:
          Thumbnail(path: 'http://faketest.com/spiderman', extension: 'jpg'),
    );

    test('initial state should be correct', () {
      expect(viewModel.state.isLoading, false);
      expect(viewModel.state.character, isNull);
      expect(viewModel.state.errorMessage, isEmpty);
    });

    group('fetchCharacter', () {
      test('should update state correctly on successful fetch', () async {
        when(() =>
                mockRepository.fetchCharacterDetails(characterId: characterId))
            .thenAnswer((_) async => Right(character));

        await viewModel.fetchCharacter(characterId);

        expect(viewModel.state.isLoading, false);
        expect(viewModel.state.character, character);
        expect(viewModel.state.errorMessage, isEmpty);

        verify(() =>
                mockRepository.fetchCharacterDetails(characterId: characterId))
            .called(1);
      });

      test('should update state correctly on fetch failure', () async {
        when(() =>
                mockRepository.fetchCharacterDetails(characterId: characterId))
            .thenAnswer(
                (_) async => Left(Failure(type: ExceptionType.unexpected)));

        await viewModel.fetchCharacter(characterId);

        expect(viewModel.state.isLoading, false);
        expect(viewModel.state.character, isNull);
        expect(viewModel.state.errorMessage, 'Please try again later');

        verify(() =>
                mockRepository.fetchCharacterDetails(characterId: characterId))
            .called(1);
      });

      test('should set isLoading to true while fetching', () async {
        when(() =>
                mockRepository.fetchCharacterDetails(characterId: characterId))
            .thenAnswer((_) async {
          expect(viewModel.state.isLoading, true);
          return Right(character);
        });

        await viewModel.fetchCharacter(characterId);

        expect(viewModel.state.isLoading, false);
      });

      test('should clear error message before fetching', () async {
        // Set an initial error message
        viewModel = DetailsPageViewModelImpl(
            charactersRepository: mockRepository)
          ..state = viewModel.state.copyWith(errorMessage: 'Previous error');

        when(() =>
                mockRepository.fetchCharacterDetails(characterId: characterId))
            .thenAnswer((_) async => Right(character));

        await viewModel.fetchCharacter(characterId);

        expect(viewModel.state.errorMessage, isEmpty);
      });

      test('should not update character on fetch failure', () async {
        viewModel =
            DetailsPageViewModelImpl(charactersRepository: mockRepository)
              ..state = viewModel.state.copyWith(character: character);

        when(() =>
                mockRepository.fetchCharacterDetails(characterId: characterId))
            .thenAnswer(
                (_) async => Left(Failure(type: ExceptionType.unexpected)));

        await viewModel.fetchCharacter(characterId);

        expect(viewModel.state.character, character);
      });
    });
  });
}
