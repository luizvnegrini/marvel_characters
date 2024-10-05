import 'package:external_dependencies/external_dependencies.dart';

import 'http_exception.dart';
import 'http_response.dart';

enum HttpResponseType {
  json,
  bytes,
}

class HttpOptions extends Equatable {
  final Map<String, dynamic>? body;
  final Map<String, dynamic>? headers;
  final Map<String, dynamic>? queryParameters;
  final bool Function(int?)? validateStatus;
  final HttpResponseType responseType;

  /// Null means no timeout limit
  final Duration? connectTimeout;

  /// Null means no timeout limit
  final Duration? sendTimeout;

  const HttpOptions({
    this.body,
    this.headers,
    this.queryParameters,
    this.validateStatus,
    this.connectTimeout,
    this.sendTimeout,
    this.responseType = HttpResponseType.json,
  });

  @override
  List<Object?> get props => [
        body,
        headers,
        queryParameters,
        validateStatus,
        connectTimeout,
        sendTimeout,
        responseType,
      ];
}

abstract class IHttpClient {
  Future<Either<HttpException, HttpResponse>> get(
    String path, {
    HttpOptions? options,
  });

  Future<Either<HttpException, HttpResponse>> post(
    String path, {
    HttpOptions? options,
  });

  Future<Either<HttpException, HttpResponse>> delete(
    String path, {
    HttpOptions? options,
  });

  Future<Either<HttpException, HttpResponse>> put(
    String path, {
    HttpOptions? options,
  });

  Future<Either<HttpException, HttpResponse>> patch(
    String path, {
    HttpOptions? options,
  });
}
