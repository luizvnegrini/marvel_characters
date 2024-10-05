import 'package:external_dependencies/external_dependencies.dart';

import 'http_request.dart';
import 'http_response.dart';

abstract class HttpException extends Equatable {
  final String? title;

  const HttpException({this.title});

  const factory HttpException.unknown({
    required HttpRequest request,
  }) = UnknownException;

  const factory HttpException.badResponse({
    required HttpResponse response,
  }) = BadResponseException;

  @override
  List get props => [title];
}

extension HttpExceptionX on HttpException {
  T when<T extends Object?>({
    required T Function(UnknownException) unknown,
    required T Function(BadResponseException) badResponse,
  }) {
    if (this is UnknownException) {
      return unknown(this as UnknownException);
    } else {
      return badResponse(this as BadResponseException);
    }
  }
}

class UnknownException extends HttpException {
  final HttpRequest request;

  const UnknownException({
    required this.request,
  }) : super(title: 'HttpException - Unknown');
}

class BadResponseException extends HttpException {
  final HttpResponse response;

  const BadResponseException({
    required this.response,
  }) : super(title: 'HttpException - BadResponse');
}
