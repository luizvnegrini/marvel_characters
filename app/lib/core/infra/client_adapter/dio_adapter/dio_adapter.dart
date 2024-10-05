import 'package:external_dependencies/external_dependencies.dart';

import '../../infra.dart';

class DioAdapter implements IHttpClient {
  final String baseUrl;
  final Map<String, dynamic>? headers;
  final List<HttpInterceptor>? interceptors;
  final List<Interceptor>? dioInterceptors;
  late final Map<String, dynamic> _headers;
  late final Dio _dio;

  DioAdapter({
    required this.baseUrl,
    this.headers,
    this.interceptors,
    this.dioInterceptors,
    Dio? dio,
    Duration receiveTimeout = const Duration(seconds: 30),
    Duration? connectTimeout,
    Duration? sendTimeout,
  }) : _headers = headers ?? {} {
    _dio = dio ??
        Dio(
          BaseOptions(
            baseUrl: baseUrl,
            headers: _headers,
            sendTimeout: sendTimeout,
            connectTimeout: connectTimeout,
            receiveTimeout: receiveTimeout,
          ),
        );

    if (interceptors != null) {
      _dio.interceptors.addAll(
        [
          ...dioInterceptors ?? [],
          ...interceptors!.map(DioInterceptorMapper.toDio),
        ],
      );
    }
  }

  Future<Response> _fetch({
    required String path,
    required String method,
    HttpOptions? options,
  }) {
    return _dio.fetch(
      RequestOptions(
        baseUrl: baseUrl,
        path: path,
        method: method,
        headers: _headers..addAll(options?.headers ?? {}),
        validateStatus: options?.validateStatus,
        data: options?.body,
        queryParameters: options?.queryParameters,
        connectTimeout: options?.connectTimeout,
        sendTimeout: options?.sendTimeout,
        responseType: options?.responseType != null
            ? HttpResponseTypeMapper.toDio(options!.responseType)
            : null,
        followRedirects: false,
      ),
    );
  }

  @override
  Future<Either<HttpException, HttpResponse>> get(
    String path, {
    HttpOptions? options,
  }) async {
    return _mapResponse(() {
      return _fetch(
        path: path,
        method: 'GET',
        options: options,
      );
    });
  }

  @override
  Future<Either<HttpException, HttpResponse>> post(
    String path, {
    HttpOptions? options,
  }) async {
    return _mapResponse(() {
      return _fetch(
        path: path,
        method: 'POST',
        options: options,
      );
    });
  }

  @override
  Future<Either<HttpException, HttpResponse>> put(
    String path, {
    HttpOptions? options,
  }) async {
    return _mapResponse(() {
      return _fetch(
        path: path,
        method: 'PUT',
        options: options,
      );
    });
  }

  @override
  Future<Either<HttpException, HttpResponse>> patch(
    String path, {
    HttpOptions? options,
  }) async {
    return _mapResponse(() {
      return _fetch(
        path: path,
        method: 'PATCH',
        options: options,
      );
    });
  }

  @override
  Future<Either<HttpException, HttpResponse>> delete(
    String path, {
    HttpOptions? options,
  }) async {
    return _mapResponse(() {
      return _fetch(
        path: path,
        method: 'DELETE',
        options: options,
      );
    });
  }

  Future<Either<HttpException, HttpResponse>> _mapResponse(
    Future<Response> Function() request,
  ) async {
    try {
      final dioResponse = await request();

      return dioResponse.toClient();
    } on DioException catch (e) {
      return left(e.toClient());
    }
  }
}
