/**
 * [JSON Web Signature](http://self-issued.info/docs/draft-ietf-jose-json-web-signature.html)
 */
library json_web_signature;


import 'dart:convert';

import 'package:crypto/crypto.dart';

import 'base64url.dart' show BASE64URL;


/**
 * JSON Web Signature encoder.
 */
class JwsEncoder extends Converter {
  const JwsEncoder();
  @override
  String convert(List<int> payload, {Map header, String secret}) {
    print(JSON.encode(header));
    final msg = '${BASE64URL.encode(JSON.encode(header).codeUnits)}.${BASE64URL.encode(payload)}';
    return "${msg}.${_signMessage(msg, secret)}";
  }
}


/**
 * JSON Web Signature decoder.
 */
class JwsDecoder extends Converter {
  const JwsDecoder();

  bool isValid(String input, String secret) {
    final parts = input.split('.'),
          header = parts[0],
          payload = parts[1],
          signature = parts[2];

    return _verifyParts(header, payload, signature, secret);
  }

  bool _verifyParts(String header, String payload, String signature, String secret) {
    return signature == _signMessage('${header}.${payload}', secret);
  }

  @override
  List<int> convert(String input, {String secret}) {
    final parts = input.split('.'),
          header = parts[0],
          payload = parts[1],
          signature = parts[2];

    if (_verifyParts(header, payload, signature, secret)) {
      return BASE64URL.decode(payload);
    } else {
      throw new ArgumentError("Invalid signature");
    }
  }
}


/**
 * JSON Web Signature codec.
 */
class JwsCodec extends Codec {
  final Map _header;
  final String _secret;

  const JwsCodec({Map header, String secret}) :
      _header = header,
      _secret = secret;

  @override
  JwsEncoder get encoder => const JwsEncoder();

  @override
  JwsDecoder get decoder => const JwsDecoder();

  @override
  String encode(List<int> payload, {Map header, String secret}) {
    return encoder.convert(payload, header: (header != null ? header : _header),
        secret: (secret != null ? secret : _secret));
  }

  @override
  List<int> decode(String input, {String secret}) {
    return decoder.convert(input, secret: (secret != null ? secret : _secret));
  }

  bool isValid(String input, {String secret}) {
    return decoder.isValid(input, secret != null ? secret : _secret);
  }
}


String _signMessage(String msg, String secret) {
  final hmac = new HMAC(new SHA256(), secret.codeUnits);
  hmac.add(msg.codeUnits);
  final signature = hmac.close();
  return BASE64URL.encode(signature);
}