import 'package:external_dependencies/external_dependencies.dart';
import 'package:marvel_characters/domain/domain.dart';

final fetchCharacters = Provider.autoDispose<FetchCharacters>((_) {
  throw UnimplementedError('fetchCharacters usecase must be overridden');
});
