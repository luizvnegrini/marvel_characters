import '../../domain/domain.dart';

class ThumbnailMapper {
  static Thumbnail fromJson(Map<String, dynamic> json) => Thumbnail(
        path: json['path'],
        extension: json['extension'],
      );
}
