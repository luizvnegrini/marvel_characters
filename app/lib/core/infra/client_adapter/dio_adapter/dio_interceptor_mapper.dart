import 'package:external_dependencies/external_dependencies.dart';

import '../../infra.dart';

abstract class DioInterceptorMapper {
  static Interceptor toDio(HttpInterceptor interceptor) {
    return DioInterceptor(interceptor);
  }
}
