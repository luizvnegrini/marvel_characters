import 'package:external_dependencies/external_dependencies.dart';
import 'package:flutter/material.dart';

/// Abstract class representing the state of a ViewModel.
/// Extends [Equatable] for easy equality comparisons.
// ignore: prefer_match_file_name
abstract class ViewModelState extends Equatable {
  /// Creates a [ViewModelState].
  const ViewModelState();
}

/// Abstract class representing a ViewModel.
/// Extends [StateNotifier] with a generic type [State] that must be a
/// subclass of [ViewModelState].
abstract class ViewModel<State extends ViewModelState>
    extends StateNotifier<State> {
  /// Indicates whether the ViewModel has been initialized.
  bool isInitialized = false;

  /// Creates a [ViewModel] with the given initial state.
  /// Automatically calls [initViewModel] upon creation.
  ViewModel(super.initialState) {
    initViewModel();
  }

  /// Initializes the ViewModel.
  /// This method is called automatically when the ViewModel is created.
  /// It should not be called manually.
  @mustCallSuper
  void initViewModel() {
    assert(
      !isInitialized,
      'View Model has already been initialized! The initialization occurs '
      'automatically on life cycle, so you should not call initViewModel '
      'manually.',
    );
    isInitialized = true;
  }
}
