import 'package:external_dependencies/external_dependencies.dart';

import '../../infra.dart';

extension DioExceptionMapper on DioException {
  HttpException toClient() {
    final statusCode = response?.statusCode ?? response?.data['code'] as int?;

    if (response == null ||
        statusCode == null ||
        type == DioExceptionType.unknown) {
      return HttpException.unknown(
        request: requestOptions.toClient(),
      );
    }

    return HttpException.badResponse(
      response: HttpResponseMapper.toClient(response!),
    );
  }
}

extension RequestOptionsMapper on RequestOptions {
  HttpRequest toClient() {
    return HttpRequest(
      baseUrl: baseUrl,
      path: path,
      method: method,
      headers: headers,
      queryParameter: queryParameters,
      extra: extra,
      body: data,
      validateStatus: validateStatus,
      connectTimeout: connectTimeout,
      responseType: HttpResponseTypeMapper.toClient(responseType),
    );
  }
}

abstract class HttpResponseMapper {
  static Response toDio(HttpResponse response) {
    return Response(
      requestOptions: HttpRequestMapper.toDio(response.request),
      data: response.body,
      statusCode: response.statusCode,
      statusMessage: response.statusMessage,
    );
  }

  static HttpResponse toClient(Response response) {
    return HttpResponse(
        body: response.data,
        statusCode: response.statusCode ?? -1,
        statusMessage: response.statusMessage,
        request: response.requestOptions.toClient());
  }
}

abstract class HttpResponseTypeMapper {
  static ResponseType toDio(HttpResponseType responseType) {
    switch (responseType) {
      case HttpResponseType.bytes:
        return ResponseType.bytes;
      case HttpResponseType.json:
        return ResponseType.json;
    }
  }

  static HttpResponseType toClient(ResponseType responseType) {
    switch (responseType) {
      case ResponseType.bytes:
        return HttpResponseType.bytes;
      default:
        return HttpResponseType.json;
    }
  }
}

abstract class HttpRequestMapper {
  static RequestOptions toDio(HttpRequest request) {
    final validateStatus = request.validateStatus;
    return RequestOptions(
      headers: request.headers,
      path: request.path,
      baseUrl: request.baseUrl,
      method: request.method,
      queryParameters: request.queryParameter,
      extra: request.extra,
      data: request.body,
      validateStatus: validateStatus != null
          ? (status) {
              return status != null && validateStatus(status);
            }
          : null,
      connectTimeout: request.connectTimeout,
      responseType: HttpResponseTypeMapper.toDio(request.responseType),
    );
  }
}

abstract class HttpExceptionMapper {
  static DioException toDio(HttpException exception) {
    return exception.when(
      unknown: (unknown) {
        return DioException(
          requestOptions: HttpRequestMapper.toDio(
            unknown.request,
          ),
        );
      },
      badResponse: (badResponse) {
        return DioException(
          response: HttpResponseMapper.toDio(badResponse.response),
          requestOptions: HttpRequestMapper.toDio(badResponse.response.request),
        );
      },
    );
  }
}
