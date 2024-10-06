import '../../domain/domain.dart';

class CharacterMapper {
  static Character fromJson(Map<String, dynamic> json) => Character(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        thumbnail: json['thumbnail'],
      );
}
