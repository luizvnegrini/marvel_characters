import 'package:external_dependencies/external_dependencies.dart';

import '../../core/core.dart';
import '../../domain/domain.dart';
import '../data.dart';

// Using clean arch to the letter can be a shot in the foot in some situations,
// such as creating the datasource layer for this app. I decided to remove it
// because we would end up having this extra layer unnecessarily.
class CharactersRepositoryImpl implements CharactersRepository {
  static const String route = 'characters';
  final IHttpClient _client;

  CharactersRepositoryImpl(this._client);

  @override
  Future<Either<Failure, Pagination<Character>>> fetchCharacters({
    required int offset,
    required int limit,
    String? nameStartsWith,
  }) async {
    try {
      final data = await _client.get(
        route,
        options: HttpOptions(
          queryParameters: {
            'orderBy': 'name',
            'offset': offset,
            'limit': limit,
            if (nameStartsWith != null && nameStartsWith.isNotEmpty)
              'nameStartsWith': nameStartsWith,
          },
        ),
      );

      return data.fold(
        (failure) => left(Failure(type: ExceptionType.unexpected)),
        (response) => right(PaginationMapper.fromJson(response.body['data'])),
      );
    } catch (e) {
      return Left(Failure(type: ExceptionType.unexpected));
    }
  }

  @override
  Future<Either<Failure, Character>> fetchCharacterDetails({
    required int characterId,
  }) async {
    try {
      final data = await _client.get('$route/$characterId');

      return data.fold(
        (failure) => left(Failure(type: ExceptionType.unexpected)),
        (response) => right(
          CharacterMapper.fromJson(response.body['data']['results'][0]),
        ),
      );
    } catch (e) {
      return Left(Failure(type: ExceptionType.unexpected));
    }
  }
}
