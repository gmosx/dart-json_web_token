/**
 * [JSON Web Signature](http://self-issued.info/docs/draft-ietf-jose-json-web-signature.html)
 */
library json_web_signature;


import 'dart:convert';

import 'package:crypto/crypto.dart';

// import 'base64url.dart' show BASE64URL;


/**
 * JSON Web Signature encoder.
 */
class JsonWebSignatureEncoder extends Converter<List<int>,String> {
  const JsonWebSignatureEncoder();
  @override
  String convert(List<int> payload, {Map header, String secret}) {
    // print(JSON.encode(header));
    print(json.encode(header));
    // final msg = '${BASE64URL.encode(JSON.encode(header).codeUnits)}.${BASE64URL.encode(payload)}';
    final msg = '${base64Url.encode(json.encode(header).codeUnits)}.${base64Url.encode(payload)}';
    return "${msg}.${_signMessage(msg, secret)}";
  }
}


/**
 * JSON Web Signature decoder.
 */
class JsonWebSignatureDecoder extends Converter<String,List<int>>{
  const JsonWebSignatureDecoder();

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
      return base64Url.decode(payload);
    } else {
      throw new ArgumentError("Invalid signature");
    }
  }
}


/**
 * JSON Web Signature codec.
 */
class JsonWebSignatureCodec extends Codec<List<int>,String> {
  final Map _header;
  final String _secret;

  const JsonWebSignatureCodec({Map header, String secret}) :
      _header = header,
      _secret = secret;

  @override
  JsonWebSignatureEncoder get encoder => const JsonWebSignatureEncoder();

  @override
  JsonWebSignatureDecoder get decoder => const JsonWebSignatureDecoder();

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
  Hmac hmac = Hmac( sha256 , secret.codeUnits);
  // hmac.add(msg.codeUnits);
  Digest digest = hmac.convert(msg.codeUnits);
  // final signature = hmac.close();
  // return BASE64URL.encode(signature);
  return base64Url.encode(digest.bytes);
}