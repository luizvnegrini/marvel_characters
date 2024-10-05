import 'package:marvel_characters/core/core.dart';

/// Abstract class representing the state of the application.
abstract class AppState {
  /// The dependencies required by the application.
  abstract final AppDependencies appDependencies;
}

/// Concrete implementation of the [AppState] abstract class.
class AppStateImpl extends AppState {
  @override
  final AppDependencies appDependencies;

  /// Creates a new instance of [AppStateImpl].
  /// [appDependencies] is required and contains the dependencies needed by
  ///  the application.
  AppStateImpl({
    required this.appDependencies,
  });
}
