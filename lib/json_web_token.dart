/**
 * [JSON Web Token spec](http://self-issued.info/docs/draft-ietf-oauth-json-web-token.html)
 */
library json_web_token;


import 'dart:convert';

import 'json_web_signature.dart';


/**
 * JSON Web Signature encoder.
 */
class JwtEncoder extends Converter {
  static const _JWS_ENCODER = const JwsEncoder();

  const JwtEncoder();
  @override
  String convert(Map payload, {Map header, String secret}) {
    return _JWS_ENCODER.convert(JSON.encode(payload).codeUnits, header: header, secret: secret);
  }
}


/**
 * JSON Web Signature decoder.
 */
class JwtDecoder extends Converter {
  static const _JWS_DECODER = const JwsDecoder();

  const JwtDecoder();

  bool isValid(String input, String secret) => _JWS_DECODER.isValid(input, secret);

  @override
  Map convert(String token, {Map header, String secret}) {
    return JSON.decode(new String.fromCharCodes(_JWS_DECODER.convert(token, secret: secret)));
  }
}


/**
 * JSON Web Token codec.
 */
class JwtCodec extends Codec {
  static const _DEFAULT_HEADER = const {
    'typ': 'JWT',
    'alg': 'HS256'
  };

  final Map _header;
  final String _secret;

  const JwtCodec({Map header, String secret}) :
      _header = header != null ? header : _DEFAULT_HEADER,
      _secret = secret;

  @override
  JwtEncoder get encoder => const JwtEncoder();

  @override
  JwtDecoder get decoder => const JwtDecoder();

  @override
  String encode(Map payload, {Map header, String secret}) {
    return encoder.convert(payload, header: (header != null ? header : _header),
        secret: (secret != null ? secret : _secret));
  }

  @override
  Map decode(String input, {String secret}) {
    return decoder.convert(input, secret: (secret != null ? secret : _secret));
  }

  bool isValid(String input, {String secret}) {
    return decoder.isValid(input, secret != null ? secret : _secret);
  }
}