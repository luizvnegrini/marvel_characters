import 'package:external_dependencies/external_dependencies.dart';

import '../../core/core.dart';
import '../domain.dart';

abstract class CharactersRepository {
  Future<Either<Failure, Pagination<Character>>> fetchCharacters();
}
