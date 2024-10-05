import 'package:external_dependencies/external_dependencies.dart';

import 'http_request.dart';

class HttpResponse extends Equatable {
  final dynamic body;
  final int statusCode;
  final String? statusMessage;
  final HttpRequest request;
  const HttpResponse({
    required this.statusCode,
    required this.body,
    required this.request,
    this.statusMessage,
  });

  @override
  List<Object?> get props => [body, statusCode, statusMessage, request];
}
