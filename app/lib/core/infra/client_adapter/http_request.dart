import 'client.dart';

typedef ValidateStatus = bool Function(int status);

class HttpRequest {
  final String path;
  final String baseUrl;
  final String method;
  final Map<String, dynamic>? headers;
  final Map<String, dynamic>? queryParameter;
  final Map<String, dynamic>? extra;
  final dynamic body;
  final HttpResponseType responseType;

  /// Null means no timeout limit
  final Duration? connectTimeout;

  /// Defines whether the request is successful for a given
  /// HTTP response status code.
  ///
  /// If validateStatus returns true, the request will be perceived as successful;
  /// otherwise, considered as failed.
  final ValidateStatus? validateStatus;

  const HttpRequest({
    required this.baseUrl,
    required this.path,
    required this.method,
    this.headers,
    this.queryParameter,
    this.extra,
    this.body,
    this.validateStatus,
    this.connectTimeout,
    this.responseType = HttpResponseType.json,
  });

  HttpRequest copyWith({
    String? path,
    String? baseUrl,
    String? method,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameter,
    Map<String, dynamic>? extra,
    dynamic body,
    Duration? connectTimeout,
    ValidateStatus? validateStatus,
    HttpResponseType? responseType,
  }) {
    return HttpRequest(
      path: path ?? this.path,
      baseUrl: baseUrl ?? this.baseUrl,
      method: method ?? this.method,
      headers: headers ?? this.headers,
      queryParameter: queryParameter ?? this.queryParameter,
      extra: extra ?? this.extra,
      body: body ?? this.body,
      connectTimeout: connectTimeout ?? this.connectTimeout,
      validateStatus: validateStatus ?? this.validateStatus,
      responseType: responseType ?? this.responseType,
    );
  }
}
