import 'package:external_dependencies/external_dependencies.dart';

/// A function type that observes exceptions.
typedef ExceptionObserver = void Function(BaseException exception);

/// An abstract base class for exceptions in the application.
abstract class BaseException extends Equatable implements Exception {
  /// The type of the exception.
  final ExceptionType type;

  /// An optional message describing the exception.
  final String? message;

  /// Additional information for debugging purposes.
  final String? debugInfo;

  /// Any relevant data for debugging.
  final dynamic debugData;

  /// A static observer that can be set to monitor exceptions.
  // ignore: avoid_global_state
  static ExceptionObserver? observer;

  @override
  List<Object> get props => [type];

  /// Creates a new [BaseException].
  /// [type] is required and specifies the type of the exception.
  /// [debugInfo] provides additional debugging information.
  /// [debugData] can contain any relevant debugging data.
  /// [message] is an optional message describing the exception.
  BaseException({
    required this.type,
    this.debugInfo,
    this.debugData,
    this.message,
  }) {
    observer?.call(this);
  }

  @override
  String toString() => '''
  [BaseException - $type] $debugInfo.
  Debug Data: $debugData
  ''';
}

/// Enum representing different types of exceptions.
///
/// Currently only contains 'unexpected', but can be expanded
/// for future features, especially when dealing with remote data.
enum ExceptionType {
  /// Represents an unexpected error.
  unexpected,
}
