import 'package:external_dependencies/external_dependencies.dart';

import '../../core/core.dart';
import '../domain.dart';

abstract class CharactersRepository {
  Future<Either<Failure, Pagination<Character>>> fetchCharacters({
    required int offset,
    required int limit,
    String? nameStartsWith,
  });
  Future<Either<Failure, Character>> fetchCharacterDetails({
    required int characterId,
  });
}
