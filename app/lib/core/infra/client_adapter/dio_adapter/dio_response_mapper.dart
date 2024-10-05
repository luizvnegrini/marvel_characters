import 'package:external_dependencies/external_dependencies.dart';

import '../../infra.dart';

extension DioResponseMapper on Response {
  Either<HttpException, HttpResponse> toClient() {
    final statusCode = this.statusCode;
    if (statusCode == null) {
      return left(
        HttpException.unknown(
          request: requestOptions.toClient(),
        ),
      );
    }

    return right(
      HttpResponse(
        statusCode: statusCode,
        body: data,
        request: requestOptions.toClient(),
        statusMessage: statusMessage,
      ),
    );
  }
}
