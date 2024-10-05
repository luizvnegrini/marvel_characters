import 'dart:ui';

/// Extension to convert hexadecimal strings to [Color] objects.
// ignore: prefer_match_file_name
extension HexColor on String {
  static const int _hexColorLength = 6;
  static const int _hexColorLengthWithHash = 7;
  static const String _alphaChannel = 'ff';
  static const String _hashSymbol = '#';
  static const int _hexRadix = 16;

  /// Converts a hexadecimal string to a [Color] object.
  /// Returns a [Color] object representing the hexadecimal color.
  /// Throws a [FormatException] if the string cannot be parsed as a valid
  ///  hexadecimal number.
  Color get toColor {
    final buffer = StringBuffer();
    if (length == _hexColorLength || length == _hexColorLengthWithHash) {
      buffer.write(_alphaChannel);
    }
    buffer.write(replaceFirst(_hashSymbol, ''));

    return Color(int.parse(buffer.toString(), radix: _hexRadix));
  }
}
