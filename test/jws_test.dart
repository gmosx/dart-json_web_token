import 'package:unittest/unittest.dart';

import 'package:jwt/jws.dart' as jws;

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

      final token = jws.sign(header, payload, secret);

      print(token);
      print(jws.verify(token, secret));
      print(jws.decode(token));
    });
  });
}