/**
 * [JSON Web Signature](http://self-issued.info/docs/draft-ietf-jose-json-web-signature.html)
 */
library json_web_signature;

import 'dart:convert' show JSON;

import 'package:crypto/crypto.dart';

import 'base64url.dart' show BASE64URL;

List<int> _toCodeUnits(Object obj) {
  if (obj is Map) {
    return JSON.encode(obj).codeUnits;
  } else {
    return obj.toString().codeUnits;
  }
}

String _signMessage(String msg, String secret) {
  final hmac = new HMAC(new SHA256(), secret.codeUnits);
  hmac.add(msg.codeUnits);
  final signature = hmac.close();
  return BASE64URL.encode(signature);
}

/**
 *
 */
String sign(Map<String, Object> header, Object payload, String secret) {
  final msg = '${BASE64URL.encode(_toCodeUnits(header))}.${BASE64URL.encode(_toCodeUnits(payload))}';
  return "${msg}.${_signMessage(msg, secret)}";
}

/**
 *
 */
bool verify(String token, String secret) {
  final parts = token.split('.'),
        header = parts[0],
        payload = parts[1],
        signature = parts[2];

  return signature == _signMessage('${header}.${payload}', secret);
}

/**
 *
 */
Map decode(String token) {
  final parts = token.split('.'),
        header = parts[0],
        payload = parts[1];

  return JSON.decode(new String.fromCharCodes(BASE64URL.decode(payload)));
}