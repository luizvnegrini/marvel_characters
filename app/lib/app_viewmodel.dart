import 'package:external_dependencies/external_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:marvel_characters/app_state.dart';
import 'package:marvel_characters/core/core.dart';

/// Abstract class representing the view model for the app.
/// Extends [ValueNotifier] with [AsyncValue] of [AppState].
// ignore: prefer_match_file_name
abstract class IAppViewModel extends ValueNotifier<AsyncValue<AppState>> {
  /// Constructor that takes an initial value.
  IAppViewModel(super.value);

  /// Method to load dependencies asynchronously.
  Future<void> loadDependencies();
}

/// Concrete implementation of [IAppViewModel].
class AppViewModel extends IAppViewModel {
  /// Flag to track if loading has been requested.
  var _hasRequestedLoading = false;

  /// Constructor initializes the view model with a loading state.
  AppViewModel() : super(const AsyncValue.loading());

  /// Loads dependencies asynchronously.
  /// This method ensures that dependencies are loaded only once.
  /// It waits for a minimum splash duration and loads app dependencies
  /// concurrently.
  /// After loading, it updates the view model's value with the new app state.
  @override
  Future<void> loadDependencies() async {
    if (_hasRequestedLoading) {
      return;
    }
    _hasRequestedLoading = true;

    final splashMinDuration = Future<dynamic>.delayed(
      const Duration(seconds: 2),
    );

    final futureResults = await Future.wait([
      splashMinDuration,
      AppDependenciesImpl.load(),
    ]);

    value = AsyncValue.data(
      AppStateImpl(
        appDependencies: futureResults[1] as AppDependencies,
      ),
    );
  }
}
