import '../domain.dart';

class Character {
  final int id;
  final String name;
  final String description;
  final Thumbnail thumbnail;

  Character({
    required this.id,
    required this.name,
    required this.description,
    required this.thumbnail,
  });

  String get thumbnailUrl => '${thumbnail.path}.${thumbnail.extension}';
}
