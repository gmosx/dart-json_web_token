import 'package:unittest/unittest.dart';

import 'package:json_web_token/base64url.dart';

void main() {
  group("The BASE64URL codec", () {
    final b64a = "Hello there, it works".codeUnits;
    final b64b = "Let's try to get a pad".codeUnits;

    test("encodes base64 strings", () {
      expect(BASE64URL.encoder.convertFromBase64String("Adsd=+-//as"), equals("Adsd--__as"));
      expect(BASE64URL.encode(b64a), equals("SGVsbG8gdGhlcmUsIGl0IHdvcmtz"));
      expect(BASE64URL.encode(b64b), equals("TGV0J3MgdHJ5IHRvIGdldCBhIHBhZA"));
    });

    test("decodes base64 strings", () {
      expect(BASE64URL.decoder.convertToBase64String("Adsd-__as"), equals("Adsd+//as==="));
      expect(BASE64URL.decode(BASE64URL.encode(b64a)), equals(b64a));
      expect(BASE64URL.decode(BASE64URL.encode(b64b)), equals(b64b));
    });
  });
}