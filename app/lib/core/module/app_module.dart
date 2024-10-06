import 'package:external_dependencies/external_dependencies.dart';

import '../../presentation/presentation.dart';

class Routes {
  static String get _source => '/';
  static String get details => 'details';
  static String get home => _source;
}

class AppModule {
  static List<GoRoute> get routes => [
        GoRoute(
          name: 'home',
          path: Routes.home,
          builder: (_, __) => const HomePage(),
          routes: [
            GoRoute(
              name: 'result',
              path: Routes.details,
              builder: (context, state) {
                final characterId = state.extra as int;
                return DetailsPage(characterId: characterId);
              },
            ),
          ],
        ),
      ];
}
