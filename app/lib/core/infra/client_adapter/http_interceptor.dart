import 'http_exception.dart';
import 'http_request.dart';
import 'http_response.dart';

class HttpRequestHandler {
  final void Function(HttpRequest) nextHandler;
  final void Function(HttpResponse) resolveHandler;
  final void Function(HttpException) rejectHandler;

  const HttpRequestHandler({
    required this.nextHandler,
    required this.resolveHandler,
    required this.rejectHandler,
  });

  void next(HttpRequest request) {
    nextHandler(request);
  }

  void resolve(HttpResponse response) {
    resolveHandler(response);
  }

  void reject(HttpException exception) {
    rejectHandler(exception);
  }
}

class HttpResponseHandler {
  final void Function(HttpResponse) nextHandler;
  final void Function(HttpResponse) resolveHandler;

  const HttpResponseHandler({
    required this.nextHandler,
    required this.resolveHandler,
  });

  void next(HttpResponse response) {
    nextHandler(response);
  }

  void resolve(HttpResponse response) {
    resolveHandler(response);
  }
}

abstract class HttpInterceptor {
  const HttpInterceptor();

  Future onRequest(HttpRequest request, HttpRequestHandler handler) async {
    handler.next(request);
  }

  Future onResponse(HttpResponse response, HttpResponseHandler handler) async {
    handler.next(response);
  }
}