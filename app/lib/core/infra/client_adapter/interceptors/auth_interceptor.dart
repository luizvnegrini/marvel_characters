import 'dart:convert';

import 'package:crypto/crypto.dart' as crypto;

import '../../../core.dart';

class AuthInterceptor extends HttpInterceptor {
  @override
  Future onRequest(HttpRequest request, HttpRequestHandler handler) async {
    final ts = DateTime.now().millisecondsSinceEpoch.toString();

    request.queryParameter?.addAll({
      'apikey': Envs.publicKey,
      'ts': ts,
      'hash': _md5('$ts${Envs.privateKey}${Envs.publicKey}'),
    });

    return super.onRequest(request, handler);
  }
}

String _md5(String value) {
  return crypto.md5.convert(utf8.encode(value)).toString();
}
