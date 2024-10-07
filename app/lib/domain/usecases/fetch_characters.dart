import 'package:external_dependencies/external_dependencies.dart';

import '../../core/core.dart';
import '../domain.dart';

abstract class FetchCharacters {
  Future<Either<Failure, Pagination<Character>>> call({
    required int offset,
    required int limit,
    String? nameStartsWith,
  });
}

class FetchCharactersImpl implements FetchCharacters {
  final CharactersRepository _repository;

  FetchCharactersImpl(this._repository);

  @override
  Future<Either<Failure, Pagination<Character>>> call({
    required int offset,
    required int limit,
    String? nameStartsWith,
  }) async {
    // In this case I will leave it just as a tunnel to illustrate how it
    // be unnecessary in certain situations, we could call the repository
    // directly from within the viewmodel, skipping a layer, but as we have no
    // business rules in this case, I don't see the need.
    return await _repository.fetchCharacters(
      offset: offset,
      limit: limit,
      nameStartsWith: nameStartsWith,
    );
  }
}
