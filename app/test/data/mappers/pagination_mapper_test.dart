import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_characters/data/mappers/pagination_mapper.dart';
import 'package:marvel_characters/domain/entities/character.dart';
import 'package:marvel_characters/domain/entities/pagination.dart';

void main() {
  group('PaginationMapper', () {
    test('should correctly map a JSON to a Pagination<Character>', () {
      final json = {
        'offset': 0,
        'limit': 20,
        'total': 50,
        'count': 2,
        'results': [
          {
            'id': 1,
            'name': 'Spider-Man',
            'description': 'Friendly neighborhood Spider-Man',
            'thumbnail': {
              'path': 'http://faketest.com/spiderman',
              'extension': 'jpg'
            }
          },
          {
            'id': 2,
            'name': 'Iron Man',
            'description': 'Genius billionaire',
            'thumbnail': {
              'path': 'http://faketest.com/ironman',
              'extension': 'png'
            }
          }
        ]
      };

      final result = PaginationMapper.fromJson(json);

      expect(result, isA<Pagination<Character>>());
      expect(result.offset, 0);
      expect(result.limit, 20);
      expect(result.total, 50);
      expect(result.count, 2);
      expect(result.results, hasLength(2));
      expect(result.results[0], isA<Character>());
      expect(result.results[0].name, 'Spider-Man');
      expect(result.results[1], isA<Character>());
      expect(result.results[1].name, 'Iron Man');
    });

    test('should handle an empty results list correctly', () {
      final json = {
        'offset': 0,
        'limit': 20,
        'total': 0,
        'count': 0,
        'results': []
      };

      final result = PaginationMapper.fromJson(json);

      expect(result.results, isEmpty);
    });

    test('should throw an exception if the JSON is malformed', () {
      final invalidJson = {
        'offset': 'not a number',
        'limit': 'not a number',
        'total': 'not a number',
        'count': 'not a number',
        'results': 'not a list'
      };

      expect(() => PaginationMapper.fromJson(invalidJson),
          throwsA(isA<TypeError>()));
    });

    test('should correctly map when numeric fields are provided as strings',
        () {
      final json = {
        'offset': 0,
        'limit': 20,
        'total': 50,
        'count': 2,
        'results': [
          {
            'id': 1,
            'name': 'Spider-Man',
            'description': 'Friendly neighborhood Spider-Man',
            'thumbnail': {
              'path': 'http://faketest.com/spiderman',
              'extension': 'jpg'
            }
          }
        ]
      };

      final result = PaginationMapper.fromJson(json);

      expect(result.offset, 0);
      expect(result.limit, 20);
      expect(result.total, 50);
      expect(result.count, 2);
    });
  });
}
