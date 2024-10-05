import 'package:external_dependencies/external_dependencies.dart';

import '../../infra.dart';

class DioInterceptor extends Interceptor {
  final HttpInterceptor clientInterceptor;

  DioInterceptor(this.clientInterceptor);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    clientInterceptor.onRequest(
      options.toClient(),
      HttpRequestHandler(
        nextHandler: (request) {
          handler.next(HttpRequestMapper.toDio(request));
        },
        resolveHandler: (response) {
          handler.resolve(HttpResponseMapper.toDio(response));
        },
        rejectHandler: (exception) {
          handler.reject(HttpExceptionMapper.toDio(exception));
        },
      ),
    );
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    clientInterceptor.onResponse(
      HttpResponseMapper.toClient(response),
      HttpResponseHandler(
        nextHandler: (response) {
          handler.next(HttpResponseMapper.toDio(response));
        },
        resolveHandler: (response) {
          handler.resolve(HttpResponseMapper.toDio(response));
        },
      ),
    );
  }
}
