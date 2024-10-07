import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_characters/data/data.dart';
import 'package:marvel_characters/data/mappers/character_mapper.dart';
import 'package:marvel_characters/domain/entities/character.dart';

void main() {
  group('CharacterMapper', () {
    test('should correctly map a JSON to a Character', () {
      final json = {
        'id': 1,
        'name': 'Spider-Man',
        'description': 'Friendly neighborhood Spider-Man',
        'thumbnail': {
          'path': 'http://testingfake.com/spiderman',
          'extension': 'jpg'
        }
      };

      final result = CharacterMapper.fromJson(json);

      expect(result, isA<Character>());
      expect(result.id, 1);
      expect(result.name, 'Spider-Man');
      expect(result.description, 'Friendly neighborhood Spider-Man');
      expect(result.thumbnail.path, 'http://testingfake.com/spiderman');
      expect(result.thumbnail.extension, 'jpg');
    });

    test('should handle empty description correctly', () {
      final json = {
        'id': 2,
        'name': 'Iron Man',
        'description': '',
        'thumbnail': {
          'path': 'http://testingfake.com/ironman',
          'extension': 'png'
        }
      };

      final result = CharacterMapper.fromJson(json);

      expect(result.description, isEmpty);
    });

    test('should throw an exception if the JSON is malformed', () {
      final invalidJson = {
        'id': 'not a number',
        'name': 123,
        'thumbnail': 'not an object'
      };

      expect(() => CharacterMapper.fromJson(invalidJson),
          throwsA(isA<TypeError>()));
    });
  });
}
