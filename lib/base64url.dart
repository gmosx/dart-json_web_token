/**
 * Base64Url conversions.
 *
 * [Inspiration](https://github.com/brianloveswords/base64url/blob/master/index.js)
 */
library base64url;

import 'dart:convert';

import 'package:crypto/crypto.dart';

final _EQ_RE = new RegExp(r'=');
final _PLUS_RE = new RegExp(r'\+');
final _SLASH_RE = new RegExp(r'\/');
final _MINUS_RE = new RegExp(r'\-');
final _US_RE = new RegExp(r'_');

/**
 * Convert a Base64 string to a Base64Url string.
 */
class Base64UrlEncoder extends Converter {
  const Base64UrlEncoder();

  @override
  String convert(List<int> input) {
    return convertFromBase64String(CryptoUtils.bytesToBase64(input));
  }

  String convertFromBase64String(String input) {
    return input
        .replaceAll(_EQ_RE, '') // remove the trailing padding.
        .replaceAll(_PLUS_RE, '-')
        .replaceAll(_SLASH_RE, '_');
  }
}

/**
 * Convert a Base64Url sring to a Base64 string.
 */
class Base64UrlDecoder extends Converter {
  static const _SEGMENT_LENGTH = 4;

  const Base64UrlDecoder();

  @override
  List<int> convert(String input) {
    return CryptoUtils.base64StringToBytes(convertToBase64String(input));
  }

  String convertToBase64String(String input) {
    return _padString(input)
        .replaceAll(_MINUS_RE, '+')
        .replaceAll(_US_RE, '/');
  }

  String _padString(String input) {
    final diff = input.length % _SEGMENT_LENGTH;

    if (diff == 0) {
      return input;
    }

    var padLength = _SEGMENT_LENGTH - diff;

    final sb = new StringBuffer(input);

    while (padLength-- > 0) {
      sb.write('=');
    }

    return sb.toString();
  }
}

/**
 * A converter between Base64 and Base64Url encodings.
 */
class Base64UrlCodec extends Codec {
  const Base64UrlCodec();

  @override
  Converter get encoder => const Base64UrlEncoder();

  @override
  Converter get decoder => const Base64UrlDecoder();
}

const Base64Url = const Base64UrlCodec();