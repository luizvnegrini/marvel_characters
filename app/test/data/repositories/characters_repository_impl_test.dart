import 'package:external_dependencies/external_dependencies.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_characters/core/core.dart';
import 'package:marvel_characters/data/data.dart';
import 'package:marvel_characters/domain/domain.dart';
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements IHttpClient {}

void main() {
  late CharactersRepositoryImpl repository;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    repository = CharactersRepositoryImpl(mockHttpClient);
  });

  group('CharactersRepositoryImpl', () {
    group('fetchCharacters', () {
      const offset = 0;
      const limit = 20;
      const nameStartsWith = 'Spider';

      test('should return Pagination<Character> when the call is successful',
          () async {
        const mockResponse = HttpResponse(
          body: {
            'data': {
              'offset': offset,
              'limit': limit,
              'total': 1,
              'count': 1,
              'results': [
                {
                  'id': 1,
                  'name': 'Spider-Man',
                  'description': 'Friendly neighborhood Spider-Man',
                  'thumbnail': {
                    'path': 'http://example.com/spiderman',
                    'extension': 'jpg'
                  }
                }
              ]
            }
          },
          statusCode: 200,
          request: HttpRequest(
            baseUrl: 'fake',
            path: 'fake',
            method: 'GET',
          ),
        );

        when(() => mockHttpClient.get(
              'characters',
              options: any(named: 'options'),
            )).thenAnswer((_) async => const Right(mockResponse));

        final result = await repository.fetchCharacters(
          offset: offset,
          limit: limit,
          nameStartsWith: nameStartsWith,
        );

        expect(result.isRight(), true);
        result.fold(
          (l) => null,
          (r) {
            expect(r, isA<Pagination<Character>>());
            expect(r.results.first.name, 'Spider-Man');
          },
        );

        verify(() => mockHttpClient.get(
              'characters',
              options: any(named: 'options'),
            )).called(1);
      });

      group('fetchCharacterDetails', () {
        const characterId = 1;

        test('should return Character when the call is successful', () async {
          const mockResponse = HttpResponse(
            body: {
              'data': {
                'results': [
                  {
                    'id': characterId,
                    'name': 'Spider-Man',
                    'description': 'Friendly neighborhood Spider-Man',
                    'thumbnail': {
                      'path': 'http://example.com/spiderman',
                      'extension': 'jpg'
                    }
                  }
                ]
              }
            },
            statusCode: 200,
            request: HttpRequest(
              baseUrl: 'fake',
              path: 'fake',
              method: 'GET',
            ),
          );

          when(() => mockHttpClient.get('characters/$characterId'))
              .thenAnswer((_) async => const Right(mockResponse));

          final result =
              await repository.fetchCharacterDetails(characterId: characterId);

          expect(result.isRight(), true);
          result.fold(
            (l) => null,
            (r) {
              expect(r, isA<Character>());
              expect(r.name, 'Spider-Man');
            },
          );

          verify(() => mockHttpClient.get('characters/$characterId')).called(1);
        });
      });
    });
  });
}
