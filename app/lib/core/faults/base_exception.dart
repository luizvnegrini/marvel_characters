import 'package:external_dependencies/external_dependencies.dart';

typedef ExceptionObserver = void Function(BaseException exception);

abstract class BaseException extends Equatable implements Exception {
  final ExceptionType type;

  final String? message;

  final String? debugInfo;

  final dynamic debugData;

  static ExceptionObserver? observer;

  @override
  List<Object> get props => [type];

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

enum ExceptionType {
  unexpected,
}
