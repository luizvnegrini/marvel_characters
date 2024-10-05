import '../../domain/domain.dart';

class CharacterMapper {
  static Pagination<Character> fromJson(Map<String, dynamic> json) =>
      Pagination<Character>(
        offset: json['offset'],
        limit: json['limit'],
        total: json['total'],
        count: json['count'],
        results: (json['results'] as List)
            .map<Character>(
              (character) => Character(
                id: character['id'],
                name: character['name'],
                description: character['description'],
              ),
            )
            .toList(),
      );
}
