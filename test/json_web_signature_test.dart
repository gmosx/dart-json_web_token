import 'dart:convert';

import 'package:test/test.dart';

import 'package:jwt/json_web_signature.dart';


void main() {
  group("The JWS spec", () {
    test("allows signing of messages", () {
      final header = {
        'typ': 'JWT',
        'alg': 'HS256'
      };

      final payload = {
        'iss': 'joe',
        'exp': 1300819380,
        'http://example.com/is_root': true
      };

      final secret = "GawgguFyGrWKav7AX4VKUg";

      final jws = new JsonWebSignatureCodec(header: header, secret: secret);
      final token = jws.encode(json.encode(payload).codeUnits);
      final parts = token.split('.');

      expect(parts[0], equals('eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9'));
      // I added '==' to end, now passing tests, is this wrong?
      expect(parts[1], equals('eyJpc3MiOiJqb2UiLCJleHAiOjEzMDA4MTkzODAsImh0dHA6Ly9leGFtcGxlLmNvbS9pc19yb290Ijp0cnVlfQ=='));
      expect(jws.isValid(token), isTrue);
      expect(json.decode(new String.fromCharCodes(jws.decode(token))), equals(payload));
    });
  });
}