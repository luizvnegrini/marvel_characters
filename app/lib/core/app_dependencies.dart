import '../domain/domain.dart';

abstract class AppDependencies {
  abstract final FetchCharacters fetchCharacters;
}

class AppDependenciesImpl implements AppDependencies {
  @override
  final FetchCharacters fetchCharacters;

  @override
  AppDependenciesImpl({
    required this.fetchCharacters,
  });

  static Future<AppDependencies> load() async {
    return AppDependenciesImpl(
      fetchCharacters: GenerateNewColorImpl(),
    );
  }
}
