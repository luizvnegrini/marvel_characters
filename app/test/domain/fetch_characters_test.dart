import 'package:external_dependencies/external_dependencies.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_characters/core/core.dart';
import 'package:marvel_characters/domain/domain.dart';
import 'package:mocktail/mocktail.dart';

class MockCharactersRepository extends Mock implements CharactersRepository {}

void main() {
  late FetchCharacters fetchCharacters;
  late MockCharactersRepository mockRepository;

  setUp(() {
    mockRepository = MockCharactersRepository();
    fetchCharacters = FetchCharactersImpl(mockRepository);
  });

  group('FetchCharacters', () {
    const offset = 0;
    const limit = 20;
    const nameStartsWith = 'Spider';
    final pagination = Pagination<Character>(
      offset: offset,
      limit: limit,
      total: 1,
      count: 1,
      results: [
        Character(
          id: 1,
          name: 'Spider-Man',
          description: 'description',
          thumbnail: Thumbnail(path: 'path', extension: 'jpg'),
        )
      ],
    );

    test('should return a Pagination<Character> when the call is successful',
        () async {
      when(() => mockRepository.fetchCharacters(
            offset: offset,
            limit: limit,
            nameStartsWith: nameStartsWith,
          )).thenAnswer((_) async => Right(pagination));

      final result = await fetchCharacters(
        offset: offset,
        limit: limit,
        nameStartsWith: nameStartsWith,
      );

      expect(result, Right(pagination));
      verify(() => mockRepository.fetchCharacters(
            offset: offset,
            limit: limit,
            nameStartsWith: nameStartsWith,
          )).called(1);
    });

    test('should return a Failure when the call fails', () async {
      when(() => mockRepository.fetchCharacters(
            offset: offset,
            limit: limit,
            nameStartsWith: nameStartsWith,
          )).thenAnswer(
        (_) async => Left(
          Failure(type: ExceptionType.unexpected),
        ),
      );

      final result = await fetchCharacters(
        offset: offset,
        limit: limit,
        nameStartsWith: nameStartsWith,
      );

      expect(result, Left(Failure(type: ExceptionType.unexpected)));
      verify(() => mockRepository.fetchCharacters(
            offset: offset,
            limit: limit,
            nameStartsWith: nameStartsWith,
          )).called(1);
    });

    test('should call the repository without nameStartsWith when not provided',
        () async {
      when(() => mockRepository.fetchCharacters(
            offset: offset,
            limit: limit,
            nameStartsWith: null,
          )).thenAnswer((_) async => Right(pagination));

      await fetchCharacters(
        offset: offset,
        limit: limit,
      );

      verify(() => mockRepository.fetchCharacters(
            offset: offset,
            limit: limit,
            nameStartsWith: null,
          )).called(1);
    });
  });
}
