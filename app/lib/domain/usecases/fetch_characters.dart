import 'package:external_dependencies/external_dependencies.dart';

import '../../core/core.dart';

abstract class FetchCharacters {
  Either<Failure, String> call();
}

class GenerateNewColorImpl implements FetchCharacters {
  @override
  Either<Failure, String> call() {
    try {
      throw UnimplementedError();
    } catch (e) {
      return Left(Failure(type: ExceptionType.unexpected));
    }
  }
}
