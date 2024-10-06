import 'package:external_dependencies/external_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:marvel_characters/app_state.dart';
import 'package:marvel_characters/app_viewmodel.dart';
import 'package:marvel_characters/utils/utils.dart';

import 'core/core.dart';
import 'presentation/presentation.dart';

class Startup {
  static void run() {
    WidgetsFlutterBinding.ensureInitialized();

    final vm = AppViewModel();
    vm.loadDependencies();

    runApp(_App(viewModel: vm));
    FlutterError.demangleStackTrace = (StackTrace stack) {
      if (stack is Trace) return stack.vmTrace;
      if (stack is Chain) return stack.toTrace().vmTrace;

      return stack;
    };
  }
}

class _App extends StatelessWidget {
  final AppViewModel viewModel;

  String get appTitle => 'Marvel Characters';

  const _App({required this.viewModel});

  @override
  Widget build(BuildContext context) =>
      ValueListenableBuilder<AsyncValue<AppState>>(
        valueListenable: viewModel,
        builder: (_, value, __) => value.maybeWhen(
          data: (state) => ProviderScope(
            overrides: [
              fetchCharacters.overrideWithValue(
                state.appDependencies.fetchCharacters,
              ),
              charactersRepository.overrideWithValue(
                state.appDependencies.charactersRepository,
              ),
            ],
            child: AppLoadedRoot(appTitle: appTitle),
          ),
          orElse: () => _SplashScreen(appTitle: appTitle),
        ),
      );
}

/// A widget that displays the splash screen.
class _SplashScreen extends StatelessWidget {
  const _SplashScreen({
    required this.appTitle,
  });

  final String appTitle;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      home: const SplashScreenPage(),
    );
  }
}

class AppLoadedRoot extends HookConsumerWidget {
  const AppLoadedRoot({required this.appTitle, super.key});

  final String appTitle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      scaffoldMessengerKey: useScaffoldMessenger(ref),
      title: appTitle,
      theme: ThemeData(useMaterial3: true),
      routerConfig: router,
    );
  }
}
