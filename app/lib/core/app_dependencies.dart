import '../data/data.dart';
import '../domain/domain.dart';
import 'core.dart';

abstract class AppDependencies {
  abstract final CharactersRepository charactersRepository;
  abstract final FetchCharacters fetchCharacters;
}

class AppDependenciesImpl implements AppDependencies {
  @override
  final FetchCharacters fetchCharacters;

  @override
  final CharactersRepository charactersRepository;

  @override
  AppDependenciesImpl({
    required this.fetchCharacters,
    required this.charactersRepository,
  });

  static Future<AppDependencies> load() async {
    final client = DioAdapter(
      baseUrl: Envs.baseUrl,
      interceptors: _getInterceptors(),
    );

    final charactersRepository = CharactersRepositoryImpl(client);

    return AppDependenciesImpl(
      fetchCharacters: FetchCharactersImpl(charactersRepository),
      charactersRepository: charactersRepository,
    );
  }

  static List<HttpInterceptor> _getInterceptors() {
    return [AuthInterceptor()];
  }
}
