import 'package:external_dependencies/external_dependencies.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_characters/core/core.dart';
import 'package:marvel_characters/domain/domain.dart';
import 'package:marvel_characters/presentation/home_page/home_page_viewmodel.dart';
import 'package:mocktail/mocktail.dart';

class MockFetchCharacters extends Mock implements FetchCharacters {}

void main() {
  late HomePageViewModel viewModel;
  late MockFetchCharacters mockFetchCharacters;

  setUp(() {
    mockFetchCharacters = MockFetchCharacters();

    when(() => mockFetchCharacters(
          offset: any(named: 'offset'),
          limit: any(named: 'limit'),
          nameStartsWith: any(named: 'nameStartsWith'),
        )).thenAnswer((_) async => Right(Pagination<Character>(
          offset: 0,
          limit: 20,
          total: 0,
          count: 0,
          results: [],
        )));

    viewModel = HomePageViewModelImpl(fetchCharacters: mockFetchCharacters);
  });

  group('HomePageViewModel', () {
    const offset = 0;
    const limit = 20;
    final character = Character(
      id: 1,
      name: 'Spider-Man',
      description: 'Friendly neighborhood Spider-Man',
      thumbnail:
          Thumbnail(path: 'http://faketest.com/spiderman', extension: 'jpg'),
    );
    final pagination = Pagination<Character>(
      offset: offset,
      limit: limit,
      total: 1,
      count: 1,
      results: [character],
    );

    group('fetch', () {
      test('should update state correctly on successful fetch', () async {
        when(() => mockFetchCharacters(
              offset: offset,
              limit: 20,
              nameStartsWith: null,
            )).thenAnswer((_) async => Right(pagination));

        await viewModel.fetch();

        expect(viewModel.state.isLoading, false);
        expect(viewModel.state.characters, [character]);
        expect(viewModel.state.errorMessage, isEmpty);
        expect(viewModel.state.currentOffset, 1);
        expect(viewModel.state.hasReachedMax, true);

        verify(() => mockFetchCharacters(
              offset: offset,
              limit: 20,
              nameStartsWith: null,
            ));
      });

      test('should update state correctly on fetch failure', () async {
        when(() => mockFetchCharacters(
                  offset: any(named: 'offset'),
                  limit: any(named: 'limit'),
                  nameStartsWith: any(named: 'nameStartsWith'),
                ))
            .thenAnswer(
                (_) async => Left(Failure(type: ExceptionType.unexpected)));

        await viewModel.fetch();

        expect(viewModel.state.isLoading, false);
        expect(viewModel.state.characters, isEmpty);
        expect(viewModel.state.errorMessage, 'Please try again later');

        verify(() => mockFetchCharacters(
              offset: offset,
              limit: any(named: 'limit'),
              nameStartsWith: any(named: 'nameStartsWith'),
            ));
      });

      test('should set isLoading to true while fetching', () async {
        when(() => mockFetchCharacters(
              offset: any(named: 'offset'),
              limit: any(named: 'limit'),
              nameStartsWith: any(named: 'nameStartsWith'),
            )).thenAnswer((_) async {
          expect(viewModel.state.isLoading, true);
          return Right(pagination);
        });

        await viewModel.fetch();

        expect(viewModel.state.isLoading, false);
      });

      test('should append characters on subsequent fetches', () async {
        final character2 = Character(
          id: 2,
          name: 'Iron Man',
          description: 'Genius billionaire',
          thumbnail:
              Thumbnail(path: 'http://faketest.com/ironman', extension: 'jpg'),
        );
        final pagination2 = Pagination<Character>(
          offset: limit,
          limit: limit,
          total: 40,
          count: 1,
          results: [character2],
        );

        when(() => mockFetchCharacters(
              offset: 0,
              limit: any(named: 'limit'),
              nameStartsWith: any(named: 'nameStartsWith'),
            )).thenAnswer((_) async => Right(pagination));

        when(() => mockFetchCharacters(
              offset: limit,
              limit: any(named: 'limit'),
              nameStartsWith: any(named: 'nameStartsWith'),
            )).thenAnswer((_) async => Right(pagination2));

        await viewModel.fetch();
        await viewModel.fetch(offset: limit);

        expect(viewModel.state.characters.length, 2);
        expect(viewModel.state.currentOffset, limit + 1);
        expect(viewModel.state.hasReachedMax, false);
      });

      test('should update state correctly when fetching with search term',
          () async {
        when(() => mockFetchCharacters(
              offset: any(named: 'offset'),
              limit: any(named: 'limit'),
              nameStartsWith: 'Spider',
            )).thenAnswer((_) async => Right(pagination));

        await viewModel.fetch(searchTerm: 'Spider');

        expect(viewModel.state.searchTerm, 'Spider');
        expect(viewModel.state.characters, [character]);
      });
    });

    test('cleanSearch should reset the state correctly', () {
      viewModel = HomePageViewModelImpl(fetchCharacters: mockFetchCharacters)
        ..state = viewModel.state.copyWith(
          characters: [character],
          currentOffset: 20,
          hasReachedMax: true,
          searchTerm: 'Spider',
        );

      viewModel.cleanSearch();

      expect(viewModel.state.characters, isEmpty);
      expect(viewModel.state.currentOffset, 0);
      expect(viewModel.state.hasReachedMax, false);
      expect(viewModel.state.searchTerm, isEmpty);
    });
  });
}
