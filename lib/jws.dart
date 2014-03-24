/**
 * [JSON Web Signature spec](http://self-issued.info/docs/draft-ietf-jose-json-web-signature.html)
 */
library json_web_signature;

import 'package:crypto/crypto.dart';

import 'base64url.dart' show Base64Url;

String _formatMessage(Map<String, Object>header, payload) {
  return '${Base64Url.encode(header)}.${Base64Url.encode(payload)}';
}

String sign(Map<String, Object> header, payload, String secret) {
  return "Singature";
}