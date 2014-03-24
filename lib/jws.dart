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

String _formatMessage(Map<String, Object>header, payload) {
  return '${BASE64URL.encode(_toCodeUnits(header))}.${BASE64URL.encode(_toCodeUnits(payload))}';
}

/**
 *
 */
String sign(Map<String, Object> header, payload, secret) {
  final msg = _formatMessage(header, payload);
  final hmac = new HMAC(new SHA256(), secret.codeUnits);
  hmac.add(msg.codeUnits);
  final signature = hmac.close();
  return "${msg}.${BASE64URL.encode(signature)}";
}

/**
 *
 */
Object verify(String token) {
  return null;
}