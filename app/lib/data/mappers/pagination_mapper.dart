import '../../domain/domain.dart';
import '../data.dart';

class PaginationMapper {
  static Pagination<Character> fromJson(Map<String, dynamic> json) =>
      Pagination<Character>(
        offset: json['offset'],
        limit: json['limit'],
        total: json['total'],
        count: json['count'],
        results: (json['results'] as List)
            .map<Character>(
              (character) => CharacterMapper.fromJson(character),
            )
            .toList(),
      );
}
