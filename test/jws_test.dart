import 'package:unittest/unittest.dart';

import 'package:jwt/jws.dart' as jws;

void main() {
  group("The JWS", () {
    test("signs messages", () {
      final header = {
        'typ': 'JWT',
        'alg': 'HS256'
      };

      final payload = {
        'iss': 'joe',
        'exp': 1300819380,
        'http://example.com/is_root': true
      };

      print(jws.sign(header, payload, "GawgguFyGrWKav7AX4VKUg"));
    });
  });
}