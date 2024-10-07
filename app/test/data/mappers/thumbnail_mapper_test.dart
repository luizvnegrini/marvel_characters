import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_characters/data/mappers/thumbnail_mapper.dart';
import 'package:marvel_characters/domain/entities/thumbnail.dart';

void main() {
  group('ThumbnailMapper', () {
    test('should correctly map a JSON to a Thumbnail', () {
      final json = {'path': 'http://faketest.com/image', 'extension': 'jpg'};

      final result = ThumbnailMapper.fromJson(json);

      expect(result, isA<Thumbnail>());
      expect(result.path, 'http://faketest.com/image');
      expect(result.extension, 'jpg');
    });

    test('should handle different file extensions', () {
      final json = {'path': 'http://faketest.com/image', 'extension': 'png'};

      final result = ThumbnailMapper.fromJson(json);

      expect(result.path, 'http://faketest.com/image');
      expect(result.extension, 'png');
    });

    test('should throw an exception if the JSON is missing required fields',
        () {
      final invalidJson = {'path': 'http://faketest.com/image'};

      expect(() => ThumbnailMapper.fromJson(invalidJson),
          throwsA(isA<TypeError>()));
    });

    test('should handle empty strings for path and extension', () {
      final json = {'path': '', 'extension': ''};

      final result = ThumbnailMapper.fromJson(json);

      expect(result.path, isEmpty);
      expect(result.extension, isEmpty);
    });

    test('should handle URLs with query parameters', () {
      final json = {
        'path': 'http://faketest.com/image?size=large',
        'extension': 'webp'
      };

      final result = ThumbnailMapper.fromJson(json);

      expect(result.path, 'http://faketest.com/image?size=large');
      expect(result.extension, 'webp');
    });
  });
}
