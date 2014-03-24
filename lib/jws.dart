/**
 * [JSON Web Signature](http://self-issued.info/docs/draft-ietf-jose-json-web-signature.html)
 */
library json_web_signature;

import 'dart:convert' show JSON;

import 'package:crypto/crypto.dart';

import 'base64url.dart' show BASE64URL;

String _toCodeUnits(Object obj) {
  if (obj is Map) {
    return JSON.encode(obj);
  } else {
    return obj.toString();
  }
}

String _formatMessage(Map<String, Object>header, payload) {
  return '${BASE64URL.encode(_toCodeUnits(header))}.${BASE64URL.encode(_toCodeUnits(payload))}';
}

String sign(Map<String, Object> header, payload, String secret) {
  return "Singature";
}