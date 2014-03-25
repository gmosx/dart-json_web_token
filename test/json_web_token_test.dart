import 'package:unittest/unittest.dart';

import 'package:jwt/json_web_token.dart';


void main() {
  group("The JWT spec", () {
    test("allows creation of authentication tokens", () {
      final payload = {
        'iss': 'joe',
        'exp': 1300819380,
        'http://example.com/is_root': true
      };

      final secret = "GawgguFyGrWKav7AX4VKUg";

      final jwt = new JsonWebTokenCodec(secret: secret);
      final token = jwt.encode(payload);
      final parts = token.split('.');

      expect(parts[0], equals('eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9'));
      expect(parts[1], equals('eyJpc3MiOiJqb2UiLCJleHAiOjEzMDA4MTkzODAsImh0dHA6Ly9leGFtcGxlLmNvbS9pc19yb290Ijp0cnVlfQ'));
      expect(jwt.isValid(token), isTrue);
      expect(jwt.decode(token), equals(payload));
    });
  });
}